package com.project.app.chat.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Document(collection = "chat_room")
@Getter
@Setter
@Builder
public class ChatRoom {
	
	@Id
	private String roomId; // 채팅방 식별자
	
	private List<Participant> participants; // 채팅방 참여자 식별자
	
	private LocalDateTime regdate; // 채팅방 생성일자 
	
	private String productNo; // 상품 일련번호
	
}
