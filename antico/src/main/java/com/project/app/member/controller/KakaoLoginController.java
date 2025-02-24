package com.project.app.member.controller;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.KakaoUserInfoResponseVO;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.KakaoLoginService;
import com.project.app.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("kakaologin")
public class KakaoLoginController {
	
	@Autowired
    private KakaoLoginService kakao_login_service;

	@Autowired
	private MemberVO member_vo;
	
	@Autowired
	private MemberService member_service;
	
	@Autowired
	private PasswordEncoder password_encoder;
	
    @GetMapping("/callback")
    public ResponseEntity<?> callback(@RequestParam("code") String code,
    		RedirectAttributes redirectAttributes) {
    	
    	
        String accessToken = kakao_login_service.getAccessTokenFromKakao(code);
        
        // 토큰을 사용하여 카카오에서 유저정보를 받아 KakaoUserInfoResponseVO타입으로 user_info에 저장
        KakaoUserInfoResponseVO user_info = kakao_login_service.getUserInfo(accessToken);
        
        // 카카오로그인 정보의 아이디와 회원가입되어있는 회원의 아이티를 비교하여 회언가입이 되어있는지 체크와 동시에 회원의 정보를 가져온다.
        member_vo = member_service.kakaoRegistCheckByUserId(user_info);
        
        
        redirectAttributes.addFlashAttribute("member_user_id",member_vo.getMember_user_id());
        redirectAttributes.addFlashAttribute("member_passwd","kakao");
        
        
        
        return ResponseEntity.status(HttpStatus.MOVED_PERMANENTLY)
                .location(URI.create("http://localhost/antico/member/login"))
                .build();
    }
	
}
