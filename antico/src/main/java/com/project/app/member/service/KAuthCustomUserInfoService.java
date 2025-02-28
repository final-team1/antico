package com.project.app.member.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KAuthCustomUserInfoService extends DefaultOAuth2UserService{
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
		
		
		
        List<GrantedAuthority> authorities = AuthorityUtils.createAuthorityList("ROLE_USER_1");
        
        System.out.println("제발 시발 나와라 ♥"+authorities);

        // nameAttributeKey
        String userNameAttributeName = userRequest.getClientRegistration()
                .getProviderDetails()
                .getUserInfoEndpoint()
                .getUserNameAttributeName();
        
        
        
        
        System.out.println("유저 이름 : "+ userRequest.getClientRegistration().getClientName());
        System.out.println("유저아이디 : " + userRequest.getClientRegistration().getClientId());
        
        // DB 저장로직이 필요하면 추가
        System.out.println(userNameAttributeName);
        
        
        
        return new DefaultOAuth2User(authorities, oAuth2User.getAttributes(), userNameAttributeName);
	}

}
