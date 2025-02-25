package com.project.app.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.notice.domain.NoticeVO;
import com.project.app.notice.model.NoticeDAO;

@Service
public class NoticeService_imple implements NoticeService {

	@Autowired
	private NoticeDAO dao;

	// 공지사항 조회
	@Override public List<NoticeVO> notice_list(Map<String, Object> paraMap) {
		List<NoticeVO> notice_list = dao.notice_list(paraMap); 
		return notice_list; 
	}
	
	// 검색어 입력시 자동글 완성하기
	@Override
	public List<String> notice_searchshow(Map<String, String> paraMap) {
		List<String> notice_wordList = dao.notice_searchshow(paraMap);
		return notice_wordList;
	}

	// 공지사항 총 개수
	@Override
	public int getNoticeCount(Map<String, Object> paraMap) {
		int NoticeCount = dao.getNoticeCount(paraMap);
		return NoticeCount;
	}

	// 파일다운로드를 위한 조회
	@Override
	public NoticeVO getnotice_file(Map<String, String> paraMap) {
		NoticeVO notice_file = dao.getnotice_file(paraMap); // 글 1개 조회하기
		return notice_file;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}