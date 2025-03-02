package com.project.app.chat.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.ChatRoomRespDTO;
import com.project.app.chat.domain.Participant;
import com.project.app.chat.domain.ProductChatDTO;
import com.project.app.chat.repository.ChatRepository;
import com.project.app.chat.repository.ChatRoomRepository;
import com.project.app.chat.repository.CustomChatRoomRepository;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.product.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 채팅 비즈니스 로직 처리 서비스
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatService_imple implements ChatService {
	
	private final ChatRepository chatRepository; // 채팅 레포지토리
	
	private final ChatRoomRepository chatRoomRepository; // 채팅방 레포지토리
	
	private final CustomChatRoomRepository customChatRoomRepository; // 채팅방 커스텀 레포지토리
	
	private final ProductService productService;

	/*
	 * 채팅방 목록 불러오기
	 */
	@Override
	public List<ChatRoomRespDTO> getChatRoomList(String pk_member_no) {
		// 반환할 채팅방 정보, 상품 요약 정보, 최근 메시지 정보
		
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
		List<ChatRoomRespDTO> chatRoomRespDTOList = customChatRoomRepository.findAllWithLatestChatByMemberNo(pk_member_no);
		
		// 참여하고 있는 채팅방이 존재하지 않는 경우
		if(chatRoomRespDTOList.size() < 1) {
			return chatRoomRespDTOList;
		}
		
		// 채팅방들의 각 상품 일련번호 목록
		List<String> pk_product_no_list = new ArrayList<>();
		
		// 채팅방 목록을 순회하면서 각 최근 채팅 메시지 조회 및 상품 정보 조회
		for(ChatRoomRespDTO dto  : chatRoomRespDTOList) {
			pk_product_no_list.add(dto.getChatRoom().getProductNo());
		}
		
		List<ProductChatDTO> product_list = productService.getProdcutSummaryList(pk_product_no_list);
		
		Map<String, ProductChatDTO> productMap = new HashMap<>();
		
		for(ProductChatDTO dto : product_list) {
			productMap.put(dto.getPk_product_no(), dto);
		}
		
		// 조회한 정보들을 map에 저장하여 반환
		for(ChatRoomRespDTO dto  : chatRoomRespDTOList) {
			String pk_product_no = dto.getChatRoom().getProductNo();
			dto.updateProductChatDTO(productMap.get(pk_product_no));
		}
		
		return chatRoomRespDTOList;
	}

	/*
	 * 채팅 메시지 저장
	 */
	@Override
	public Chat createChat(Chat chat) {
		ChatRoom chatRoom = chatRoomRepository.findChatRoomByRoomId(chat.getRoomId());
		int readCount = chatRoom.getParticipants().size();
		
		// 읽지 않은 인원 수가 정장적으로 나오지 않는경우 예외처리
		if(readCount < 1) {
			log.error("[ERROR] : readCount 값 오류 : " + readCount);
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}
	
		chat.updateUnReadCount(readCount - 1);
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
		String seller_no = product_map.get("fk_member_no");
		
		if(StringUtils.isBlank(seller_no)) {
			log.error("[ERROR] : 채팅 판매 상품 정보 조회 실패");
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}
		
		// 판매자는 채팅방 개설 불가능
		if(login_member_no.equalsIgnoreCase(seller_no)) {
			throw new BusinessException(ExceptionCode.SELLER_CREATE_CHAT);
		}
		
		// 해당 상품에 이미 채팅이 존재하는지 확인
		Optional<ChatRoom> existRoom = chatRoomRepository.findChatRoomByProductNoAndParticipant(product_map.get("pk_product_no"), login_member_no);
		
		// 존재한다면 해당 채팅방 정보 반환
		if(existRoom.isPresent()) {
			return existRoom.get();
		}
	
		// 채팅 참여자 회원 번호, 회원 이름
		List<Participant> participants = new ArrayList<>();
		
		// 구매자
		Participant consumer = Participant.createParticipant(login_member_no, login_member_name);
		
		// 판매자
		Participant seller = Participant.createParticipant(seller_no, product_map.get("member_name"));
		
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

	/*
	 * 사용자 별 최근 읽은 메시지 식별자 변경
	 */
	@Override
	public List<Chat> updateUnReadCount(String chatId, String roomId, String memberNo) {
		Optional<Chat> chat = chatRepository.findById(chatId);
		List<Chat> updatedChats = new ArrayList<>();
		
		// 채팅이 존재하지 않는 경우 예외 처리
		if(!chat.isPresent()) {
			log.error("채팅이 존재하지 않습니다. chatId : " + chatId);
			return updatedChats;
		}
		
		updatedChats = customChatRoomRepository.updateUnReadCount(chatId, roomId, memberNo);
		return updatedChats;
	}

}
