package com.project.app.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.app.member.domain.MemberVO;
import com.project.app.mypage.domain.LeaveVO;
import com.project.app.mypage.domain.LoginHistoryVO;
import com.project.app.mypage.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping(value="/mypage/*")
public class MypageController {

	// 카카오 api키
	@Value("${kakao.apikey}")
	private String kakao_api_key;
	
	// 이니시스결제 api 키
	@Value("${pointcharge.chargekey}")
	private String pointcharge_chargekey;
	
	@Autowired
	private MypageService service;
	
	// 마이페이지 메인
	@GetMapping("mypagemain") 
	public ModelAndView mypagemain(HttpServletRequest request, ModelAndView mav) {
		
	//	mav.addObject("category_detail_list", category_detail_list);
		mav.addObject("kakao_api_key", kakao_api_key);
		mav.setViewName("mypage/mypage");
		return mav;
	}
	
	// 포인트 충전
	@GetMapping("pointcharge")
	public ModelAndView pointcharge(HttpServletRequest request, ModelAndView mav) {
		
	//	int n  = service.pointcharge(); // 결제하기를 눌렀을 경우 회원의 포인트 업데이트
		
	//	mav.addObject("n", n);
		mav.addObject("pointcharge_chargekey", pointcharge_chargekey);
		mav.setViewName("mypage/pointcharge");
		return mav;
	}
	
	// 판매내역
	@GetMapping("sell_list")
	public ModelAndView sellList(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/sellList");
		return mav;
	}
	
	// 구매내역
	@GetMapping("buy_list")
	public ModelAndView buyList(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/buyList");
		return mav;
	}
	
	// 계좌관리
	@GetMapping("mybank")
	public ModelAndView myBank(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/myBank");
		return mav;
	}
	
	// 탈퇴하기
	@GetMapping("member_delete")
	public ModelAndView memberDelete(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mypage/memberDelete");
		return mav;
	}
	
	@PostMapping("delete_submit")
	@ResponseBody
	public Map<String, Integer> deleteSubmit(@RequestBody LeaveVO lvo) {
	    // 탈퇴 신청 정보 저장
	    int n = service.deletesubmit(lvo);
	    
	    Map<String, Integer> paraMap = new HashMap<>();
	    paraMap.put("n", n);
	    
	    return paraMap;
	}
	
	// 충전하기 결제
	@PostMapping("/charge_complete")
	@ResponseBody
	public Map<String, Object> chargeComplete(@RequestBody Map<String, Object> requestData) {
	    String memberUserId = (String) requestData.get("memberUserId");
	    int chargeAmount = (int) requestData.get("chargeAmount");
	    String impUid = (String) requestData.get("imp_uid");
	    String merchantUid = (String) requestData.get("merchant_uid");

	 //   int result = pointService.chargePoint(memberUserId, chargeAmount, impUid, merchantUid);
	    
	    Map<String, Object> response = new HashMap<>();
	 //   response.put("success", result > 0);
	    return response;
	}

	@GetMapping("mybank_list")
	public ModelAndView mybank_list(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/mybank_list");
		return mav;
	}
	
	
}
