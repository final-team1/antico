package com.project.app.comment.model;


import org.apache.ibatis.annotations.Mapper;

import com.project.app.comment.domain.CommentVO;

@Mapper
public interface CommentDAO {

	// 파일첨부가 없는 답변
	int add_comment(CommentVO comment_vo);
	
	// 파일첨부가 있는 답변
	int add_file_comment(CommentVO comment_vo);

	// tbl_comment 테이블에서 fk_parent_no 컬럼의 최대값 알아오기
	int get_fk_parent_no(String fk_inquire_no);

	// 관리자가 답변할 시 답변완료로 업데이트
	int update_inquire_status(String fk_inquire_no);

	// 유저가 답변할 시 미답변으로 업데이트
	int update_inquire_status_member(String fk_inquire_no);

	

	

}
