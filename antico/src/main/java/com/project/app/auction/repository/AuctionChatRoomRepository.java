package com.project.app.auction.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.project.app.auction.domain.AuctionChatRoom;

public interface AuctionChatRoomRepository extends MongoRepository<AuctionChatRoom, String> {

	// 사용자가 속한 모든 채팅방 내역 조회
	@Query(value = "{ 'participants.memberNo': { $all: [?0] } }", sort = "{ 'productNo': 1 }")
	List<AuctionChatRoom> findAllByMemberNoOrderByProductNoAsc(String memberNo);

	// pk_product_no 를 통한 채팅방 조회
	@Query(value = "{ 'productNo': ?0, 'participants.memberNo' : ?1 }")
	Optional<AuctionChatRoom> findAuctionChatRoomByProductNoAndParticipant(String productNo, String memberNo);

	// pk_product_no 를 통한 채팅방 조회
	@Query(value = "{ 'productNo': ?0 }")
	Optional<AuctionChatRoom> findAuctionChatRoomByProductNo(String productNo);

	// roomId를 통한 채팅방 조회
	AuctionChatRoom findChatRoomByRoomId(String roomId);

}
 