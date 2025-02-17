package com.project.app.inquire.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.common.FileManager;
import com.project.app.inquire.domain.InquireVO;
import com.project.app.inquire.model.InquireDAO;

@Service
public class InquireService_imple implements InquireService {

	@Autowired
	private InquireDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
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
	public int add_withFile(InquireVO inquirevo) {
		int n = dao.add_withFile(inquirevo); // 첨부파일이 있는 경우
		return n;
	}



}
