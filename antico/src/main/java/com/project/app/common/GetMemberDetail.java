package com.project.app.common;

import java.net.http.HttpRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.member.service.CustomUserDetails;
import com.project.app.member.service.MemberDetailService;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class GetMemberDetail {
	
	@Autowired
	private MemberDAO memberdao;
	
	@Autowired
	private MemberDetailService member_detail_service;
	
	@Bean
	public MemberVO MemberDetail() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		String mem_user_id = ((CustomUserDetails) authentication.getPrincipal()).getUsername();
		
		MemberVO mvo = memberdao.selectMemberByUserId(mem_user_id);
		
		return mvo;
	}
	
}
