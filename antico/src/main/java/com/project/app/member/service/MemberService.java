package com.project.app.member.service;

import com.project.app.member.domain.MemberVO;

public interface MemberService {
	
	int registerMember(MemberVO mvo);
	
	// 단일 사용자 정보 조회
	MemberVO getMember(String memberNo);
	
}
