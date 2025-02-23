package com.project.app.inquire.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

/*
	문의 VO
*/

@Getter
@Setter
public class InquireVO {
	private String pk_inquire_no;           // 문의 번호
	private String fk_member_no;            // 회원 번호
	private String inquire_title;           // 문의 제목
	private String inquire_content;         // 문의 내용
	private String inquire_filename;        // 문의 첨부파일명
	private String inquire_orgfilename;     // 문의 첨부파일원본명
	private String inquire_file_size;       // 문의 첨부파일크기
	private String inquire_status;          // 문의 완료 여부 (0:미완료 1:완료)
	private String inquire_secret;          // 문의 공개여부 (0:공개 1:비공개)
	private String inquire_regdate;         // 문의 날짜
	private MultipartFile attach;
	
	private String member_name; // 유저이름
}
