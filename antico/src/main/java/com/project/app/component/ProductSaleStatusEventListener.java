package com.project.app.component;

import java.lang.reflect.Member;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionalEventListener;

import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.Participant;
import com.project.app.chat.repository.ChatRepository;
import com.project.app.chat.repository.ChatRoomRepository;
import com.project.app.chat.service.ChatService;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;
import com.project.app.product.model.ProductDAO;
import com.project.app.product.service.ProductService;

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

	private final ProductDAO productDAO;

	private final MemberService memberService;

	/*
	 * 상품 판매 상태에 따라 알림 채팅 처리 메소드
	 */
	@TransactionalEventListener
	public void notifyChatOnSaleStatusChange(ProductStatusChangedEvent event) {
		String status = event.getNewStatus();
		String sellerNo = event.getSellerNo();
		String pk_product_no = event.getProductId();
		
		switch(status) {
			case "0" : { // 판매 중
				break;
			}
			case "1" : { // 예약 중
				broadcastProductSaleStatusChat(pk_product_no, sellerNo, "결제완료");
				break;
			}
			case "2" : { // 구매 확정
				broadcastProductSaleStatusChat(pk_product_no, sellerNo, "구매확정");
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
	private void broadcastProductSaleStatusChat(String pk_product_no, String sellerNo, String message) {
		MemberVO memberVO = null;
		memberVO = memberService.getMemberByMemberNo(sellerNo);

		if(StringUtils.isBlank(sellerNo)) {
			memberVO = memberDetail.MemberDetail();
		}

		String roomId = null;
		
		Optional<ChatRoom> chatroom = chatRoomRepository.findChatRoomByProductNoAndParticipant(pk_product_no, memberVO.getPk_member_no());
		
		// 채팅을 하지 않은 상태에서 판매 상태가 변경된 경우
		if(!chatroom.isPresent()) {
			Map<String, String> product_map = productDAO.getProductInfo(pk_product_no);

			// 채팅 참여자 회원 번호, 회원 이름
			List<Participant> participants = new ArrayList<>();

			// 구매자
			Participant consumer = Participant.createParticipant(memberVO.getPk_member_no(), memberVO.getMember_name());

			// 판매자
			Participant seller = Participant.createParticipant(product_map.get("fk_member_no"), product_map.get("member_name"));

			participants.add(seller);
			participants.add(consumer);

			ChatRoom chatRoom = ChatRoom.builder()
				.participants(participants)
				.productNo(product_map.get("pk_product_no"))
				.regdate(LocalDateTime.now())
				.build();

			roomId =  chatRoomRepository.save(chatRoom).getRoomId();
		}
		else {
			roomId = chatroom.get().getRoomId();
		}
		
		Chat chat = Chat.builder()
				.message(message)
				.roomId(roomId)
				.chatType(1)
				.senderId(memberVO.getPk_member_no())
				.senderName(memberVO.getMember_name())
				.readMembers(List.of(memberVO.getPk_member_no()))
				.sendDate(LocalDateTime.now())
				.unReadCount(1)
				.build();
		
		Chat newChat = chatRepository.save(chat);
		
		messagingTemplate.convertAndSend("/room/" + roomId, newChat);
		
	}
}
