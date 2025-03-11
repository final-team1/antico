package com.project.app.auction.model;

import java.util.List;
import java.util.Map;
<<<<<<< HEAD

import org.apache.ibatis.annotations.Mapper;

=======
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.auction.domain.AuctionVO;

>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
@Mapper
public interface AuctionDAO {

	// 경매 정보 등록
	int insertAuction(String pk_product_no, String auction_startdate);

	// 경매 시작 시간인 경매 상품 조회
	List<Map<String, String>> selectProductNoListByAuctionStartDate();

	// 경매 시작 시간인 경매 상품 판매 상태 수정
	void updateProductSaleStatus(List<String> productNoList);
<<<<<<< HEAD
	
	
=======

	Optional<AuctionVO> selectAuctionProductNo(String productNo);

	void updateAuctionClosed(String pkAuctionNo);

>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
} 
