package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 은행 VO
 */

@Getter
@Setter
public class BankVO {

	private String pk_bank_no; // 은행번호
	
	private String bank_name; // 은행명
}
