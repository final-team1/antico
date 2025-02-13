package com.project.app.member.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	
	private String pk_mem_no;				// 사용자 일련번호
	private String mem_regdate;				// 사용자 등록일
	private String mem_user_id;				// 사용자 아이디
	private String mem_passwd;				// 사용자 비밀번호
	private String mem_tel;					// 사용자 전화번호
	private String mem_passwd_change_date;	// 사용자 최근 비밀번호 변경일
	private String mem_authorization;		// 사용자 권한 (0 : 브론즈, 1 : 실버, 2 : 골드, 3 : 부 관리자, 4 : 주 관리자)
	private String mem_score;				// 사용자 점수 (등급 점수, 브론즈 : 0 ~ 99, 실버 : 100 ~ 199, 골드 : 200 ~)
	private String mem_point;				// 사용자 포인트
	private String mem_status; 				// 사용자 상태 (0 : 탈퇴, 1 : 가입, 2 : 정지)
	
}
