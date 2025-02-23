package com.project.app.notice.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

/*
	공지사항 VO
*/

@Getter
@Setter
public class NoticeVO {
	private String pk_notice_no;           // 공지사항 번호
	private String fk_member_no;           // 관리자 번호
	private String notice_title;           // 공지사항 제목
	private String notice_content;         // 공지사항 내용
	private String notice_filename;    	   // 공지사항 첨부파일명
	private String notice_orgfilename;     // 공지사항 첨부파일원본명
	private String notice_filesize;        // 공지사항 첨부파일 크기
	private String notice_views;           // 공지사항 조회수
	private String notice_date;            // 공지사항 작성일
	private String notice_update_date;     // 공지사항 수정일
	private MultipartFile attach;
}