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

	@Value("${kakao.apikey}")
	private String kakao_api_key;
	
	@Value("${pointcharge.chargekey}")
	private String pointcharge_chargekey;
	
	@Autowired
	private MypageService service;
	
	@GetMapping("mypagemain")
	public ModelAndView mypagemain(HttpServletRequest request, ModelAndView mav) {
		
	//	mav.addObject("category_detail_list", category_detail_list);
		mav.addObject("kakao_api_key", kakao_api_key);
		mav.setViewName("mypage/mypage");
		return mav;
	}
	
	@GetMapping("pointcharge")
	public ModelAndView pointcharge(HttpServletRequest request, ModelAndView mav) {
		
	//	int n  = service.pointcharge(); // 결제하기를 눌렀을 경우 회원의 포인트 업데이트
		
	//	mav.addObject("n", n);
		mav.addObject("pointcharge_chargekey", pointcharge_chargekey);
		mav.setViewName("mypage/pointcharge");
		return mav;
	}
	
	@GetMapping("sellList")
	public ModelAndView sellList(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/sellList");
		return mav;
	}
	
	@GetMapping("buyList")
	public ModelAndView buyList(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/buyList");
		return mav;
	}
	
	@GetMapping("myBank")
	public ModelAndView myBank(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("mypage/myBank");
		return mav;
	}
	
	@GetMapping("memberDelete")
	public ModelAndView memberDelete(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mypage/memberDelete");
		return mav;
	}
	
	@PostMapping("deletesubmit")
	@ResponseBody
	public Map<String, Integer> deleteSubmit(@RequestBody LeaveVO lvo) {
	    // 탈퇴 신청 정보 저장
	    int n = service.deletesubmit(lvo);
	    
	    Map<String, Integer> paraMap = new HashMap<>();
	    paraMap.put("n", n);
	    
	    return paraMap;
	}


	@PostMapping("/chargeComplete")
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


	
}
