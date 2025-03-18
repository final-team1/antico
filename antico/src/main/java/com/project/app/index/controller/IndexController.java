package com.project.app.index.controller;

import java.io.IOException;
import java.net.URLEncoder;
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

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) throws IOException,ServletException {
		
		// 최근 등록된 상품 조회 해오기
		List<Map<String, String>> product_list_reg_date = service.getProductList(null); 
		mav.addObject("product_list_reg_date", product_list_reg_date);
		
		// 이번 주 인기 급상승 상품 조회를 위한 
		String sort_views_week = "sort_views_week";
		List<Map<String, String>> product_list_views_week = service.getProductList(sort_views_week); 
		mav.addObject("product_list_views_week", product_list_views_week);
		
		if("2".equals(request.getSession().getAttribute("member_status"))){
			String ctx_path = request.getContextPath();
			
			request.getSession().removeAttribute("member_status");
			
			Cookie cookie = new Cookie("message", URLEncoder.encode("정지된&nbsp;회원입니다.", "UTF-8"));
			
			cookie.setMaxAge(5); 
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
			
			response.sendRedirect(ctx_path+"/logout");
		}
		
	    mav.setViewName("main/index");

	    return mav;
		
	}
	
}
