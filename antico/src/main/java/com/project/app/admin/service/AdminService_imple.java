package com.project.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.admin.model.AdminDAO;
import com.project.app.notice.domain.NoticeVO;

@Service
public class AdminService_imple implements AdminService {

	@Autowired
	private AdminDAO dao;

	// 파일첨부가 없는 공지사항 작성
	@Override
	public int add(NoticeVO noticevo) {
		int n = dao.add(noticevo);
		return n;
	}

	// 파일첨부가 있는 공지사항 작성
	@Override
	public int add_withFile(NoticeVO noticevo) {
		int n = dao.add_withFile(noticevo); // 첨부파일이 있는 경우
		return n;
	}

	// 미답변 1:1문의 리스트
	@Override
	public List<Map<String, String>> uninquire_list() {
		List<Map<String, String>> uninquire_list = dao.uninquire_list();	
		return uninquire_list;
	}
	
}
