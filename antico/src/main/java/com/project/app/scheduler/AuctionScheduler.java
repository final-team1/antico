package com.project.app.scheduler;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

<<<<<<< HEAD
=======
import com.project.app.auction.domain.AuctionChatRoom;
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
import com.project.app.auction.service.AuctionService;
import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.service.ChatService;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.sse.service.SseService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 경매 관련 스케줄러 클래스
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AuctionScheduler {

	private final AuctionService auctionService; // 경매 서비스

	private final SseService sseService; // SSE 관리 서비스

<<<<<<< HEAD
	private final ChatService chatService; // 채팅 서비스

=======
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
	/*
	 * 경매 시작시간을 확인하여 상품 판매 상태 변경 및 채팅방 생성
	 */
	@Scheduled(cron = "0 * * * * ? ")
	public void checkAuctionStart() {
		// 경매 시작 상품 조회 및 판매 상태 변경
		List<Map<String, String>> productMap = auctionService.updateProductSaleStatusByAuctionStartDate();

		// 상품 목록을 순회하며 판매자에게 경매 시작 알림 발송 및 채팅방 생성
		for (Map<String, String> map : productMap) {
<<<<<<< HEAD
			// 판매자에게 경매 시작 알림 발송
=======
			// // 판매자에게 경매 시작 알림 발송
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
			String memberNo = map.get("pk_member_no"); // 회원 일련번호
			String memberName = map.get("member_name"); // 회원 이름
			String productNo = map.get("pk_product_no"); // 경매 상품 일련 번호

<<<<<<< HEAD
			// 채팅방 생성
			ChatRoom chatRoom = chatService.createAuctionChatRoom(map);

			int readCount = chatRoom.getParticipants().size();

			// 읽지 않은 인원 수가 정장적으로 나오지 않는경우 예외처리
			if (readCount < 1) {
				log.error("[ERROR] : readCount 값 오류 : {}", readCount);
				throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
			}

			Chat chat = Chat.builder()
				.chatType(1)
				.message("상품 경매가 시작되었습니다.")
				.roomId(chatRoom.getRoomId())
				.sendDate(LocalDateTime.now())
				.senderId(memberNo)
				.senderName(memberName)
				.build();

			chatService.createChat(chat);
=======
			log.info("상품 " + map.get("product_name") + "의 경매가 시작되었습니다.");

			// 채팅방 생성
			auctionService.createAuctionChatRoom(map);
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)

			sseService.sendNotification(memberNo, "auction", memberName + "님 " + productNo + "상품 경매가 시작되었습니다.");
		}
	}
}
