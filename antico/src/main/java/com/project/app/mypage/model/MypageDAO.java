package com.project.app.mypage.model;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.member.domain.MemberVO;
import com.project.app.mypage.domain.LoginHistoryVO;

@Mapper
public interface MypageDAO {

	// 탈퇴 처리 로직
	int deletesubmit(MemberVO mvo);

	// 결제하기를 눌렀을 경우 해당 포인트 업데이트
//	int pointcharge();

}
