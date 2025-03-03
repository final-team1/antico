package com.project.app.trade.controller;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.component.GetMemberDetail;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.member.domain.MemberVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.trade.service.TradeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j // sysout을 찍을 필요 없음 log 역할
@Controller
@RequestMapping(value="/trade/*")
public class TradeController {

	@Autowired
	private GetMemberDetail get_member_detail;
	
	
	@Autowired
	private TradeService service;
	
	@PostMapping("show_payment")
	@ResponseBody
	public ModelAndView payment(@RequestParam String pk_product_no, ModelAndView mav) {
		// 컨트롤러에서 불러오는 데이터가 유효한지 체크
		// 반환되는 데이터도 유효한지 체크
		if(!NumberUtils.isDigits(pk_product_no)) { // 제품번호를 존재하는 번호가 아닌 이외의 값들을 입력했을 때
			log.error("Pk_product_no가 유효하지 않습니다. :"+pk_product_no);
			throw new BusinessException(ExceptionCode.PAYMENT_LOAD_FAILD); 
		}
		
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		Map<String, String> show_payment_map = service.getProduct(pk_product_no, pk_member_no);
		
		
	//	System.out.println("성공함");
		
		mav.addObject("member_vo", member_vo);
		mav.addObject("show_payment_map", show_payment_map);
		mav.setViewName("trade/show_payment");
		return mav;
	}
	
	// 구매하기를 했을 때
	@PostMapping("purchase")
	@ResponseBody
	public int purchase(@RequestParam String pk_product_no, @RequestParam String member_no, @RequestParam String product_price) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String member_point = member_vo.getMember_point();
		// 구매를 하면 포인트를 차감 update, 상품상태를 예약중으로 변경 update, 포인트내역 insert, 거래 insert
		int n = service.purchase(pk_product_no, member_no, pk_member_no, product_price, member_point);
		
		return n;
	}
	
	// 구매확정을 했을 때
	@PostMapping("order_completed")
	@ResponseBody
	public int orderCompleted(@RequestParam String pk_product_no, @RequestParam String product_price, @RequestParam String fk_member_no) {
		// pk_product_no 상품번호, product_price 상품금액, pk_member_no 로그인한 회원, fk_member_no 판매자
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
	//	Map<String, String> show_payment_map = service.getProduct(pk_product_no, pk_member_no);
		int n = service.order_completed(pk_product_no, product_price, pk_member_no, fk_member_no);
		return n;
	}
}
