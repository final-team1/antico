package com.project.app.member.service;

import java.util.Map;

import com.project.app.member.domain.MemberVO;

public interface MemberService {
	
	// 회원가입 메소드
	int registerMember(MemberVO mvo);
	
	// 단일 사용자 정보 조회
	MemberVO getMember(String member_user_id);

	void google_tel_add(String member_tel);

	MemberVO getMemberByMemberNo (String pk_member_no);

	void updateScore(String fkSellerNo, int score);

}
