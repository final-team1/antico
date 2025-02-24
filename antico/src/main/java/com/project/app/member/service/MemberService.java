package com.project.app.member.service;

import java.util.Map;

import com.project.app.member.domain.KakaoUserInfoResponseVO;
import com.project.app.member.domain.MemberVO;

public interface MemberService {
	
	// 회원가입 메소드
	int registerMember(MemberVO mvo);
	
	// 단일 사용자 정보 조회
	MemberVO getMember(String memberNo);

	// 카카오로그인 정보의 아이디와 회원가입되어있는 회원의 아이티를 비교하여 회언가입이 되어있는지 체크와 동시에 회원의 정보를 가져온다.
	MemberVO kakaoRegistCheckByUserId(KakaoUserInfoResponseVO user_info);

	
	
}
