package com.project.app.trade.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.product.model.ProductDAO;
import com.project.app.trade.model.TradeDAO;

@Service
public class TradeService_imple implements TradeService {

	@Autowired
    private TradeDAO tradedao;

	@Autowired
	private ProductDAO pdao;
	
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
	public int purchase(String pk_product_no, String member_no, String pk_member_no, String product_price, String member_point) {
		int a = tradedao.deductPoint(product_price, pk_member_no); // 구매를 하면 포인트를 차감하기
		int b = tradedao.holdProduct(pk_product_no); // 상품상태를 예약중으로 변경하기
		int c = tradedao.usePoint(pk_member_no, product_price, member_point); // 포인트내역에 사용정보 insert
		int d = tradedao.trade(pk_product_no, member_no, pk_member_no); // 거래테이블에 거래정보들 insert
		System.out.println("a"+a);
		System.out.println("b"+a);
		System.out.println("c"+a);
		System.out.println("d"+a);
		return a*b*c*d;
	}
	
	
}
