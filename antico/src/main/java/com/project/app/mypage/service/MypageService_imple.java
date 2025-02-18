package com.project.app.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.member.domain.MemberVO;
import com.project.app.mypage.domain.LoginHistoryVO;
import com.project.app.mypage.model.MypageDAO;

@Service
public class MypageService_imple implements MypageService {

	@Autowired
	private MypageDAO mypagedao;

	
	// 탈퇴 처리 로직
	@Override
	public int deletesubmit(MemberVO mvo, LoginHistoryVO lhvo) {

		// 회원상태 업데이트
	//	int a = mypagedao.deletesubmit1(mvo);
		
		// 탈퇴테이블 insert
	//s	int b = mypagedao.deletesubmit2(mvo);
		
		
		
		return 0;
	}
	

	
}
