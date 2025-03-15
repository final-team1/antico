package com.project.app.auction.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
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

import com.project.app.auction.domain.AucChatRoomRespDTO;
import com.project.app.auction.domain.AuctionBid;
import com.project.app.auction.domain.AuctionChat;
import com.project.app.auction.domain.AuctionVO;
import com.project.app.auction.service.AuctionService;
import com.project.app.auction.domain.AuctionChatRoom;
import com.project.app.chat.domain.ChatRoomRespDTO;
import com.project.app.chat.domain.Participant;
import com.project.app.component.GetMemberDetail;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 경매 기능 컨트롤러
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/auction/*")
public class AuctionController {
	
	private final AuctionService auctionService;

	private final GetMemberDetail getMemberDetail;

	private final ProductService productService;

	/*
	 * 경매 상품 등록
	 */
	@PostMapping("add")
	public ModelAndView addAuction(ProductVO productVO, ProductImageVO productImageVO, ModelAndView mav) {
	      // 경매 상품 등록 완료 후 상품 일련번호 반환 
	      String productNo = auctionService.addAuctionProduct(productVO, productImageVO);

		  AuctionVO auctionVO = auctionService.getAuction(productVO.getPk_product_no());

		  mav.addObject("auctionVO", auctionVO);
	      mav.addObject("product_no", productNo); // 상품 번호 전달
	      mav.setViewName("redirect:/product/add_success"); // 상품 등록 완료 페이
	      return mav;
	}

	/*
	 * 경매 채팅방 목록 조회
	 */
	@PostMapping("/loadAuctionChatRoom")
	@ResponseBody
	public List<AucChatRoomRespDTO> loadChatRoom() {
		MemberVO login_member_vo = getMemberDetail.MemberDetail(); // 현재 사용자 VO
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록 불러오기
		List<AucChatRoomRespDTO> aucChatRoomRespDTOList = auctionService.getAuctionChatRoomList(login_member_vo.getPk_member_no());
		return aucChatRoomRespDTOList;
	}

	/*
	 * 경매 채팅방 접속
	 */
	@PostMapping("chatroom")
	@ResponseBody
	public ModelAndView joinAuctionChatRoom(@RequestParam String pk_product_no, ModelAndView mav) {
		MemberVO loginMember = getMemberDetail.MemberDetail(); // 현재 사용자 VO

		AuctionChatRoom auctionChatRoom = auctionService.joinAuctionChatRoomByProdNo(pk_product_no, loginMember); // 채팅방 정보 조회

		AuctionVO auctionVO = auctionService.getAuction(pk_product_no);

		AuctionBid auctionBid = auctionService.getHighestBidByRoomId(auctionChatRoom.getRoomId());

		log.info("auctionVO: " + auctionVO.getAuction_enddate());

		// 채팅방의 주제 상품 정보 조회
		Map<String, String> productMap = productService.getProductInfo(auctionChatRoom.getProductNo());

		mav.addObject("highestBid", auctionBid);
		mav.addObject("auctionVO", auctionVO);
		mav.addObject("login_member_vo", loginMember); // 로그인 회원 정보
		mav.addObject("product_map", productMap); // 채팅 주제 상품 정보
		mav.addObject("chat_room", auctionChatRoom); // 채팅방 정보

		mav.setViewName("chat/auction_chat");
		return mav;
	}


	/*
	 * 경매 채팅방 접속
	 */
	@PostMapping("join")
	@ResponseBody
	public ModelAndView joinChatRoom(@RequestParam String room_id, ModelAndView mav) {
		MemberVO loginMember = getMemberDetail.MemberDetail(); // 현재 사용자 VO

		AuctionChatRoom auctionChatRoom = auctionService.joinAuctionChatRoom(room_id, loginMember); // 채팅방 정보 조회

		// 채팅방의 주제 상품 정보 조회
		Map<String, String> productMap = productService.getProductInfo(auctionChatRoom.getProductNo());

		AuctionBid auctionBid = auctionService.getHighestBidByRoomId(auctionChatRoom.getRoomId());

		AuctionVO auctionVO = auctionService.getAuction(auctionChatRoom.getProductNo());

		log.info("auctionVO: " + auctionVO.getAuction_enddate());

		log.info(String.valueOf(auctionBid.getBid()));

		mav.addObject("auctionVO", auctionVO);
		mav.addObject("highestBid", auctionBid);
		mav.addObject("login_member_vo", loginMember); // 로그인 회원 정보
		mav.addObject("product_map", productMap); // 채팅 주제 상품 정보
		mav.addObject("chat_room", auctionChatRoom); // 채팅방 정보

		mav.setViewName("chat/auction_chat");
		return mav;
	}

	/*
	 * 웹소켓 구독 및 채팅 전송
	 */
	@MessageMapping("/auction/{auctionRoomId}") // 해당 url 요청은 구독처리
	@SendTo("/room/{auctionRoomId}/auction") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
	public AuctionChat chat(@DestinationVariable String auctionRoomId, AuctionChat auctionChat) {
		// 채팅 메시지 저장 및 반환
		auctionChat.updateRoomId(auctionRoomId);
		auctionChat.updateReadMembers(auctionChat.getSenderId());
		auctionChat.updateSendDate(LocalDateTime.now());
		return auctionService.createAuctionChat(auctionChat);
	}

	/*
	 * 웹소켓 구독 및 채팅 전송
	 */
	@MessageMapping("/auction/read/{auctionRoomId}") // 해당 url 요청은 구독처리
	@SendTo("/room/{auctionRoomId}/auction/read") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
	public List<AuctionChat> updateUnReadCount(@DestinationVariable String auctionRoomId, Map<String, String> paraMap) {
		// 채팅 메시지 저장 및 반환
		return auctionService.updateUnReadCount(paraMap.get("chatId"), auctionRoomId, paraMap.get("memberNo"));
	}

	/*
	 * 채팅방의 채팅 내역 조회
	 */
	@GetMapping("load_chat_history/{auctionRoomId}")
	@ResponseBody
	public List<AuctionChat> loadChatHistory(@PathVariable String auctionRoomId) {
		return auctionService.loadAuctionChatHistory(auctionRoomId);
	}

	@GetMapping("timer")
	@ResponseBody
	public LocalDateTime getTimer() {
		return LocalDateTime.now();
	}

	@GetMapping("close")
	@ResponseBody
	public void close(@RequestParam String pk_product_no) {
		MemberVO memberVO = getMemberDetail.MemberDetail();
		Map<String, String> productMap = auctionService.selectAuctionProduct(pk_product_no);

		if(!memberVO.getPk_member_no().equals(productMap.get("pk_member_no"))){
			throw new BusinessException(ExceptionCode.AUCTION_NOT_SELLER);
		}

		auctionService.closeAuction(productMap);
	}
	
}
