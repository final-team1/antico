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

import com.project.app.common.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private GetMemberDetail get_member_detail;
	

	
	@GetMapping("login")
	public ModelAndView showLoginPage(
			 			ModelAndView mav){
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		System.out.println(authentication.getAuthorities());
		
		if("[ROLE_ANONYMOUS]".equals(String.valueOf(authentication.getAuthorities()))) {
			
			mav.setViewName("main/login");
			
		}else {
			
			mav.setViewName("redirect:/index");
			
			mav.addObject("message", "이미 로그인 상태입니다.");
			
			System.out.println("로그인상태");
			
		}
		
		
		MemberVO member_vo = get_member_detail.MemberDetail();
		
		
		System.out.println(member_vo.getPk_member_no());
		
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
