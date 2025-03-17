package com.project.app.scheduler;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.app.auction.domain.AuctionChatRoom;
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

	/*
	 * 경매 시작시간을 확인하여 상품 판매 상태 변경 및 채팅방 생성
	 */
	@Scheduled(cron = "10 * * * * ? ")
	public void checkAuctionStart() {
		// TODO 비효율 개선
		// 경매 시작 상품 조회 및 판매 상태 변경
		List<Map<String, String>> auction_start_product_map = auctionService.updateProductSaleStatusByAuctionStartDate();

		List<Map<String, String>> auction_end_product_map = auctionService.updateProductSaleStatusByAuctionEndDate();

		log.info("경매 시작 상품 개수 " + auction_start_product_map.size());

		// 상품 목록을 순회하며 판매자에게 경매 시작 알림 발송 및 채팅방 생성
		for (Map<String, String> map : auction_start_product_map) {

			// // 판매자에게 경매 시작 알림 발송
			String product_title = map.get("product_title");
			String member_user_id = map.get("member_user_id");

			log.info("상품 " + map.get("product_name") + "의 경매가 시작되었습니다.");
			log.info("데이터베이스 현재 시간 : " + map.get("2"));
			log.info("경매 시간 기록 시간 : " + map.get("1"));

			// 채팅방 생성
			auctionService.createAuctionChatRoom(map);

			sseService.sendNotification(member_user_id, "auction", product_title + "상품 경매가 시작되었습니다.");
		}

		// 상품 목록을 순회하며 판매자에게 경매 시작 알림 발송 및 채팅방 생성
		 for(Map<String, String> map : auction_end_product_map) {
			 auctionService.closeAuction(map);
		}
	}
}
