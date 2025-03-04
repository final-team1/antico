package com.project.app.security;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class OauthSuccessHandler implements AuthenticationSuccessHandler {
	
	private final MemberVO member_vo;

	private final OAuth2AuthorizedClientService authorizedClientService;
	
	private final MemberService member_service;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println(member_vo.getMember_oauth_type());
		
		/*
		 * if("google".equals(member_vo.getMember_oauth_type())) {
		 * 
		 * String accessToken = getAccessToken(authentication);
		 * 
		 * String member_tel = getPhoneNumber(accessToken);
		 * 
		 * System.out.println(member_tel);
		 * 
		 * member_service.google_tel_add(member_tel);
		 * 
		 * }
		 */
		
		response.sendRedirect("/antico/index");
		
	}
	
	private String getPhoneNumber(String accessToken) {
	    String url = "https://people.googleapis.com/v1/people/me?personFields=phoneNumbers";

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken);
	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
	    Map<String, Object> body = response.getBody();
	    
	    System.out.println("Response Body: " + body);
	    
	    if (body != null && body.containsKey("phoneNumbers")) {
	        List<Map<String, String>> phoneNumbers = (List<Map<String, String>>) body.get("phoneNumbers");
	        String phoneNumber = phoneNumbers.get(0).get("value");
	        System.out.println("Phone Number: " + phoneNumber); // 전화번호 출력
	        return phoneNumbers.get(0).get("value");
	    }
	    return null;
	}
	
    private String getAccessToken(Authentication authentication) {
        if (authentication instanceof OAuth2AuthenticationToken) {
            OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;

            OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(
                    oauthToken.getAuthorizedClientRegistrationId(),
                    oauthToken.getName()
            );

            if (authorizedClient != null && authorizedClient.getAccessToken() != null) {
                return authorizedClient.getAccessToken().getTokenValue(); // ✅ 토큰을 String으로 반환
            }
        }
        return null;
    }

}
