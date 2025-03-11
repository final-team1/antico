package com.project.app.auction.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.project.app.chat.domain.Participant;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Document(collection = "auction_chat_room")
@Getter
@Setter
@Builder
public class AuctionChatRoom {
	
	@Id
	private String roomId; // 채팅방 식별자
	
	private List<Participant> participants; // 채팅방 참여자 식별자
	
	private LocalDateTime regdate; // 채팅방 생성일자 
	
	private LocalDateTime auctionEndDate; // 경매 마감 시간, 생성으로부터 1시간 뒤
	
	private String productNo; // 상품 일련번호
	
}
