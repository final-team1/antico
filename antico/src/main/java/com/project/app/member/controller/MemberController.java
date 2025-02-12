package com.project.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	MemberService service;
	

	
	@GetMapping("login")
	public ModelAndView showLoginPage(
			 			ModelAndView mav){
		
		
		mav.setViewName("main/login");
		
		return mav;
	}
	
	
	
	@GetMapping("register")
	public ModelAndView goRegisterMember(ModelAndView mav) {
		
		
		mav.setViewName("main/register");
		
		return mav;
	}
	
	
	
	@PostMapping("register")
	public ModelAndView registerMember(@RequestParam String mem_user_id, @RequestParam String mem_passwd, 
			 			ModelAndView mav){
		
		MemberVO mvo = new MemberVO();
		
		mvo.setMem_passwd(mem_passwd);
		mvo.setMem_user_id(mem_user_id);
		
		System.out.println(mvo.getMem_user_id());
		System.out.println(mvo.getMem_passwd());
		
		int n = service.registerMember(mvo);
		
		
		
		return mav;
	}
	
}
