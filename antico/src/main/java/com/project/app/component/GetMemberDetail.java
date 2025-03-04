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

@AllArgsConstructor
@Component
public class GetMemberDetail {
	
	@Autowired
	private MemberDAO member_dao;

	@Bean
	public MemberVO MemberDetail() {
		// 시큐리티 컨텍스트 안의 회원 정보를 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		MemberVO member_vo = new MemberVO();
		
		if(authentication != null) {
			String member_user_id = ""; 

			if(authentication instanceof User) {
				member_user_id = String.valueOf(((User)authentication.getPrincipal()).getUsername());
				
				member_vo = member_dao.selectMemberByUserId(member_user_id);
			}else {
				member_user_id = authentication.getName();
				// kakao
				if(authentication.getName().length() < 11) {
					
					member_vo = member_dao.selectMemberByUserId(member_user_id);
				// google	
				}else if(authentication.getName().length() >= 11 && authentication.getName().length() <= 22){
					
					member_user_id = authentication.getName();
					
					member_vo = member_dao.selectMemberByUserId(member_user_id);
					
				// naver	
				}else {
					int n = member_user_id.indexOf(",");
					
					member_user_id = member_user_id.substring(4, n);
					
					member_vo = member_dao.selectMemberByUserId(member_user_id);
				}
				
			}
			
		}
		
		return member_vo;
	}
	
}
