package com.project.app.chat.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.project.app.chat.domain.Chat;

public interface ChatRepository extends MongoRepository<Chat, String> {

	// 채팅 내역 조회
	List<Chat> findChatByRoomId(String roomId);

	// 채팅 내역 삭제
	void deleteByRoomId(String roomId);

}
 