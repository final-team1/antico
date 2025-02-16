package com.project.app.notice.domain;

import lombok.Getter;
import lombok.Setter;

/*
	공지사항 VO
*/

@Getter
@Setter
public class NoticeVO {
	private int pk_noti_no;          // 공지사항 번호
	private int fk_mem_no;           // 관리자 번호
	private String noti_title;       // 공지사항 제목
	private String noti_content;     // 공지사항 내용
	private String noti_filename;    // 공지사항 첨부파일명
	private String noti_orgfilename; // 공지사항 첨부파일원본명
	private int noti_filesize;       // 공지사항 첨부파일 크기
	private int noti_views;          // 공지사항 조회수
	private String noti_date;        // 공지사항 작성일
	private String noti_update_date; // 공지사항 수정일
}