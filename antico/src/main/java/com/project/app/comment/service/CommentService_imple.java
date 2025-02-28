package com.project.app.comment.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.comment.domain.CommentVO;
import com.project.app.comment.model.CommentDAO;
import com.project.app.common.FileType;
import com.project.app.component.S3FileManager;

@Service
public class CommentService_imple implements CommentService {

	@Autowired
	private CommentDAO dao;
	
	@Autowired
	private S3FileManager s3FileManager;
	
	// 파일첨부가 없는 답변
	@Override
	public int add_comment(CommentVO comment_vo) {
	    // pk_inquire_no에 대해 fk_parent_no 값을 구하고, 없으면 1부터 시작
	    if (comment_vo.getFk_parent_no() == null || comment_vo.getFk_parent_no().isEmpty()) {
	        int fk_parent_no = dao.get_fk_parent_no(comment_vo.getFk_inquire_no());
	        
	        // 만약 fk_parent_no가 0이면 첫 번째 댓글이므로 1로 설정
	        if (fk_parent_no == 0) {
	            fk_parent_no = 1; // 첫 댓글 작성 시 부모 번호는 1
	        } else {
	            fk_parent_no = fk_parent_no + 1; // 이후 댓글 작성 시 부모 번호는 max + 1
	        }

	        comment_vo.setFk_parent_no(String.valueOf(fk_parent_no));
	    }

	    int n = dao.add_comment(comment_vo);

	    // 댓글이 성공적으로 추가된 경우, 관리자 답변 처리
	    if (n == 1) {
	        // 관리자가 답변을 작성한 경우 inquire_status를 1로 업데이트
	        String fk_inquire_no = comment_vo.getFk_inquire_no();

	        if ("관리자".equals(comment_vo.getMember_name())) {
	            n = dao.update_inquire_status(fk_inquire_no);  // inquire_status를 1로 업데이트 관리자
	        }
	        else {
	        	 n = dao.update_inquire_status_member(fk_inquire_no);  // inquire_status를 0으로 업데이트 유저
	        }
	    }

	    return n;
	}

	// 파일첨부가 있는 답변
	@Override
	public int add_file_comment(CommentVO comment_vo, MultipartFile attach) {
	    // 1. 파일 업로드 처리: 파일을 S3에 업로드하고 반환된 맵에서 파일명 정보 추출
	    Map<String, String> file_map = s3FileManager.upload(attach, "comment", FileType.ALL);
	    
	    comment_vo.setComment_orgfilename(file_map.get("org_file_name"));
	    comment_vo.setComment_filename(file_map.get("file_name"));

	    if (comment_vo.getFk_parent_no() == null || comment_vo.getFk_parent_no().isEmpty()) {
	        int fk_parent_no = dao.get_fk_parent_no(comment_vo.getFk_inquire_no());
	        
	        if (fk_parent_no == 0) {
	            fk_parent_no = 1;
	        } 
	        else {
	            fk_parent_no = fk_parent_no + 1;
	        }
	        comment_vo.setFk_parent_no(String.valueOf(fk_parent_no));
	    }

	    int n = dao.add_file_comment(comment_vo);

	    if (n == 1) {
	        String fk_inquire_no = comment_vo.getFk_inquire_no();

	        if ("관리자".equals(comment_vo.getMember_name())) {
	            n = dao.update_inquire_status(fk_inquire_no);
	        }
	        else {
	            n = dao.update_inquire_status_member(fk_inquire_no);
	        }
	    }
	    return n;
	}





	


}
