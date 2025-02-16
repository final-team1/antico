package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 등록계좌 VO
 */
@Getter
@Setter
public class AccountVO {
	
	private String pk_account_no; // 계좌번호
	
	private String fk_bank_no; // 은행 번호
	
	private String fk_member_no; // 회원번호
}
