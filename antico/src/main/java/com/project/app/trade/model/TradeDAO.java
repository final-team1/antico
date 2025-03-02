package com.project.app.trade.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TradeDAO {
	// 구매를 하면 포인트를 차감하기
	int deductPoint(String product_price, String pk_member_no);

	// 상품상태를 예약중으로 변경하기
	int holdProduct(String pk_product_no);

	// 포인트내역에 사용정보 insert
	int usePoint(String pk_member_no, String product_price, String member_point, String reason);

	// 거래테이블에 거래정보들 insert
	int trade(String pk_product_no, String member_no, String pk_member_no);

}
