package com.project.app.auction.service;

import java.util.List;
import java.util.Map;

<<<<<<< HEAD
=======
import com.project.app.auction.domain.AucChatRoomRespDTO;
import com.project.app.auction.domain.AuctionBid;
import com.project.app.auction.domain.AuctionChat;
import com.project.app.auction.domain.AuctionChatRoom;
import com.project.app.auction.domain.AuctionVO;
import com.project.app.member.domain.MemberVO;
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

public interface AuctionService {

	// 경매 상품 추가
	String addAuctionProduct(ProductVO productvo, ProductImageVO product_imgvo);

	// 경매 시작 시간인 경매 상품 일련번호 목록 조회 및 판매 상태 수정
	List<Map<String, String>> updateProductSaleStatusByAuctionStartDate();

<<<<<<< HEAD
=======
	void createAuctionChatRoom(Map<String, String> product_map);

	AuctionChat createAuctionChat(AuctionChat auctionChat);

	AuctionChatRoom joinAuctionChatRoom(String roomId, MemberVO loginMember);

	List<AuctionChat> loadAuctionChatHistory(String roomId);

	List<AuctionChat> updateUnReadCount(String chatId, String roomId, String memberNo);

	List<AucChatRoomRespDTO> getAuctionChatRoomList(String memberNo);

	AuctionChatRoom joinAuctionChatRoomByProdNo(String pkProductNo, MemberVO loginMember);

	AuctionBid getHighestBidByRoomId(String auctionRoomId);

	AuctionVO getAuction(String productNo);

	void closeAuction(String pkAuctionNo, String room_id);

>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
}
