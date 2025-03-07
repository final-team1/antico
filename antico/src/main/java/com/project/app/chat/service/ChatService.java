package com.project.app.chat.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.ChatRoomRespDTO;
import com.project.app.member.domain.MemberVO;

public interface ChatService {
	
	// 채팅방 목록 불러오기
	List<ChatRoomRespDTO> getChatRoomList(String pk_member_no);
	
	// 채팅 메시지 생성
	Chat createChat(Chat chat);

	// 채팅방 개설
	ChatRoom createChatRoom(Map<String, String> product_map, MemberVO login_member_vo);

	// 채팅 내역 불러오기
	List<Chat> loadChatHistory(String roomId);

	// 채팅방 조회
	ChatRoom getChatRoom(String room_id);

	// 사용자 별 최근 읽은 메시지 식별자 변경
	List<Chat> updateUnReadCount(String chatId, String roomId, String memberNo);

	// 경매 채팅방 생성
	ChatRoom createAuctionChatRoom(Map<String, String> map);

	// 상품 일련번호 및 구매자 일련번호를 통한 채팅방 조회
	// Optional<ChatRoom> getChatRoomByProductNoAndMemberNo(String pk_product_no, String fk_consumer_no);

}
