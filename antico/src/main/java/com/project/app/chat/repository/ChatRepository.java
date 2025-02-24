package com.project.app.chat.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.project.app.chat.domain.Chat;

public interface ChatRepository extends MongoRepository<Chat, String> {

	// 채팅 내역 조회
	List<Chat> findChatByRoomId(String roomId);

	Chat findTopByRoomIdOrderBySendDateDesc(String roomId);

	
}
 