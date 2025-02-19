package com.project.app.mypage.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 거래 VO
 */

@Getter
@Setter
public class TradeVO {

	private String pk_trade_no; // 거레 번호
	
	private String fk_seller_no; // 판매자 번호
	
	private String fk_consumer_no; // 구매자 번호
	
	private String fk_product_no; // 상품번호
	
	private String trade_status; // 구매상태
	
	private String trade_cancel_date; // 결제 취소일자
	
	private String trade_pending_date; // 결제 대기일자
	
	private String trade_confirm_date; // 확정일자
	
}
