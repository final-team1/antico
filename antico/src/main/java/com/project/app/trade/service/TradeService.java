package com.project.app.trade.service;

import java.util.Map;

import com.project.app.trade.domain.TradeVO;

public interface TradeService {

	Map<String, String> getProduct(String pk_product_no, String pk_member_no);

	// 구매를 하면 포인트를 차감 update, 상품상태를 예약중으로 변경 update, 포인트내역 insert, 거래 insert
	int purchase(String pk_product_no, String member_no, String pk_member_no, String product_price, String member_point);

	// 구매확정을 했을 때
	int order_completed(String pk_product_no, String product_price, String pk_member_no, String fk_member_no);

	// 상품 일련번호를 통한 거래 내역 조회
	TradeVO getTradeByProductNo(String pkProductNo);
}
