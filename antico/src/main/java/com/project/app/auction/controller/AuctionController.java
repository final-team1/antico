package com.project.app.auction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.auction.service.AuctionService;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

import lombok.RequiredArgsConstructor;

/*
 * 경매 기능 컨트롤러
 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/auction/*")
public class AuctionController {
	
	private final AuctionService auctionService;

	/*
	 * 경매 상품 등록
	 */
	@PostMapping("add")
	public ModelAndView addAuction(ProductVO productvo, ProductImageVO product_imgvo, ModelAndView mav) {
	      // 경매 상품 등록 완료 후 상품 일련번호 반환 
	      String product_no = auctionService.addAuctionProduct(productvo, product_imgvo);

	      mav.addObject("product_no", product_no); // 상품 번호 전달
	      mav.setViewName("redirect:/product/add_success"); // 상품 등록 완료 페이
	      return mav;
	}
	
}
