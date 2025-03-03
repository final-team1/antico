package com.project.app.component.oauth2member;

import java.util.Map;

import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

import lombok.RequiredArgsConstructor;

@Component
public class KakaoUser extends Oauth2Member {

	
	@Override
	public MemberVO oauth2User(OAuth2User oAuth2User) {
		
		MemberVO member_vo = new MemberVO();
		
		Map<String, Object> user_info = oAuth2User.getAttributes();
		
		Map<String, Object> kakao_account = (Map<String,Object>)user_info.get("kakao_account");
		
		member_vo.setMember_name(String.valueOf(kakao_account.get("name")));
		
		member_vo.setMember_tel(String.valueOf(kakao_account.get("phone_number")));
		
		member_vo.setMember_user_id(String.valueOf(user_info.get("id")));
		
		member_vo.setMember_oauth_type("kakao");
		
		return member_vo;
	}

}
