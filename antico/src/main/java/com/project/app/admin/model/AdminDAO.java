package com.project.app.admin.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.notice.domain.NoticeVO;

@Mapper
public interface AdminDAO {

	// 파일첨부가 없는 공지사항 작성
	int add(NoticeVO noticevo);

	// 파일첨부가 있는 공지사항 작성
	int add_withFile(NoticeVO noticevo);

	// 미답변 1:1문의 리스트
	List<Map<String, String>> uninquire_list();

	// 공지사항 총개수
	int getNoticeCount();

	// 공지사항 조회
	List<NoticeVO> notice_list(Map<String, Object> paraMap);

	// 공지사항 파일삭제
	NoticeVO getView_delete(String pk_notice_no);

	// 공지사항 삭제
	int notice_delete(String string);


}
