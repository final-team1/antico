package com.project.app.trade.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.product.model.ProductDAO;
import com.project.app.trade.model.TradeDAO;

@Service
public class TradeService_imple implements TradeService {

	@Autowired
    private TradeDAO tradedao;

	@Autowired
	private ProductDAO pdao;
	
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
	
	
}
