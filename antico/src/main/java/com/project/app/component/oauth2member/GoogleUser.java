package com.project.app.component.oauth2member;

import java.util.Map;

import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;

@Component
public class GoogleUser extends Oauth2Member {

	@Override
	public MemberVO oauth2User(OAuth2User oAuth2User) {
		
		MemberVO member_vo = new MemberVO();
		
		Map<String, Object> user_info = oAuth2User.getAttributes();
		
		System.out.println(user_info);
		
		member_vo.setMember_name(String.valueOf(user_info.get("name")));
		
		member_vo.setMember_user_id(String.valueOf(user_info.get("sub")));
		
		member_vo.setMember_oauth_type("google");
		
		return member_vo;
	}
	
	
}
