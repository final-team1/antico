package com.project.app.chat.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.project.app.chat.domain.ChatRoom;

public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {
	
	// 사용자가 속한 모든 채팅방 내역 조회
	@Query(value = "{ 'participants.memberNo': { $all: [?0] } }", sort = "{ 'productNo': 1 }")
	List<ChatRoom> findAllByMemberNoOrderByProductNoAsc(String memberNo);

	// pk_product_no 를 통한 채팅방 조회 
	Optional<ChatRoom> findChatRoomByProductNo(String productNo);

	// roomId를 통한 채팅방 조회
	ChatRoom findChatRoomByRoomId(String room_id);

}
 