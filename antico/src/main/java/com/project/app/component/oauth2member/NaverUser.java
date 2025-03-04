package com.project.app.component.oauth2member;

import java.util.Map;

import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;

@Component
public class NaverUser extends Oauth2Member {

	@Override
	public MemberVO oauth2User(OAuth2User oAuth2User) {
		
		MemberVO member_vo = new MemberVO();
		
        Map<String, Object> attributes = oAuth2User.getAttributes();
        
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
		
		member_vo.setMember_name(String.valueOf(response.get("name")));
		
		member_vo.setMember_tel(String.valueOf(response.get("mobile")));
		
		member_vo.setMember_user_id(String.valueOf(response.get("id")));
		
		member_vo.setMember_oauth_type("naver");
		
		return member_vo;
	}

}
