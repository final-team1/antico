package com.project.app.chat.service;

import java.util.List;
import java.util.Map;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.Participant;
import com.project.app.member.domain.MemberVO;

public interface ChatService {
	
	// 채팅방 목록 불러오기
	List<Map<String, String>> getChatRoomList(String pk_member_no);
	
	// 채팅 메시지 생성
	Chat createChat(String roomId, String senderId, String message);

	// 채팅방 개설
	ChatRoom createChatRoom(Map<String, String> product_map, MemberVO login_member_vo);

	// 채팅 내역 불러오기
	List<Chat> loadChatHistory(String roomId);

	// 채팅방 조회
	ChatRoom getChatRoom(String room_id);

	// 사용자 별 최근 읽은 메시지 식별자 변경
	void updateLastReadChat(String roomId, Participant participant);

}
