package com.project.app.member.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.app.member.domain.KakaoTokenVO;
import com.project.app.member.domain.KakaoUserDataVO;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberDetailService;
import com.project.app.member.service.MemberService;
import com.project.app.security.CustomUserDetails;


@Controller
@RequestMapping("/kakaologin/*")
public class KakaoLoginController {
	
	@Autowired
	public MemberDetailService member_detail_service;
	
	@Autowired
	private MemberVO member_vo;
	
	@Autowired
	private MemberService member_service;
	
	@Autowired
	private AuthenticationManager authentication_manager;
	
	@Value("${kakaologin.client_id}")
	private String client_id;
	
	
    @GetMapping("/callback")
    public String kakaoCallback(@RequestParam("code") String code) {
    	
		RestTemplate rest_template = new RestTemplate();

		
		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // 내가 지금 전송할 body data 가
																						// key=velue 형임을 명시

		System.out.println();
		
		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", client_id);
		params.add("redirect_uri", "http://localhost/antico/kakaologin/callback");
		params.add("code", code);

		// HttpHeader 와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = 
				new HttpEntity<>(params, headers); 

		// Http 요청하기 - Post 방식으로 - 그리고 Response 변수의 응답 받음.
		ResponseEntity<String> response = rest_template.exchange(
				"https://kauth.kakao.com/oauth/token", 
				HttpMethod.POST,
				kakaoTokenRequest, 
				String.class // String 타입으로 응답 데이터를 받겠다.
		);

		// Gson, Json, Simple, ObjectMapper라이브러리를 사용하여 자바객체로 만들 수 있다.
		ObjectMapper objectMapper = new ObjectMapper();
		KakaoTokenVO oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), KakaoTokenVO.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		System.out.println("카카오 액세스 토큰 : " + oauthToken.getAccess_token());

		RestTemplate rest_template_2 = new RestTemplate();

		// HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // 내가 지금 전송할 body data 가
																							// key=velue 형임을 명시

		// HttpHeader 와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);

		// Http 요청하기 - Post 방식으로 - 그리고 Response 변수의 응답 받음.
		ResponseEntity<String> response2 = rest_template_2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest, String.class // String 타입으로 응답 데이터를 받겠다.
		);
		
		System.out.println("유저정보 : " + response2.getBody());
		
		// Gson, Json, Simple, ObjectMapper
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoUserDataVO kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoUserDataVO.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// User 오브젝트 : userName, password, email
		System.out.println("카카오 아이디(번호) : " + kakaoProfile.getId());
		System.out.println("카카오 이메일 : " + kakaoProfile.getKakao_account().getEmail());

		System.out.println("블로그서버 유저네임 : " + kakaoProfile.getKakao_account().getEmail() + "_" + kakaoProfile.getId());
		System.out.println("블로그서버 이메일 : " + kakaoProfile.getKakao_account().getEmail());
		// UUID garbagePassword = UUID.randomUUID(); 
		// UUID란 -> 중복되지 않는 어떤 특정 값을 만들어내는 알고리즘
		//	 System.out.println("블로그서버 패스워드 : " + garbagePassword); // DB에 넣기위한 랜덤 임시 비밀번호
		
		
		
		User kakao_member = (User)member_detail_service.loadUserByUsername(String.valueOf(kakaoProfile.getId()));
		
		
		if(kakao_member.getUsername() == null) {
			System.out.println("기존 회원이 아닙니다. ~~~");
			
			MemberVO kakao_member_vo = new MemberVO();
			
			kakao_member_vo.setMember_user_id(kakao_member.getUsername());
			kakao_member_vo.setMember_passwd(kakao_member.getPassword());
			kakao_member_vo.setMember_tel(kakaoProfile.getKakao_account().getPhone_number());
			kakao_member_vo.setMember_name(kakaoProfile.getKakao_account().getName());
			
			member_service.registerMember(kakao_member_vo);			
		}
		
		// 로그인 처리
		Authentication authentication = authentication_manager.authenticate(new UsernamePasswordAuthenticationToken(kakao_member.getUsername(), "kakao"));
		
		SecurityContextHolder.getContext().setAuthentication(authentication);
		
		// OAuth로 로그인한 회원은 회원정보를 수정하지 못하게 해야된다.
		
		return "redirect:/index";
    }
    
    
	
}
