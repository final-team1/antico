package com.project.app.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.notice.domain.NoticeVO;
import com.project.app.notice.model.NoticeDAO;

@Service
public class NoticeService_imple implements NoticeService {

	@Autowired
	private NoticeDAO dao;

	// 공지사항 조회
	@Transactional(readOnly = true)
	@Override
	public List<NoticeVO> notice_list() {
		List<NoticeVO> notice_list = dao.notice_list();		
		return notice_list;
	}

}