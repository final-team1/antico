package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 탈퇴 VO
 */

@Getter
@Setter
public class LeaveVO {

	private String pk_leave_no; // 탈퇴번호
	
	private String fk_member_no; // 회원번호
	
	private String leave_reason; // 탈퇴사유
	
	private String leave_date; // 탈퇴일자
	
}
