package com.project.app.member.service;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Oauth2Service{
	
    private String unlink_url = "";
    
    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String client_id; // 카카오 REST API 키
    
    private final String redirect_uri = "/logout"; // 카카오 로그인 후 리다이렉트 URI
    
    public String unlinkOauthUser(String access_token, String user_id) {
    	
    	if(user_id.length() <= 11) {
    		unlink_url = "https://kapi.kakao.com/v1/user/unlink";
    	}else if(user_id.length() <= 44) {
    		unlink_url = "https://nid.naver.com/oauth2.0/token?"+access_token;
    	}else {
    		unlink_url = "https://oauth2.googleapis.com/revoke?"+access_token;
    	}
    	
        // HTTP 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + access_token);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("target_id_type", "user_id");  // 사용자 ID 타입 (user_id, email 등)
        body.add("target_id", user_id);  // 카카오에서 부여한 사용자 ID
        
        System.out.println(user_id);
        
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
        
        // 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(unlink_url, HttpMethod.POST, request, String.class);

        // 응답 확인
        if (response.getStatusCode() == HttpStatus.OK) {
            return "회원 탈퇴 성공: " + response.getBody();
        } else {
            return "회원 탈퇴 실패: " + response.getStatusCode();
        }
        
    }
    
}
