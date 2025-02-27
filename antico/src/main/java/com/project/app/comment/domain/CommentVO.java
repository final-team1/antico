package com.project.app.comment.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

/*
	답변 VO
*/

@Getter
@Setter
public class CommentVO {
	private String pk_comment_no;            // 답변 번호
	private String fk_parent_no;             // 부모 답변 번호
	private String fk_inquire_no;            // 문의 번호
	private String fk_member_no;             // 회원 번호
	private String comment_group_no;         // 답변그룹번호
	private String comment_depth_no;         // 답변레벨
	private String comment_content;          // 답변 내용
	private String comment_regdate;          // 답변날짜
	private String comment_filename;         // 답변 첨부파일명
	private String comment_orgfilename;      // 답변 원본첨부파일명
	private String comment_filesize;         // 답변 첨부파일크기
	
	private String member_name; // 유저이름
	
	List<MultipartFile> attach;

}
