package com.project.app.inquire.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.comment.domain.CommentVO;
<<<<<<< HEAD
=======
import com.project.app.common.FileType;
import com.project.app.component.S3FileManager;
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
import com.project.app.inquire.domain.InquireVO;
import com.project.app.inquire.model.InquireDAO;

@Service
public class InquireService_imple implements InquireService {

	@Autowired
	private InquireDAO dao;

<<<<<<< HEAD
=======
	@Autowired
	private S3FileManager s3FileManager;
	
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
	// 문의 내역 조회
	@Override
	public List<InquireVO> inquire_list() {
		List<InquireVO> inquire_list = dao.inquire_list();
		return inquire_list;
	}
	
	// 파일첨부가 없는 경우의 1:1문의
	@Override
	public int add(InquireVO inquirevo) {
		int n = dao.add(inquirevo);
		return n;
	}

	// 파일첨부가 있는 경우의 1:1문의
	@Override
	public int add_withFile(InquireVO inquirevo, MultipartFile attach) {
		
		// 1. 파일 업로드 처리: 파일을 S3에 업로드하고 반환된 맵에서 파일명 정보 추출
	    Map<String, String> file_map = s3FileManager.upload(attach, "inquire", FileType.ALL);
	    
	    inquirevo.setInquire_orgfilename(file_map.get("org_file_name"));
	    inquirevo.setInquire_filename(file_map.get("file_name"));
		
		int n = dao.add_withFile(inquirevo); // 첨부파일이 있는 경우
		return n;
	}

	// 문의 상세보기
	@Override
	public InquireVO inquire_detail(Map<String, String> paraMap) {
		InquireVO inquirevo = dao.inquire_detail(paraMap); // 글 1개 조회하기
		return inquirevo;
	}

	// 답변 조회
	@Override
	public List<CommentVO> inquire_comment(String pk_inquire_no) {
		List<CommentVO> comment_list = dao.get_inquire_comment(pk_inquire_no);		
		return comment_list;
	}



}
