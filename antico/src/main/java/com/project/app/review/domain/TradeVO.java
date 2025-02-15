package com.project.app.review.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TradeVO {
	private String pk_trade_no;
	private String fk_seller_no;
	private String fk_consumer_no;
	private String fk_product_no;
	private String trade_status;
	private String trade_cancel_date;
	private String trade_pending_date;
	private String trade_confirm_date;
}
