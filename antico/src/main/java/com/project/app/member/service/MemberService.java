package com.project.app.member.service;

import java.util.Map;

import com.project.app.member.domain.MemberVO;

public interface MemberService {
	
	// 회원가입 메소드
	int registerMember(MemberVO mvo);
	
	// 단일 사용자 정보 조회
	MemberVO getMember(String member_user_id);

	
	
	
}
