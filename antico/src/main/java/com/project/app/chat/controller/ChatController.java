package com.project.app.chat.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.ChatRoomRespDTO;
import com.project.app.chat.service.ChatService;
import com.project.app.component.GetMemberDetail;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.product.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 채팅 컨트롤러
 */

@Slf4j
@Controller
@RequestMapping("/chat/*")
@RequiredArgsConstructor
public class ChatController {
	
	private final ChatService chatService;
	
	private final ProductService productService;
	
	private final GetMemberDetail detail; // security login member 조회
	
	/*
	 * 채팅 메인 페이지
	 */
	@GetMapping("/main")
	@ResponseBody
	public ModelAndView showChatMainPage(ModelAndView mav) {
		MemberVO login_member_vo = detail.MemberDetail(); // 현재 사용자 VO
		mav.addObject("login_member_vo", login_member_vo); // 로그인 사용자 일련번호
		mav.setViewName("chat/chat_main");
		return mav;
	}

	@PostMapping("/loadChatRoom")
	@ResponseBody
	public List<ChatRoomRespDTO> loadChatRoom() {
		MemberVO login_member_vo = detail.MemberDetail(); // 현재 사용자 VO
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록 불러오기
		List<ChatRoomRespDTO> chatRoomRespDTOList = chatService.getChatRoomList(login_member_vo.getPk_member_no());
		return chatRoomRespDTOList;
	}
	
	/*
	 * 1대1 채팅 채팅방 개설
	 */
	@PostMapping("chatroom")
	@ResponseBody
	public ModelAndView createChatRoom(@RequestParam String pk_product_no, ModelAndView mav) {
		MemberVO login_member_vo = detail.MemberDetail(); // 현재 사용자 VO
		
		// 상품 일련번호 불러오기 (상품 상세 페이지에서)
		if(!NumberUtils.isDigits(pk_product_no)) {
			log.error("[ERROR] : 상품번호가 유효하지 않습니다 : " + pk_product_no);
			throw new BusinessException(ExceptionCode.RPODUCT_NOT_ON_SALE);
		}
		
		// 채팅 주제 상품 정보
		Map<String, String> product_map = productService.getProductInfo(pk_product_no);
		
		// 채팅방 정보 불러오기
		ChatRoom chat_room = chatService.createChatRoom(product_map, login_member_vo);
		
		// 채팅방 개설 실패 시
		if(chat_room == null) {
			log.error("[ERROR] : 채팅방 생성 실패 chat_room is null");
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}
		
		mav.addObject("login_member_vo", login_member_vo); // 로그인 회원 정보
		mav.addObject("product_map", product_map); // 채팅 주제 상품 정보
		mav.addObject("chat_room", chat_room); // 채팅방 정보
		
		mav.setViewName("chat/chat");
		return mav;
	}
	
	/*
	 * 1대1 채팅방 접속
	 */
	@PostMapping("join")
	@ResponseBody
	public ModelAndView joinChatRoom(@RequestParam String room_id, ModelAndView mav) {
		MemberVO login_member_vo = detail.MemberDetail(); // 현재 사용자 VO
		
		ChatRoom chat_room = chatService.getChatRoom(room_id); // 채팅방 정보 조회

		// 채팅방 조회 실패
		if(chat_room == null) {
			log.error("[ERROR] : ChatrRoom 조회 실패");
			throw new BusinessException(ExceptionCode.JOIN_CHATROOM_FAILD);
		}
		
		// 채팅방의 주제 상품 정보 조회
		String pk_product_no =  chat_room.getProductNo(); 
		Map<String, String> product_map = productService.getProductInfo(pk_product_no);
		
		mav.addObject("login_member_vo", login_member_vo); // 로그인 회원 정보
		mav.addObject("product_map", product_map); // 채팅 주제 상품 정보 
		mav.addObject("chat_room", chat_room); // 채팅방 정보
		
		mav.setViewName("chat/chat");
		return mav;
	}
	
	/*
	 * 웹소켓 구독 및 채팅 전송 
	 */
	@MessageMapping("{roomId}") // 해당 url 요청은 구독처리
	@SendTo("/room/{roomId}") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
	public Chat chat(@DestinationVariable String roomId, Chat chat) {
		// 채팅 메시지 저장 및 반환
		chat.updateRoomId(roomId);
		chat.updateReadMembers(chat.getSenderId());
		chat.updateSendDate(LocalDateTime.now());
		return chatService.createChat(chat);
	}
	
	/*
	 * 웹소켓 구독 및 채팅 전송 
	 */
	@MessageMapping("/read/{roomId}") // 해당 url 요청은 구독처리
	@SendTo("/room/{roomId}/read") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
	public List<Chat> chat(@DestinationVariable String roomId, Map<String, String> paraMap) {
		// 채팅 메시지 저장 및 반환
		return chatService.updateUnReadCount(paraMap.get("chatId"), roomId, paraMap.get("memberNo"));
	}
	
	/*
	 * 채팅방의 채팅 내역 조회
	 */
	@GetMapping("load_chat_history/{roomId}")
	@ResponseBody
	public List<Chat> loadChatHistory(@PathVariable String roomId) {
		return chatService.loadChatHistory(roomId);
	}

}
