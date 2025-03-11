package com.project.app.auction.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Document(collection = "auction_chat_messages")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuctionChat {

	@Id
	private String id; // 채팅 식별자

	@Field("sender_id")
	private String senderId; // 작성자 식별자	

	private String senderName; // 작성자 명

	private String roomId; // 채팅방 식별자

	private String message; // 채팅 내용

	private List<String> readMembers; // 채팅 메시지 읽은 인원 수

	private int unReadCount; // 채팅메시지 읽지 않은 인원 수

	private LocalDateTime sendDate; // 작성일자

	private int chatType; // 채팅 타입 0 : 일반 채팅, 1 : 서버 알림 채팅

	// 채팅방 식별자 변경 메소드
	public void updateRoomId(String roomId) {
		this.roomId = roomId;
	}

	// 채팅을 읽지 않은 인원 수 메소드
	public void updateUnReadCount(int readCount) {
		this.unReadCount = readCount;
	}

	// 채팅을 읽지 않은 인원 수 메소드
	public void updateReadMembers(String memberNo) {
		this.readMembers = List.of(memberNo);
	}

	// 채팅 타입 설정 메소드
	public void updateChatType(int chatType) {this.chatType = chatType;}

	// 채팅 작성 시간 설정 메소드
	public void updateSendDate(LocalDateTime now) {this.sendDate = now;}
}
