package com.project.app.chat.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.Participant;
import com.project.app.chat.repository.ChatRepository;
import com.project.app.chat.repository.ChatRoomRepository;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;
import com.project.app.product.service.ProductService;

import lombok.RequiredArgsConstructor;

/*
 * 채팅 비즈니스 로직 처리 서비스
 */
@Service
@RequiredArgsConstructor
public class ChatService_imple implements ChatService {
	
	private final ChatRepository chatRepository; // 채팅 관리 레포지토리
	
	private final ChatRoomRepository chatRoomRepository; // 채팅방 관리 레포지토리
	
	private final MemberService memberService;
	
	private final ProductService productService;

	/*
	 * 채팅방 목록 불러오기
	 */
	@Override
	public List<Map<String, String>> getChatRoomList(String pk_member_no) {
		
		// 반환할 채팅방 정보, 상품 요약 정보, 최근 메시지 정보
		List<Map<String, String>> chatroom_map_list = new ArrayList<>();
		
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록 조회
		List<ChatRoom> chatroom_list = chatRoomRepository.findAllByMemberNoOrderByProductNoAsc(pk_member_no);
		
		// 참여하고 있는 채팅방이 존재하지 않는 경우
		if(chatroom_list.size() < 1) {
			return chatroom_map_list;
		}
		
		// 채팅방들의 각 상품 일련번호 목록
		List<String> pk_product_no_list = new ArrayList<>();
		
		// 채팅방들의 각 최근 메시지 목록 
		List<Chat> latest_chat_list = new ArrayList<>();
		
		// 채팅방 목록을 순회하면서 각 최근 채팅 메시지 조회 및 상품 정보 조회
		for(ChatRoom chatroom : chatroom_list) {
			Chat chat = chatRepository.findTopByRoomIdOrderBySendDateDesc(chatroom.getRoomId());
			
			if(chat != null) {
				latest_chat_list.add(chat);	
			}
			
			pk_product_no_list.add(chatroom.getProductNo());
		}
		
		List<Map<String, String>> product_summary_list = productService.getProdcutSummaryList(pk_product_no_list);
		
		// 조회한 정보들을 map에 저장하여 반환
		for(int i = 0; i < chatroom_list.size(); i++) {
			Map<String, String> map = new HashMap<>();

			map.put("room_id", chatroom_list.get(i).getRoomId());
			map.put("regdate", chatroom_list.get(i).getRegdate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			
			if(latest_chat_list.size() > 0) {
				map.put("latest_chat_message", latest_chat_list.get(i).getMessage());
				map.put("latest_chat_send_date", latest_chat_list.get(i).getSendDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			}
			else {
				map.put("latest_chat_message", "");
				map.put("latest_chat_send_date", "");
			}

			map.put("participant1_no", chatroom_list.get(i).getParticipants().get(0).getMemberNo());
			map.put("participant1_name", chatroom_list.get(i).getParticipants().get(0).getMemberName());
			map.put("participant2_no", chatroom_list.get(i).getParticipants().get(1).getMemberNo());
			map.put("participant2_name", chatroom_list.get(i).getParticipants().get(1).getMemberName());
			
			map.put("pk_product_no", product_summary_list.get(i).get("pk_product_no"));
			map.put("pk_product_no", product_summary_list.get(i).get("product_title"));
			map.put("prod_img_name", product_summary_list.get(i).get("prod_img_name"));
			chatroom_map_list.add(map);
		}
		
		return chatroom_map_list;
	}

	/*
	 * 채팅 메시지 저장
	 */
	@Override
	public Chat createChat(String roomId, String senderId, String message) {
		Chat chat = Chat.builder()
				.roomId(roomId)
				.senderId(senderId)
				.sendDate(LocalDateTime.now())
				.message(message)
				.build();
		
		return chatRepository.save(chat);
	}

	/*
	 * 채팅방 정보 조회
	 */
	@Override
	public ChatRoom getChatRoom(String room_id) {
		return chatRoomRepository.findChatRoomByRoomId(room_id);
	}

	/*
	 * 채팅방 개설
	 */
	@Override
	public ChatRoom createChatRoom(Map<String, String> product_map, MemberVO login_member_vo) {
		String login_member_no = login_member_vo.getPk_member_no(); // 현재 로그인 사용자 일련번호
		String login_member_name = login_member_vo.getMember_name(); // 현재 로그인 사용자 이름
		
		// 상품 판매자 정보 불러오기 (이름, 일련번호, 점수)
		// TODO 판매자 회원이 존재하지 않는 경우 예외처리
		String seller_no = product_map.get("fk_member_no");
		MemberVO seller_vo = memberService.getMember(seller_no);
		
		// 판매자는 채팅방 개설 불가능
		if(login_member_no.equalsIgnoreCase(seller_no)) {
			// TODO 예외처리
			System.out.println("채팅방 개설자가 판매자");
		}
		
		// 해당 상품에 이미 채팅이 존재하는지 확인
		Optional<ChatRoom> existRoom = chatRoomRepository.findChatRoomByProductNo(product_map.get("pk_product_no"));
		
		// 존재한다면 해당 채팅방 정보 반환
		if(existRoom.isPresent()) {
			return existRoom.get();
		}
	
		// 채팅 참여자 회원 번호, 회원 이름
		List<Participant> participants = new ArrayList<>();
		
		// 구매자
		Participant consumer = Participant.createParticipant(login_member_no, login_member_name);
		
		// 판매자
		Participant seller = Participant.createParticipant(seller_no, seller_vo.getMember_name());
		
		participants.add(seller);
		participants.add(consumer);
		
		ChatRoom chatRoom = ChatRoom.builder()
				.participants(participants)
				.productNo(product_map.get("pk_product_no"))
				.regdate(LocalDateTime.now())
				.build();
		
		return chatRoomRepository.save(chatRoom);
	}

	/*
	 * 채팅 내역 불러오기
	 */
	@Override
	public List<Chat> loadChatHistory(String roomId) {
		return chatRepository.findChatByRoomId(roomId);
	}

}
