package com.project.app.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;

/*
 * 상품 컨트롤러
 */
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	ProductService service;
	
	
	// 상품등록 form 페이지 요청 
	@GetMapping("add")
	public ModelAndView add(HttpServletRequest request, ModelAndView mav) {
		
		// 상품등록 form 페이지에 상위 카테고리명 보여주기
		List<CategoryVO> category_list = service.getCategory();
		
		// 상품등록 form 페이지에 하위 카테고리명 보여주기
		List<CategoryDetailVO> category_detail_list = service.getCategoryDetail();
		
		mav.addObject("category_list", category_list);
		mav.addObject("category_detail_list", category_detail_list);
		mav.setViewName("product/add");
		return mav;
		
	}
	
}
