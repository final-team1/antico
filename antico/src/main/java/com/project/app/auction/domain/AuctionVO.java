package com.project.app.auction.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

/*
 * 경매 정보 VO
 */
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuctionVO {

	private String pk_auction_no; // 경매 일련번호
	
	private String fk_product_no; // 경매 상품 일련번호
	
	private String fk_win_member_no; // 경매 낙찰자 일련번호
	
	private String auction_price; // 경매 낙찰가
	
	private String auction_regdate; // 경매 등록일자
	
	private String auction_startdate; // 경매 시작시간
	
	private String auction_enddate; // 경매 마감시간 
	
}
