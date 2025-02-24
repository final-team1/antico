package com.project.app.notice.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.common.PagingDTO;
import com.project.app.notice.domain.NoticeVO;

@Mapper
public interface NoticeDAO {
	
	// 공지사항 조회
	List<NoticeVO> notice_list(Map<String, Object> paraMap);
	
	// 검색어 입력시 자동글 완성하기
	List<String> notice_searchshow(Map<String, String> paraMap);

	// 공지사항 총 개수
	int getNoticeCount(Map<String, Object> paraMap);

	// 파일다운로드를 위한 조회
	NoticeVO getnotice_file(Map<String, String> paraMap);


	

}