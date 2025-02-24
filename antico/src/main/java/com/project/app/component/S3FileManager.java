package com.project.app.component;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.common.FileType;
import com.project.app.exception.ExceptionCode;
import com.project.app.exception.S3Exception;

import lombok.RequiredArgsConstructor;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

/*
 * aws s3 파일 업로드 컴포넌트
 */
@Component
@RequiredArgsConstructor
public class S3FileManager {
	
	// S3 버켓명
	@Value("${cloud.aws.s3.bucket}")
	private String bucket_name;
	
	// S3 리전
	@Value("${cloud.aws.region.static}")
	private String region; 

	// AWS S3 API
	private final S3Client s3Client;

	/*
	 * 파일 검증 후 S3 업로드 요청
	 */
	public Map<String, String> upload(MultipartFile file, String dir_name, FileType file_type) {
		String org_file_name = file.getOriginalFilename(); // 파일 원본병
		String directory = dir_name + "/"; // 이미지를 첨부했던 기능에 따라 달라지는 디렉토리명 ex)'review'
		Map<String, String> map = new HashMap<>();
		
		// 입력받은 파일이 빈 파일인지 검증
		if (file.isEmpty() || StringUtils.isBlank(org_file_name)) {
			throw new S3Exception(ExceptionCode.FILE_IS_EMPTY);
		}

		// 파일이 지정된 확장자인지 확인
		validateFileExtention(org_file_name, file_type);

		try {
			String file_name = uploadFileToS3(file, directory); // 파일을 S3에 업로드
			map.put("org_file_name", org_file_name);
			map.put("file_name", file_name);
			
			return map;
		}
		catch (IOException e) {
			throw new S3Exception(ExceptionCode.PUT_OBJECT_EXCEPTION);
		}
	}
	
	/*
	 * 다중 파일 검증 후 S3 업로드 요청
	 */
	public List<Map<String, String>> upload(List<MultipartFile> file_list, String dir_name, FileType file_type) {
		List<Map<String, String>> map_list = new ArrayList<>(); // 파일명, 원본 파일명 목록 반환 리스트
		
		// 반복문을 통해 파일 업로드 후 파일명, 원본 파일명 목록 반환 리스트 반환
		for(MultipartFile file : file_list) {
			Map<String, String> map = upload(file, dir_name, file_type);
			map_list.add(map);
		}
		
		return map_list;
	}

	/*
	 * 파일 검증
	 */
	private void validateFileExtention(String file_name, FileType file_type) {
		int last_index = file_name.lastIndexOf("."); // 파일명 뒤의 확장자 앞에 위치한 '.' 인덱스

		// 확장자가 존재하지 않으면 예외 처리
		if (last_index == -1) {
			throw new S3Exception(ExceptionCode.FILE_IS_EMPTY);
		}

		// 첨부 파일이 모든 형태를 허용하지 않는다면 확장자 검사
		if(file_type != FileType.ALL) {
			// 원본 파일명에서 확장자 추출
			String extension = file_name.substring(last_index + 1).toLowerCase();
			// FileType에서 지정한 확장자명 리스트
			List<String> allowedExtensionList = file_type.getFileExtension();

			// 지정된 확장자가 아닌 경우 예외
			if (!allowedExtensionList.contains(extension)) {
				throw new S3Exception(ExceptionCode.INVALID_FILE_EXTENSION);
			}
		}
	}

	/*
	 * AWS S3로 파일 업로드
	 */
	private String uploadFileToS3(MultipartFile file, String directory_path) throws IOException {
		String org_File_name = file.getOriginalFilename();

		// 현재 시각(나노초 까지) + 원본 파일명을 합친 새로운 파일명 생성
		String file_name = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance()) + System.nanoTime() + org_File_name;

		// InputStream가 AutoCloseable 인터페이스 구현체이기에 try-with-resource 구문 사용
		try (InputStream is = file.getInputStream()) {
			// s3client put 요청 객체 생성
			RequestBody request_body = RequestBody.fromInputStream(is, file.getSize());

			PutObjectRequest put_object_request = PutObjectRequest.builder()
					.bucket(bucket_name)
					.key(directory_path + file_name)
					.build();
										
			s3Client.putObject(put_object_request, request_body);
			  
			// 업로드를 성공하면 파일이 저장된 url을 반환
			String url = "https://"+ bucket_name + ".s3." + region +".amazonaws.com/" + directory_path + file_name;
			
			return url;
			
		} catch (IOException e) {
			throw new S3Exception(ExceptionCode.IO_EXCEPTION_FILE_UPLOAD);
		}
	}

	/*
	 * s3 파일 삭제
	 */
	public void deleteImageFromS3(String file_name) {
		try {
			int last_index = file_name.lastIndexOf(".amazonaws.com/"); // 디렉토리 + s3 저장파일명 시작 인덱스
			
			String key = file_name.substring(last_index + 16); // s3에 저장된 파일명 추출
			
			// s3client delete 요청 객체 생성
			DeleteObjectRequest delete_object_request = DeleteObjectRequest.builder()
					.bucket(bucket_name)
					.key(key)
					.build();
			
			s3Client.deleteObject(delete_object_request);
		} catch (Exception e) {
			throw new S3Exception(ExceptionCode.IO_EXCEPTION_FILE_DELETE);
		}
	}

}
