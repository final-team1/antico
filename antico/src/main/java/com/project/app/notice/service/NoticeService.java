package com.project.app.notice.service;

import java.util.List;

import com.project.app.notice.domain.NoticeVO;

public interface NoticeService {

	// 공지사항 조회
	List<NoticeVO> NoticeListSearch();

}