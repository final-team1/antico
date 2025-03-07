package com.project.app.component;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionalEventListener;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.repository.ChatRepository;
import com.project.app.chat.repository.ChatRoomRepository;
import com.project.app.chat.service.ChatService;
import com.project.app.member.domain.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 상품 판매 상태가 수정되고 커밋완료 시 구매자/판매자 채팅 알람처리 클래스
 */

@Slf4j
@Component
@RequiredArgsConstructor
public class ProductSaleStatusEventListener {
	
	private final ChatRoomRepository chatRoomRepository;
	
	private final ChatRepository chatRepository;
	
	private final SimpMessagingTemplate messagingTemplate;
	
	private final GetMemberDetail memberDetail;

	/*
	 * 상품 판매 상태에 따라 알림 채팅 처리 메소드
	 */
	@TransactionalEventListener
	public void notifyChatOnSaleStatusChange(ProductStatusChangedEvent event) {
		String status = event.getNewStatus();
		
		String pk_product_no = event.getProductId();
		
		switch(status) {
			case "0" : { // 판매 중
				break;
			}
			case "1" : { // 예약 중
				broadcastProductSaleStatusChat(pk_product_no, "결제완료");
				break;
			}
			case "2" : { // 구매 확정
				broadcastProductSaleStatusChat(pk_product_no, "구매확정");
				break;
			}
			case "5" : { // 경매 완료
				// TODO 경매 기능 적용 시 사용
				break;
			}
			default : {
				log.error("[ERROR] : 상품 판매 상태 값이 유효하지 않습니다. product_sale_status : {}", status);
				break;
			}
		}
	}
	
	/*
	 * 구매자 및 판매자에게 상품 판매 상태 변경 채팅 발송
	 */
	private void broadcastProductSaleStatusChat(String pk_product_no, String message) {
		MemberVO memberVO = memberDetail.MemberDetail();
		String roomId = null;
		
		Optional<ChatRoom> chatroom = chatRoomRepository.findChatRoomByProductNoAndParticipant(pk_product_no, memberVO.getPk_member_no());
		
		// 채팅을 하지 않은 상태에서 판매 상태가 변경된 경우
		if(!chatroom.isPresent()) {
			return;
		}
		
		roomId = chatroom.get().getRoomId();
		
		Chat chat = Chat.builder()
				.message(message)
				.roomId(roomId)
				.chatType(1)
				.senderId(memberVO.getPk_member_no())
				.senderName(memberVO.getMember_name())
				.readMembers(List.of(memberVO.getPk_member_no()))
				.sendDate(LocalDateTime.now())
				.unReadCount(chatroom.get().getParticipants().size() - 1)
				.build();
		
		Chat newChat = chatRepository.save(chat);
		
		messagingTemplate.convertAndSend("/room/" + roomId, newChat);
		
	}
}
