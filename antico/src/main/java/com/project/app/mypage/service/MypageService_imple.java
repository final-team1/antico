package com.project.app.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.mypage.model.MypageDAO;

@Service
public class MypageService_imple implements MypageService {

    @Autowired
    private MypageDAO mypagedao;
    
	// 탈퇴 테이블 탈퇴신청시 insert
    @Transactional
	@Override
	public int delete_submit(Map<String, String> paraMap) {
		int n = mypagedao.delete_submit(paraMap);
		int m = mypagedao.statusUpdate(paraMap);
		return n;
	}

	// 포인트 충전
	@Override
	public int pointcharge(Map<String, String> paraMap) {
		int n = mypagedao.pointcharge(paraMap); // 충전테이블 insert
		int m = 0;
		if(n == 1) {
			m = mypagedao.pointupdate(paraMap); // 회원의 포인트 update
		}
		int x = 0;
		if(m == 1) {
			x = mypagedao.point_history(paraMap); // 포인트가 충전되면 포인트내역 테이블에 insert
		}
		return n*m*x;
	}

	// 회원의 총 충전금액을 알아오기 위한 용도 (등급때매)
	@Override
	public int point_sum(String pk_member_no, String charge_price) {
		int n = mypagedao.point_sum(pk_member_no);
		int x = n/1000;
		if(x <= 1700) { // 회원의 총 충전금액이 170이하까지만 업데이트
			int m = mypagedao.score_update(pk_member_no, String.valueOf(Integer.parseInt(charge_price)/1000));
		}
		
		
		return n;
	}

	// 마이페이지 내상품 조회하기
	@Override
	public List<Map<String, String>> myproduct(String mvo) {
		List<Map<String, String>> myproduct_list = mypagedao.myproduct(mvo);
		return myproduct_list;
	}
	
	// 판매자 정보 불러오기
	@Override
	public Map<String, String> sellerList(String mvo) {
		Map<String, String> seller_list = mypagedao.sellerList(mvo);
		return seller_list;
	}

	// 등급 업데이트
	@Override
	public void role_update(String role, String pk_member_no) {
		mypagedao.role_update(role, pk_member_no);
	}

	// 존재하는 회원인지 조회
	@Override
	public Map<String, String> member_select(String member_no) {
		Map<String, String> member_info = mypagedao.member_select(member_no);
		return member_info;
	}

	// 로그인 한 회원의 판매확정된 판매내역들 가져오기
	@Override
	public List<Map<String, String>> sellList(String pk_member_no, String fk_seller_no, String search_sell, String search_date) {
		List<Map<String, String>> sell_list = mypagedao.sellList(pk_member_no, fk_seller_no, search_sell, search_date);
			
		return sell_list;
	}

	// 판매상세정보 가져오기
	@Override
	public Map<String, String> infoSell(String pk_trade_no) {
		Map<String, String> Info_sell = mypagedao.infoSell(pk_trade_no);
		return Info_sell;
	}

	// 상품페이지 이동
	@Override
	public String productNo(String pk_trade_no) {
		String pk_product_no = mypagedao.productNo(pk_trade_no);
		return pk_product_no;
	}

	 // 거래횟수와 단골을 알아오기 위함.
	@Override
	public Map<String, String> tradeCnt(String member_no) {
		Map<String, String> trade_map = new HashMap<>();
		String trade_cnt = mypagedao.tradeCnt(member_no);
		String vip_consumber = mypagedao.vipConsumer(member_no);
		if(vip_consumber == null) {
			vip_consumber = "0";
		}
		trade_map.put("trade_cnt", trade_cnt);
		trade_map.put("vip_consumber", vip_consumber);
		return trade_map;
	}

	// 계좌등록시 은행테이블 insert, 대표계좌 유무체크, 계좌테이블 등록
	@Override
	public int register_account(String pk_member_no, String account_num, String bank_name, String account_type) {
		int cnt = mypagedao.accountCnt(pk_member_no); // 회원의 등록계좌 수를 알아오는 용도
		if(cnt >= 2) { // 등록계좌가 2개 이상일 때
			throw new BusinessException(ExceptionCode.ACCOUNT_CREATE_FAILD);
		}
		List<Map<String, String>> account_map = mypagedao.accountMap(pk_member_no); // 동일한 계좌번호를 입력했을 때
		if(account_map.size() == 0 && "0".equals(account_type)) { // 등록계좌가 없으면서 첫 등록을 대표계좌로 하지 않았을 경우
			throw new BusinessException(ExceptionCode.ACCOUNT_INSERT_FAILD);
		}
		if(account_map != null && !account_map.isEmpty()) { // 등록 계좌가 존재할 경우
			String account_no = account_map.get(0).get("account_no");
				
			if(account_num.equals(account_no)) { // 동일한계좌번호 입력 예외처리
				throw new BusinessException(ExceptionCode.ACCOUNT_ALREADY_EXISTS);
			}
			if("1".equals(account_type)) { // 대표계좌로 설정했다라면
				int change_type = mypagedao.changeType(account_no); // 기존 계좌를 0으로 해제
			}
		}
		int account = mypagedao.registerAccount(pk_member_no, account_num, bank_name, account_type);
		return account;
	}

	// 회원의 계좌 리스트 조회
	@Override
	public List<Map<String, String>> bankList(String pk_member_no) {
		List<Map<String, String>> bankList = mypagedao.accountMap(pk_member_no);
		return bankList;
	}

	// 계좌 삭제
	@Override
	public int accountDelete(String account_no, String account_type) {
		if("1".equals(account_type)) {
			throw new BusinessException(ExceptionCode.ACCOUNT_DELETE_FAILD);
		}
		int response = mypagedao.accountDelete(account_no);
		return response;
	}

	// 대표계좌 변경
	@Override
	public int accountTypeUpdate(String account_no, String pk_member_no) {
		String main_account = mypagedao.main_account(pk_member_no); // 현재 대표계좌의 pk번호를 알아오기
		int response = mypagedao.accountTypeUpdate(account_no);
		if(main_account != "") { // 기존의 대표계좌가 존재한다라면
			int not_main = mypagedao.notMain(main_account); // 기존의 대표계좌를 해제
		}
		return response;
	}

	// 회원의 대표계좌 조회
	@Override
	public Map<String, String> bankMap(String pk_member_no) {
		Map<String, String> bank_map = mypagedao.bankMap(pk_member_no);
		return bank_map;
	}

	// 회원의 포인트 사용내역
	@Override
	public List<Map<String, String>> pointHistory(String pk_member_no) {
		List<Map<String, String>> point_history_list = mypagedao.pointHistory(pk_member_no);
		return point_history_list;
	}

	// 판매상품 개수 알아오기
	@Override
	public Map<String, String> saleCount(String member_no) {
		Map<String, String> sale_count = new HashMap<>();
		String sale = mypagedao.sale(member_no); // 판매중
		String reserved = mypagedao.reserved(member_no); // 예약중
		String submit = mypagedao.submit(member_no); // 판매완료
		sale_count.put("sale", sale);
		sale_count.put("reserved", reserved);
		sale_count.put("submit", submit);
		return sale_count;
	}
	
}
