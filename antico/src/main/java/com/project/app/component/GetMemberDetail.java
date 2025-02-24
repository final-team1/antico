package com.project.app.component;

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
		// 시큐리티 컨텍스트 안의 회원 정보를 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		MemberVO member_vo = new MemberVO();
		
		if(authentication != null) {
			// 회원의 정보를 유저타입으로 형변환 후 회원의 아이디를 가져온다.
			String member_user_id = String.valueOf(((User)authentication.getPrincipal()).getUsername());
			
			member_vo = member_dao.selectMemberByUserId(member_user_id);
			
		}
		
		return member_vo;
	}
	
}
