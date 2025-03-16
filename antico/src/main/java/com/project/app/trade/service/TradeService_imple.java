package com.project.app.trade.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.component.ProductStatusChangedEvent;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.mypage.model.MypageDAO;
import com.project.app.product.model.ProductDAO;
import com.project.app.trade.domain.TradeVO;
import com.project.app.trade.model.TradeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TradeService_imple implements TradeService {

	@Autowired
    private TradeDAO tradedao;

	@Autowired
	private ProductDAO pdao;
	
	@Autowired
	private MypageDAO mydao;

	@Autowired
	private ApplicationEventPublisher eventPublisher; // 이벤트 발행 객체
	
	// 판매상세에서 구매하기 클릭 전 상품판매상태 체크 및 제품정보 가져오기
	@Override
	public Map<String, String> getProduct(String pk_product_no, String pk_member_no) {
		Map<String, String> product_map = pdao.getProductInfo(pk_product_no);
		String product_sale_status = product_map.get("product_sale_status");
		
		String host_no = product_map.get("fk_member_no");
		if(pk_member_no.equals(host_no)) { // 판매자가 구매할 경우 예외 처리하기
			throw new BusinessException(ExceptionCode.MYPRODUCT_PAY_FAILD);
		}
		
		if(!"0".equals(product_sale_status)) { // 판매중인 상품이 아니라면 예외처리
			throw new BusinessException(ExceptionCode.RPODUCT_NOT_ON_SALE);
		}

		return product_map;
	}

	// 구매를 하면 포인트를 차감 update, 상품상태를 예약중으로 변경 update, 포인트내역 insert, 거래 insert
	@Override
	@Transactional
	public int purchase(String pk_product_no, String member_no, String pk_member_no, String product_price, String member_point) {
		
		String statusCheck = tradedao.statusCheck(pk_product_no); // 구매상태 조회
		
		if("1".equals(statusCheck)) {
			log.error("이미 예약중인 상태");
			throw new BusinessException(ExceptionCode.ALREADY_RESERVED_ERROR);
		}
		
		String reason = "상품구매";
		int a = tradedao.deductPoint(product_price, pk_member_no); // 구매를 하면 포인트를 차감하기
		int b = tradedao.holdProduct(pk_product_no); // 상품상태를 예약중으로 변경하기
		int c = tradedao.usePoint(pk_member_no, product_price, member_point, reason); // 포인트내역에 사용정보 insert
		int d = tradedao.trade(pk_product_no, member_no, pk_member_no); // 거래테이블에 거래정보들 insert

		// tradedao.holdProduct(pk_product_no); // 상품상태를 예약중으로 변경하기
		// 위의 기능이 정상적으로 동작하여 커밋이 완료되면 채팅 알림 이벤트 실행
		eventPublisher.publishEvent(new ProductStatusChangedEvent(pk_product_no, "1", pk_member_no));

		return a*b*c*d;
	}

	// 구매확정을 했을 때
	@Override
	@Transactional
	public int order_completed(String pk_product_no, String product_price, String pk_member_no, String fk_member_no) {
		int a = 0;
		int b = 0;
		int c = 0;
		int d = 0;
		
		String reason = "상품판매";
		String pk_trade_no = tradedao.purchaseSelect(pk_product_no, pk_member_no); // 구매를 먼저 했는지 조회
		String statusCheck = tradedao.statusCheck(pk_product_no); // 이미 구매 확정을 했는지 조회

		if(pk_trade_no != null) { //구매를 먼저 한 상태라면
			if ("2".equals(statusCheck)) { // 이미 구매확정이라면
				log.error("이미 구매확정 상태");
				throw new BusinessException(ExceptionCode.PAYMENT_ALREADY_EXISTS);
			}

			Map<String, String> member_select = mydao.member_select(fk_member_no);
			String member_point = member_select.get("member_point");
			a = tradedao.plusPoint(product_price, fk_member_no); // 판매자 포인트 증가 업데이트
			b = tradedao.completedProduct(pk_product_no); // 판매상태를 구매확정으로 업데이트
			c = tradedao.completedTrade(pk_product_no); // 구매상태를 결제확정으로 업데이트
			d = tradedao.usePoint(fk_member_no, product_price, member_point, reason); // 포인트내역에 사용정보 insert
		}
		else { // 구매를 안 한 경우라면
			throw new BusinessException(ExceptionCode.NOT_PAYMENT_CONSUMER);
		}

		// tradedao.completedProduct(pk_product_no); // 판매상태를 구매확정으로 업데이트
		// 위의 기능이 정상적으로 동작하여 커밋이 완료되면 채팅 알림 이벤트 실행
		eventPublisher.publishEvent(new ProductStatusChangedEvent(pk_product_no, "2", pk_member_no));

		return a*b*c*d;
	}

	// 상품 일련번호를 통한 거래 내역 조회
	@Override
	public TradeVO getTradeByProductNo(String pkProductNo) {
		return tradedao.selectTradeByProductNo(pkProductNo)
			.orElseThrow(() -> new BusinessException(ExceptionCode.TRADE_NOT_FOUND));
	}

	// 구매취소 처리
	@Override
	public int Cancel(String product_price, String pk_product_no, String pk_member_no, String reason) {
		int n = 0;
		String pk_trade_no = tradedao.purchaseSelect(pk_product_no, pk_member_no); // 구매를 먼저 했는지 조회
		String statusCheck = tradedao.statusCheck(pk_product_no); // 이미 구매 확정을 했는지 조회
		if(pk_trade_no != null) { //구매를 먼저 한 상태라면
			Map<String, String> member_select = mydao.member_select(pk_member_no);
			String member_point = member_select.get("member_point");
			int point = tradedao.returnPoint(product_price, pk_member_no); // 결제한 금액만큼 포인트를 돌려준다.
			int sell = tradedao.onSell(pk_product_no); // 판매중으로 다시 변경
			int cancel_data = tradedao.cancelData(pk_member_no, product_price, member_point, reason); // 포인트내역에 기록을 남기기
			int buy_cancel = tradedao.buyCancel(pk_product_no); // 거래를 구매취소로 변경하고, 거래취소날짜 업데이트
			n = point*sell*cancel_data*buy_cancel;
		} else if ("0".equals(statusCheck)) {
			throw new BusinessException(ExceptionCode.CANCEL_AREADY_EXISTS);
		} else if ("2".equals(statusCheck)) {
			throw new BusinessException(ExceptionCode.PAYMENT_ALREADY_EXISTS);
		}
		return n;
	}

}
