package com.project.app.mypage.service;

import java.util.List;
import java.util.Map;

import com.project.app.member.domain.MemberVO;


public interface MypageService {

    // 탈퇴테이블 insert
	int delete_submit(Map<String, String> paraMap);

	// 결제하기를 눌렀을 경우 회원의 포인트 업데이트
	int pointcharge(Map<String, String> paraMap);

	// 회원의 총 충전금액을 알아오기 위한 용도 (등급때매)
	int point_sum(String pk_member_no, String charge_price);

	// 판매자 정보 불러오기
	List<Map<String, String>> myproduct(String mvo);

	// 판매자 정보 불러오기
	Map<String, String> sellerList(String mvo);

	// 회워의 등급 업데이트
	void role_update(String role, String pk_member_no);

	// 존재하는 회원인지 조회
	String member_select(String member_no);





}
