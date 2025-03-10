package com.project.app.member.service;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Oauth2Service{
	
    private final String kakao_unlink_url = "https://kapi.kakao.com/v1/user/unlink";
    
    private final String kakao_token_url = "https://kauth.kakao.com/oauth/token";
    
    @Value("${spring.security.oauth2.client.registration.client-id}")
    private String CLIENT_ID; // 카카오 REST API 키
    
    private final String REDIRECT_URI = "/logout"; // 카카오 로그인 후 리다이렉트 URI
    
    public String unlinkKakaoUser(String accessToken) {
        // HTTP 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> request = new HttpEntity<>(headers);

        // 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(kakao_unlink_url, HttpMethod.POST, request, String.class);

        // 응답 확인
        if (response.getStatusCode() == HttpStatus.OK) {
            return "회원 탈퇴 성공: " + response.getBody();
        } else {
            return "회원 탈퇴 실패: " + response.getStatusCode();
        }
    }
    
	
}
