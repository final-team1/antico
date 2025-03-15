package com.project.app.auction.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.project.app.auction.domain.AuctionChat;

public interface AuctionChatRepository extends MongoRepository<AuctionChat, String> {

	// 채팅 내역 조회
	@Query("{ 'roomId' : ?0, 'sendDate' : { $gte: ?1 } }")
	List<AuctionChat> findAuctionChatByRoomId(String roomId, LocalDateTime startDate);

	// 채팅 내역 삭제
	void deleteByRoomId(String roomId);

}
