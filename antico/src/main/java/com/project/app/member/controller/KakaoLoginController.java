package com.project.app.member.controller;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.app.member.domain.KakaoUserInfoResponseVO;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.KakaoLoginService;

@RestController
@RequestMapping("kakaologin")
public class KakaoLoginController {
	
	@Autowired
    private KakaoLoginService kakao_login_service;

	@Autowired
	private MemberVO member_vo;
	
    @GetMapping("/callback")
    public ResponseEntity<?> callback(@RequestParam("code") String code) {
        String accessToken = kakao_login_service.getAccessTokenFromKakao(code);

        KakaoUserInfoResponseVO userInfo = kakao_login_service.getUserInfo(accessToken);
        
        
        member_vo.setMember_name(userInfo.getKakaoAccount().getName());
        
        member_vo.setMember_tel(userInfo.getKakaoAccount().getPhoneNumber());
        
        return ResponseEntity.status(HttpStatus.MOVED_PERMANENTLY)
                .location(URI.create("http://localhost/antico/index"))
                .build();
        		
    }
	
}
