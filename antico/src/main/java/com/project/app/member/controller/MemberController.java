package com.project.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
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
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		System.out.println(authentication.getAuthorities());
		
		mav.setViewName("main/login");
		
		return mav;
	}
	
	
	
	@GetMapping("register")
	public ModelAndView goRegisterMember(ModelAndView mav) {
		
		
		mav.setViewName("main/register");
		
		return mav;
	}
	
	
	
	@PostMapping("register")
	public ModelAndView registerMember(@RequestParam String member_user_id, @RequestParam String member_passwd, 
			 			ModelAndView mav){
		
		MemberVO mvo = new MemberVO();
		
		
		
		mvo.setMember_passwd(member_passwd);
		mvo.setMember_user_id(member_user_id);
		
		System.out.println(mvo.getMember_user_id());
		System.out.println(mvo.getMember_passwd());
		
		int n = service.registerMember(mvo);
		
		mav.setViewName("index");
		
		return mav;
	}
	
}
