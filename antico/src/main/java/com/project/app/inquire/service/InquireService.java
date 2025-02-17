package com.project.app.inquire.service;

import java.util.List;

import com.project.app.inquire.domain.InquireVO;

public interface InquireService {

	// 문의 내역 조회
	List<InquireVO> inquire_list();
	
	// 파일첨부가 없는 경우의 1:1문의
	int add(InquireVO inquirevo);

	// 파일첨부가 있는 경우의 1:1문의
	int add_withFile(InquireVO inquirevo);

	

}
