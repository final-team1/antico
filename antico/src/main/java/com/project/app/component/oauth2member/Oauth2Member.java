package com.project.app.component.oauth2member;


import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
abstract class Oauth2Member {
	
	public abstract MemberVO oauth2User(OAuth2User oAuth2User);
	
	
	
}
