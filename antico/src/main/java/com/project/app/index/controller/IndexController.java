package com.project.app.index.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.member.service.MemberService;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/*")
public class IndexController {
	
	
	@Autowired
	ProductService service;
	
	
	@GetMapping("/")   // http://localhost:9090/final/
	public String main() {
		
		return "redirect:/index";  //  http://localhost:9090/final/index
	}
	
	
	@GetMapping("index")  //  http://localhost:9090/final/index
	public ModelAndView index(HttpServletRequest request, ModelAndView mav) {
		
		// 최근 등록된 상품 조회 해오기
		List<Map<String, String>> product_list_reg_date = service.getProductList(); 
		mav.addObject("product_list_reg_date", product_list_reg_date);
		
	    mav.setViewName("main/index");

	    return mav;
		
	}
	
}
