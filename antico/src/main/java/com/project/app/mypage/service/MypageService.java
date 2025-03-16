package com.project.app.mypage.service;

import java.util.List;
import java.util.Map;



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
	Map<String, String> member_select(String member_no);

	// 로그인 한 회원의 판매확정된 판매내역들 가져오기
	List<Map<String, String>> sellList(String pk_member_no, String fk_seller_no, String search_sell, String search_date);

	// 판매상세정보 가져오기
	Map<String, String> infoSell(String pk_trade_no);

	// 상품페이지 이동
	String productNo(String pk_trade_no);

	 // 거래횟수와 단골을 알아오기 위함.
	Map<String, String> tradeCnt(String member_no);

	// 계좌등록시 은행테이블 insert, 대표계좌 유무체크, 계좌테이블 등록
	int register_account(String pk_member_no, String account_num, String bank_name, String account_type);

	// 회원의 계좌 리스트 조회
	List<Map<String, String>> bankList(String pk_member_no);

	// 계좌 삭제
	int accountDelete(String account_no, String account_type);

	// 대표계좌 변경
	int accountTypeUpdate(String account_no, String pk_member_no);

	// 회원의 대표계좌 조회
	Map<String, String> bankMap(String pk_member_no);

	// 회원의 포인트 사용내역
	List<Map<String, String>> pointHistory(String pk_member_no);

	// 판매상품 개수 알아오기
	Map<String, String> saleCount(String member_no);





}
