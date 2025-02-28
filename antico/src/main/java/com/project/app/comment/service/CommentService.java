package com.project.app.comment.service;

import org.springframework.web.multipart.MultipartFile;

import com.project.app.comment.domain.CommentVO;

public interface CommentService {

	// 파일첨부가 없는 답변
	int add_comment(CommentVO comment_vo);
	
	// 파일첨부가 있는 답변
	int add_file_comment(CommentVO comment_vo, MultipartFile attach);

	


}
