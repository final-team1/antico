package com.project.app.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.app.mypage.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping(value="/mypage/*")
public class MypageController {

	@Autowired
	private MypageService service;
	
	@GetMapping("mypagemain")
	public String mypagemain(HttpServletRequest request, ModelAndView mav) {
		
	//	service.pointcharge();
		
		return "mypage/mypage";
	}
	
	@GetMapping("pointcharge")
	public String pointcharge(HttpServletRequest request) {
		
		
		return "mypage/pointcharge";
	}
	
}
