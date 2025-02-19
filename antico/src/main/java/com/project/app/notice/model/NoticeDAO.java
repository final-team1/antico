package com.project.app.notice.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.notice.domain.NoticeVO;

@Mapper
public interface NoticeDAO {
	
	// 공지사항 조회
	List<NoticeVO> notice_list(Map<String, String> paraMap);

	// 검색어 입력시 자동글 완성하기
	List<String> notice_searchshow(Map<String, String> paraMap);

}