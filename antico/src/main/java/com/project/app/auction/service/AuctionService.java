package com.project.app.auction.service;

import java.util.List;
import java.util.Map;

import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

public interface AuctionService {

	// 경매 상품 추가
	String addAuctionProduct(ProductVO productvo, ProductImageVO product_imgvo);

	// 경매 시작 시간인 경매 상품 일련번호 목록 조회 및 판매 상태 수정
	List<Map<String, String>> updateProductSaleStatusByAuctionStartDate();

}
