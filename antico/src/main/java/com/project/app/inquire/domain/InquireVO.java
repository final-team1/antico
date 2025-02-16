package com.project.app.inquire.domain;

import lombok.Getter;
import lombok.Setter;

/*
	문의 VO
*/

@Getter
@Setter
public class InquireVO {
	private int pk_inq_no;          // 문의 번호
	private int fk_mem_no;          // 회원 번호
	private String inq_title;       // 문의 제목
	private String inq_content;     // 문의 내용
	private String inq_filename;    // 문의 첨부파일명
	private String inq_orgfilename; // 문의 첨부파일원본명
	private int inq_filesize;       // 문의 첨부파일크기
	private int inq_status;         // 문의 완료 여부 (0:미완료 1:완료)
	private int inq_secret;         // 문의 공개여부 (0:공개 1:비공개)
	private String inq_regdate;     // 문의 날짜
}