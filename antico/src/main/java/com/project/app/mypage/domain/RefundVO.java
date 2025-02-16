package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 *  포인트 환급 VO
 */

@Getter
@Setter
public class RefundVO {
	
	private String pk_refund_no; // 정산 번호
	
	private String fk_account_no; // 계좌번호
	
	private String fk_member_no; // 회원번호
	
	private String refund_price; // 환급 금액
	
	private String refund_regdate; // 환급 일자
}
