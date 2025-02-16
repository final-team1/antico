package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 포인트내역 VO
 */

@Getter
@Setter
public class PointHistory {

	private String pk_point_history_no; // 포인트내역번호
	
	private String fk_member_no; // 회원번호
	
	private String point_history_reason; // 상세 내역
	
	private String point_history_point; // 포인트 증감값
	
	private String point_history_point_before; // 포인트 이전값
	
	private String point_history_point_after; // 포인트 이후값
	
	private String point_history_regdate; // 변경일자
	
}
