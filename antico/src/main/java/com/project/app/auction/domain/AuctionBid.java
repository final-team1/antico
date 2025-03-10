package com.project.app.auction.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

/*
 	경매 입찰 도메인
 */
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "auction_bids")
public class AuctionBid {

	@Id
	private String id;

	private String roomId; // 채팅방 ID

	private String bidderNo; // 입찰자 일련번호
	
	private String bidderName; // 입찰자 명

	// TODO int가 맞는지 Integer이 맞는지
	private Integer bid; // 입찰 금액

	private LocalDateTime bidTime; // 입찰 시간
	
}
