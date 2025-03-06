package com.project.app.mypage.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.member.domain.MemberVO;

@Mapper
public interface MypageDAO {

	// 탈퇴 테이블 탈퇴신청시 insert
	int delete_submit(Map<String, String> paraMap);

	// 결제하기를 눌렀을 경우 회원의 포인트 업데이트
	int pointcharge(Map<String, String> paraMap);

	// 회원의 포인트를 업데이트
	int pointupdate(Map<String, String> paraMap);

	// 포인트가 충전되면 포인트내역 테이블에 insert
	int point_history(Map<String, String> paraMap);

	// 회원의 총 충전금액을 알아오기 위한 용도 (등급때매)
	int point_sum(String pk_member_no);

	// 총 충전금액이 일정금액 이상이면 등급을 올려준다
	int score_update(String pk_member_no, String charge_price);

	// 총 충전금액이 일정금액 이상이면 등급을 올려준다
	void role_update(String role, String pk_member_no);

	// 마이페이지 내상품 조회
	List<Map<String, String>> myproduct(String mvo);

	// 판매자 정보 불러오기
	Map<String, String> sellerList(String mvo);

	// 존재하는 회원인지 조회
	Map<String, String> member_select(String member_no);

	// 로그인 한 회원의 판매확정된 판매내역들 가져오기
	List<Map<String, String>> sellList(String pk_member_no, String fk_seller_no, String search_sell, String search_date);

	// 판매상세정보 가져오기
	Map<String, String> infoSell(String pk_trade_no);

	// 상품페이지 이동
	String productNo(String pk_trade_no);

	int statusUpdate(Map<String, String> paraMap);


}
