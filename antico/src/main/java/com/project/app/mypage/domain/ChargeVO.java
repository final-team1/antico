package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 충전 VO
 */

@Getter
@Setter
public class ChargeVO {

	private String pk_charge_no; // 충전 번호
	
	private String fk_member_no; // 회원번호
	
	private String charge_price; // 충전 금액
	
	private String charge_regdate; // 충전 일자
	
	private String charge_commission; // 수수료
	
}
