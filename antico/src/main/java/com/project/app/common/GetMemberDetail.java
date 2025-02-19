package com.project.app.common;

import java.net.http.HttpRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

import lombok.AllArgsConstructor;

@Component
public class GetMemberDetail {
	
	@Autowired
	private MemberDAO member_dao;
	
	public GetMemberDetail(MemberDAO member_dao) {
		this.member_dao = member_dao;
	}




	@Bean
	public MemberVO MemberDetail() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		MemberVO member_vo = new MemberVO();
		
		if(authentication != null) {
			
			String member_user_id = String.valueOf(((User)authentication.getPrincipal()).getUsername());
			
			member_vo = member_dao.selectMemberByUserId(member_user_id);
			
		}
		
		return member_vo;
	}
	
}
