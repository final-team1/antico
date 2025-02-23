package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import io.netty.handler.codec.http.HttpHeaderValues;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import com.project.app.member.domain.KakaoTokenResponseVO;
import com.project.app.member.domain.KakaoUserInfoResponseVO;

@RequiredArgsConstructor
@Service
public class KakaoLoginService {
	
	private String clientId;
    private String KAUTH_TOKEN_URL_HOST ;
    private String KAUTH_USER_URL_HOST;

    @Autowired
    public KakaoLoginService(@Value("${kakaologin.client_id}") String clientId) {
        this.clientId = clientId;
        KAUTH_TOKEN_URL_HOST ="https://kauth.kakao.com";
        KAUTH_USER_URL_HOST = "https://kapi.kakao.com";
    }

    public String getAccessTokenFromKakao(String code) {

    	KakaoTokenResponseVO kakao_token_response_vo = WebClient.create(KAUTH_TOKEN_URL_HOST).post()
                .uri(uriBuilder -> uriBuilder
                        .scheme("https")
                        .path("/oauth/token")
                        .queryParam("grant_type", "authorization_code")
                        .queryParam("client_id", clientId)
                        .queryParam("code", code)
                        .build(true))
                .header(HttpHeaders.CONTENT_TYPE, HttpHeaderValues.APPLICATION_X_WWW_FORM_URLENCODED.toString())
                .retrieve()
                .bodyToMono(KakaoTokenResponseVO.class)
                .block();



        return kakao_token_response_vo.getAccessToken();
    }
    
    public KakaoUserInfoResponseVO getUserInfo(String accessToken) {

    	KakaoUserInfoResponseVO userInfo = WebClient.create(KAUTH_USER_URL_HOST)
                .get()
                .uri(uriBuilder -> uriBuilder
                        .scheme("https")
                        .path("/v2/user/me")
                        .build(true))
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken) // access token 인가
                .header(HttpHeaders.CONTENT_TYPE, HttpHeaderValues.APPLICATION_X_WWW_FORM_URLENCODED.toString())
                .retrieve()
                .bodyToMono(KakaoUserInfoResponseVO.class)
                .block();


        return userInfo;
    }
	
}
