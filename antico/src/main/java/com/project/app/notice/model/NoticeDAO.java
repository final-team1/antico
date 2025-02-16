package com.project.app.notice.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.notice.domain.NoticeVO;

@Mapper
public interface NoticeDAO {
	
	// 공지사항 조회
	List<NoticeVO> NoticeListSearch();

}