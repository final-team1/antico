package com.project.app.auction.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.project.app.auction.domain.AuctionChat;

public interface AuctionChatRepository extends MongoRepository<AuctionChat, String> {

	// 채팅 내역 조회
	List<AuctionChat> findAuctionChatByRoomId(String roomId);

	//AuctionChat findTopByRoomIdOrderBySendDateDesc(String roomId);

}
