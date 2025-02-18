package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 임시 로그인기록 VO
 */

@Getter
@Setter
public class LoginHistoryVO {

	private String pk_login_history_no; // 로그인 기록 번호
	
	private String fk_member_no; // 회원번호
	
	private String login_history_user_ip; // 회원 아이피
	
	private String login_history_date; // 로그인 시간
	
}
