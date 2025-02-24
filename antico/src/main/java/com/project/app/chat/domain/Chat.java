package com.project.app.chat.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Document(collection = "chat_messages")
@Getter
@Setter
@Builder
public class Chat {

	@Id
	private String id; // 채팅 식별자
	
	@Field("sender_id")
	private String senderId; // 작성자 식별자	
	
	private String roomId; // 채팅방 식별자
	
	private String message; // 채팅 내용
	
	private boolean readed; // 읽음 여부
	
	private LocalDateTime sendDate; // 작성일자
	
}
