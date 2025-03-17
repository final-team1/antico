package com.project.app.auction.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.auction.domain.AucChatRoomRespDTO;
import com.project.app.auction.domain.AuctionBid;
import com.project.app.auction.domain.AuctionChat;
import com.project.app.auction.domain.AuctionChatRoom;
import com.project.app.auction.domain.AuctionVO;
import com.project.app.auction.repository.AuctionBidRepository;
import com.project.app.auction.repository.AuctionChatRepository;
import com.project.app.auction.repository.AuctionChatRoomRepository;
import com.project.app.auction.model.AuctionDAO;
import com.project.app.auction.repository.CustomAuctionChatRoomRepository;
import com.project.app.chat.domain.Participant;
import com.project.app.chat.domain.ProductChatDTO;
import com.project.app.common.FileType;
import com.project.app.component.GetMemberDetail;
import com.project.app.component.S3FileManager;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.service.ProductService;
import com.project.app.sse.service.SseService;
import com.project.app.trade.model.TradeDAO;
import com.project.app.trade.service.TradeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 경매 서비스 클래스
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuctionService_imple implements AuctionService {

	private final GetMemberDetail getMemberDetail;

	private final AuctionDAO auctionDAO;

	private final TradeService tradeService;

	private final ProductService productService;

	private final S3FileManager s3FileManager;

	private final AuctionChatRepository auctionChatRepository;

	private final AuctionChatRoomRepository auctionChatRoomRepository;

	private final CustomAuctionChatRoomRepository customAuctionChatRoomRepository;

	private final AuctionBidRepository auctionBidRepository;

	private final SimpMessagingTemplate messagingTemplate;

	private static final Pattern BID_PATTERN = Pattern.compile("^@\\d+$");

	private final MemberService memberService;

	private final SseService sseService; // SSE 관리 서비스

	/*
	 * 경매 상품 추가
	 * 상품 추가 성공 시 상품 일련번호 반환
	 */
	@Override
	@Transactional
	public String addAuctionProduct(ProductVO productvo, ProductImageVO product_imgvo) {
		// 이미지 정보 가져오기
		List<MultipartFile> attachList = product_imgvo.getAttach();

		// 로그인한 회원의 회원번호 값 가져오기
		String fk_member_no = getMemberDetail.MemberDetail().getPk_member_no();
		productvo.setFk_member_no(fk_member_no); // 회원 번호 값 담기

		// 상품번호 채번해오기
		String c_product_no = productService.getNo();
		productvo.setPk_product_no(c_product_no); // 채번 해온 값 담기

		// 상품 이미지 확인
		if (attachList == null || attachList.size() < 1) {
			throw new BusinessException(ExceptionCode.FILE_IS_EMPTY);
		}

		// 경매 상품 정보 등록
		int n1 = productService.addAuctionProduct(productvo);

		// 경매 상품 정보 등록 실패 시 예외 처리
		// mybatis xml에서 상품 판매 상태(일반판매/경매) 검사
		if (n1 < 1) {
			log.error("[ERROR] : 경매 상품 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}

		// org_file_name : 이미지 원본명
		// file_name : 이미지 저장명
		// 경매 상품 이미지 S3 저장
		List<Map<String, String>> fileList = s3FileManager.upload(attachList, "product", FileType.IMAGE);

		// 경매 상품 이미지 정보 등록
		int n2 = productService.insertAuctionProductImage(fileList, c_product_no);

		// 경매 상품 이미지 정보 등록 실패 시 예외처리
		if (n2 < 1) {
			log.error("[ERROR] : 경매 상품 이미지 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}

		log.info(productvo.getAuction_start_date());

		// 경매 정보 등록
		int n3 = auctionDAO.insertAuction(c_product_no, productvo.getAuction_start_date());

		if (n3 < 1) {
			log.error("[ERROR] : 경매 정보 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}

		return c_product_no;
	}

	/*
	 * 경매 시작 시간인 경매 상품 일련번호 목록 조회 및 판매 상태 수정
	 */
	@Override
	@Transactional
	public List<Map<String, String>> updateProductSaleStatusByAuctionStartDate() {
		// 경매 시작 시간인 경매 상품 일련번호 목록 조회
		List<Map<String, String>> productMapList = auctionDAO.selectProductNoListByAuctionStartDate();
		List<String> list = new ArrayList<>();

		// 경매 시작 시간인 경매 상품 판매 상태 수정
		if (!productMapList.isEmpty()) {
			for (Map<String, String> map : productMapList) {
				list.add(map.get("pk_product_no"));

				log.info("경매 상품 가져옴 : " + map.get("product_title"));
			}
			auctionDAO.updateProductSaleStatus(list, 4);
		}

		return productMapList;
	}

	@Override
	@Transactional
	public List<Map<String, String>> updateProductSaleStatusByAuctionEndDate() {
		// 경매 종료 시간인 경매 상품 일련번호 목록 조회
		List<Map<String, String>> productMapList = auctionDAO.selectProductNoListByAuctionEndDate();
		List<String> list = new ArrayList<>();

		// 경매 시작 시간인 경매 상품 판매 상태 수정
		if (!productMapList.isEmpty()) {
			for (Map<String, String> map : productMapList) {
				list.add(map.get("pk_product_no"));
			}
			auctionDAO.updateProductSaleStatus(list, 5);
		}

		return productMapList;
	}

	/*
	 	경매 시작 시 판매자만 존재하는 경매 채팅방 생성
	 	map
	 	pk_product_no : 경매 상품 일련번호
		pk_member_no :  판매자 일련번호
		member_name : 판매자 이름
		pk_auction_no : 경매 일련번호

	 */
	@Override
	public void createAuctionChatRoom(Map<String, String> productMap) {
		String sellerNo = productMap.get("pk_member_no");
		String sellerName = productMap.get("member_name");
		String productNo = productMap.get("pk_product_no");
		String price = productMap.get("product_price");

		if (!StringUtils.isNumeric(price)) {
			log.error("[ERROR] : 상품 가격이 유효한 값이 아닙니다.");
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}

		if (StringUtils.isBlank(sellerNo)) {
			log.error("[ERROR] : 채팅 경매 상품 정보 조회 실패");
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}

		// 이미 경매 채팅방이 생성되었는지 확인
		Optional<AuctionChatRoom> existRoom = auctionChatRoomRepository.findAuctionChatRoomByProductNoAndParticipant(productNo, sellerNo);
		if (existRoom.isPresent()) {
			return;
		}

		// 채팅 참여자 회원 번호, 회원 이름
		List<Participant> participants = new ArrayList<>();

		// 판매자
		Participant seller = Participant.createParticipant(sellerNo, sellerName);

		log.info("startTime " + seller.getStartDate());

		participants.add(seller);

		// 채팅방 도메인 생성
		AuctionChatRoom chatRoom = AuctionChatRoom.builder()
			.participants(participants)
			.productNo(productNo)
			.regdate(LocalDateTime.now()) // 경매 시작 시간은 현재 시간
			.auctionEndDate(LocalDateTime.now().plusHours(1)) // 경매 종료 시간은 현재 시간 기준 1시간 뒤 설정
			.build();

		// 채팅방 생성
		chatRoom = auctionChatRoomRepository.save(chatRoom);

		AuctionChat chat = AuctionChat.builder()
			.chatType(1)
			.message("상품 경매가 시작되었습니다.")
			.roomId(chatRoom.getRoomId())
			.sendDate(LocalDateTime.now())
			.build();

		// 경매 시작 채팅 시작
		auctionChatRepository.save(chat);

		AuctionBid bid = AuctionBid.builder()
			.roomId(chatRoom.getRoomId())
			.bidderName(sellerName)
			.bidderNo(sellerNo)
			.bid(Integer.parseInt(productMap.get("product_price")))
			.bidTime(LocalDateTime.now())
			.build();

		auctionBidRepository.save(bid);

	}

	/*
	 * 채팅 메시지 저장
	 */
	@Override
	public AuctionChat createAuctionChat(AuctionChat auctionChat) {
		AuctionChatRoom auctionChatRoom = auctionChatRoomRepository.findChatRoomByRoomId(auctionChat.getRoomId());

		String message = auctionChat.getMessage();

		// 입찰 메시지인지 확인
		if (BID_PATTERN.matcher(auctionChat.getMessage()).matches()) {
			AuctionBid bid = AuctionBid.builder()
				.bidderNo(auctionChat.getSenderId())
				.bidderName(auctionChat.getSenderName())
				.bid(Integer.parseInt(message.substring(1)))
				.roomId(auctionChatRoom.getRoomId())
				.bidTime(LocalDateTime.now())
				.build();

			auctionBidRepository.save(bid);

			messagingTemplate.convertAndSend("/room/" + auctionChatRoom.getRoomId() + "/auction/bid", bid);
		}

		int readCount = auctionChatRoom.getParticipants().size();

		// 읽지 않은 인원 수가 정장적으로 나오지 않는경우 예외처리
		if (readCount < 1) {
			log.error("[ERROR] : readCount 값 오류 : {}", readCount);
			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
		}

		auctionChat.updateUnReadCount(readCount - 1);
		return auctionChatRepository.save(auctionChat);
	}

	@Override
	public AuctionChatRoom joinAuctionChatRoom(String roomId, MemberVO loginMember) {
		return auctionChatRoomRepository.findById(roomId)
			.orElseThrow(() -> new BusinessException(ExceptionCode.JOIN_CHATROOM_FAILD));
	}

	/*
	 * 채팅 내역 불러오기
	 */
	@Override
	public List<AuctionChat> loadAuctionChatHistory(String roomId) {
		MemberVO memberVO = getMemberDetail.MemberDetail();
		AuctionChatRoom auctionChatRoom = auctionChatRoomRepository.findChatRoomByRoomId(roomId);

		List<Participant> participants = auctionChatRoom.getParticipants();

		Participant participant = participants.stream()
			.filter(p ->  p.getMemberNo().equals(memberVO.getPk_member_no()))
			.findFirst().orElseThrow(() -> new BusinessException(ExceptionCode.JOIN_CHATROOM_FAILD));

		log.info("dfdfdfdfdf 니야양 " + participant.getStartDate());

		return auctionChatRepository.findAuctionChatByRoomId(roomId, participant.getStartDate());
	}

	/*
	 * 사용자 별 최근 읽은 메시지 식별자 변경
	 */
	@Override
	public List<AuctionChat> updateUnReadCount(String chatId, String roomId, String memberNo) {
		Optional<AuctionChat> chat = auctionChatRepository.findById(chatId);
		List<AuctionChat> updatedChats = new ArrayList<>();

		// 채팅이 존재하지 않는 경우 예외 처리
		if (chat.isEmpty()) {
			log.error("[ERROR] : 채팅이 존재하지 않습니다. chatId : {}", chatId);
			return updatedChats;
		}

		updatedChats = customAuctionChatRoomRepository.updateUnReadCount(chatId, roomId, memberNo);
		return updatedChats;
	}

	@Override
	public List<AucChatRoomRespDTO> getAuctionChatRoomList(String memberNo) {
		// 반환할 채팅방 정보, 상품 요약 정보, 최근 메시지 정보

		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
		List<AucChatRoomRespDTO> aucChatRoomList = customAuctionChatRoomRepository.findAllWithLatestChatByMemberNo(memberNo);

		// 참여하고 있는 채팅방이 존재하지 않는 경우
		if (aucChatRoomList.isEmpty()) {
			return aucChatRoomList;
		}

		// 채팅방들의 각 상품 일련번호 목록
		List<String> pk_product_no_list = new ArrayList<>();

		// 채팅방 목록을 순회하면서 각 최근 채팅 메시지 조회 및 상품 정보 조회
		for (AucChatRoomRespDTO dto : aucChatRoomList) {
			pk_product_no_list.add(dto.getAuctionChatRoom().getProductNo());
		}

		List<ProductChatDTO> product_list = productService.getProdcutSummaryList(pk_product_no_list);

		Map<String, ProductChatDTO> productMap = new HashMap<>();

		for (ProductChatDTO dto : product_list) {
			productMap.put(dto.getPk_product_no(), dto);
		}

		log.info(productMap.keySet().toString());

		// 조회한 정보들을 map에 저장하여 반환
		for (AucChatRoomRespDTO dto : aucChatRoomList) {
			String pk_product_no = dto.getAuctionChatRoom().getProductNo();
			dto.updateProductChatDTO(productMap.get(pk_product_no));
		}

		return aucChatRoomList;
	}

	@Override
	public AuctionChatRoom joinAuctionChatRoomByProdNo(String pkProductNo, MemberVO loginMember) {
		AuctionChatRoom chatRoom = auctionChatRoomRepository.findAuctionChatRoomByProductNo(pkProductNo)
			.orElseThrow(() -> new BusinessException(ExceptionCode.AUCTION_NOT_STARTED));

		Participant participant = Participant.createParticipant(loginMember.getPk_member_no(), loginMember.getMember_name());

		if (chatRoom.getParticipants().contains(participant)) {
			return chatRoom;
		}

		// 참여자 목록에 사용자 추가
		AuctionChatRoom auctionChatRoom = customAuctionChatRoomRepository.addParticipant(chatRoom.getRoomId(), participant);

		AuctionChat chat = AuctionChat.builder()
			.roomId(chatRoom.getRoomId())
			.chatType(1)
			.message("경매에 " + loginMember.getMember_name() + "님이 입장하셨습니다.")
			.sendDate(LocalDateTime.now())
			.build();

		AuctionChat newChat = auctionChatRepository.save(chat);

		// 입장 알림 메시지 전송
		messagingTemplate.convertAndSend("/room/" + chatRoom.getRoomId() + "/auction", newChat);

		// 참여자 변동 알림 전송
		messagingTemplate.convertAndSend("/room/" + chatRoom.getRoomId() + "/auction/participant", auctionChatRoom.getParticipants());

		return auctionChatRoom;

	}

	@Override
	public AuctionBid getHighestBidByRoomId(String auctionRoomId) {
		return auctionBidRepository.findFirstByRoomIdOrderByBidDesc(auctionRoomId);
	}

	@Override
	public AuctionVO getAuction(String productNo) {
		return auctionDAO.selectAuctionProductNo(productNo)
			.orElseThrow(() -> new BusinessException(ExceptionCode.AUCTION_NOT_FOUND));
	}

	@Override
	@Transactional
	public void closeAuction(Map<String, String> product_map) {
		AuctionChatRoom chatRoom = auctionChatRoomRepository.findAuctionChatRoomByProductNo(product_map.get("pk_product_no"))
			.orElseThrow(() -> new BusinessException(ExceptionCode.CHATROOM_NOT_FOUND));

		AuctionBid auctionBid = auctionBidRepository.findFirstByRoomIdOrderByBidDesc(chatRoom.getRoomId());

		log.info("낙찰자 일련번호 {}", auctionBid.getBidderNo());
		log.info("판매자 일련번호 {}", product_map.get("fk_member_no"));

		String product_title = product_map.get("product_title");

		// 경매 참여자가 없는 경우
		if(!auctionBid.getBidderNo().equals(product_map.get("pk_member_no"))) {
			MemberVO memberVO = memberService.getMemberByMemberNo(auctionBid.getBidderNo());

			// TODO auction 테이블에 정보 넣어야됨

			String pk_product_no = product_map.get("pk_product_no");
			String seller_no = product_map.get("pk_member_no");
			String consumer_no = memberVO.getPk_member_no();
			String product_price = String.valueOf(auctionBid.getBid());
			String member_point = memberVO.getMember_point();

			int n = productService.updateProductPrice( product_map.get("pk_product_no"), String.valueOf(auctionBid.getBid()));

			if(n != 1) {
				log.error("[ERROR] : 낙찰가로 상품 가격 변경 실패 : {}", product_map.get("pk_product_no"));
				throw new BusinessException(ExceptionCode.PAYMENT_EXEC_FAILED);
			}

			// 결제 처리
			int n1 = tradeService.purchase(pk_product_no, seller_no, consumer_no, product_price, member_point);

			if(n1 != 1) {
				throw new BusinessException(ExceptionCode.PAYMENT_EXEC_FAILED);
			}
		}

		auctionDAO.updateAuctionEndDate(product_map.get("pk_product_no"));
		productService.saleStatusUpdate(product_map.get("pk_product_no"), "5");

		AuctionChat chat = AuctionChat.builder()
			.roomId(chatRoom.getRoomId())
			.chatType(1)
			.message("경매가 종료되었습니다.")
			.sendDate(LocalDateTime.now())
			.build();

		AuctionChat newChat = auctionChatRepository.save(chat);

		messagingTemplate.convertAndSend("/room/" + chatRoom.getRoomId() + "/auction", newChat);

		MemberVO bidder = memberService.getMemberByMemberNo(auctionBid.getBidderNo());

		sseService.sendNotification(bidder.getMember_user_id(), "auction_end", "경매에 낙찰되셨습니다. 일반 채팅을 확인해주세요");

	}

	@Override
	@Transactional(readOnly = true)
	public Map<String, String> selectAuctionProduct(String pk_product_no) {
		Map<String, String> product_map = auctionDAO.selectAuctionProduct(pk_product_no);
		if(product_map == null) {
			throw new BusinessException(ExceptionCode.AUCTION_PRODUCT_NOT_FOUND);
		}

		return product_map;
	}

	@Override
	public void delete(String pkProductNo) {
		Optional<AuctionChatRoom> chatRoom = auctionChatRoomRepository.findAuctionChatRoomByProductNo(pkProductNo);
		if(chatRoom.isPresent()) {
			auctionChatRoomRepository.delete(chatRoom.get());
			auctionChatRepository.deleteByRoomId(chatRoom.get().getRoomId());
		}
	}
}
