package com.project.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private GetMemberDetail get_member_detail;
	
	@Value("${kakaologin.client_id}")
    private String client_id;

    @Value("${kakaologin.redirect_uri}")
    private String redirect_uri;
	
	@GetMapping("login")
	public ModelAndView showLoginPage(
			 			ModelAndView mav,
			 			RedirectAttributes redirectAttributes){
		
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
		mav.addObject("location", location);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		System.out.println(authentication.getAuthorities());
		
		if("[ROLE_ANONYMOUS]".equals(String.valueOf(authentication.getAuthorities()))) {
			
			mav.setViewName("main/login");
			
		}else {
			
			mav.setViewName("redirect:/index");
			
			redirectAttributes.addFlashAttribute("message", "이미 로그인 상태입니다.");
			
			System.out.println("로그인상태");
			
		}
		
		
		return mav;
	}
	
	
	
	@GetMapping("register")
	public ModelAndView goRegisterMember(ModelAndView mav) {
		
		
		mav.setViewName("main/register");
		
		return mav;
	}
	
	
	
	@PostMapping("register")
	public ModelAndView registerMember(@RequestParam String member_user_id, @RequestParam String member_passwd, 
			@RequestParam String member_name, @RequestParam String member_tel,
			 			ModelAndView mav){
		
		MemberVO mvo = new MemberVO();
		
		
		
		mvo.setMember_passwd(member_passwd);
		mvo.setMember_user_id(member_user_id);
		mvo.setMember_tel(member_tel);
		mvo.setMember_name(member_name);
		
		int n = service.registerMember(mvo);
		
		mav.setViewName("main/index");
		
		return mav;
	}
	
}
