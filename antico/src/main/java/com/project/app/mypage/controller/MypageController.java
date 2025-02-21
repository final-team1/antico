package com.project.app.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.project.app.component.GetMemberDetail;
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
	
	@Autowired
	private GetMemberDetail get_member_detail;
	
	@Autowired
	private MemberVO member_vo;
	
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
		
		String userid = member_vo.getMember_user_id();
		
		mav.addObject("userid", userid);
	//	mav.addObject("category_detail_list", category_detail_list);
		mav.addObject("kakao_api_key", kakao_api_key);
		mav.setViewName("mypage/mypage");
		
		member_vo = get_member_detail.MemberDetail();
		
		
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
	
	// 탈퇴뷰단
	@GetMapping("member_delete")
	public ModelAndView memberDelete(HttpServletRequest request, ModelAndView mav) {
		String pk_member_no = member_vo.getPk_member_no();
		mav.addObject("pk_member_no", pk_member_no);
		mav.setViewName("mypage/memberDelete");
		return mav;
	}
	
	// 탈퇴 신청시 탈퇴테이블에 insert
	@PostMapping("delete_submit")
	@ResponseBody
	public Map<String, Integer> delete_submit(@RequestBody LeaveVO lvo) {
		String fk_member_no = lvo.getFk_member_no();
	    String leave_reason = lvo.getLeave_reason();
	    System.out.println("lvo 회원번호: " + fk_member_no);
	    System.out.println("lvo 탈퇴 사유: " + leave_reason);

	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("fk_member_no", fk_member_no);
	    paraMap.put("leave_reason", leave_reason);

	    int n = service.delete_submit(paraMap);
	    System.out.println(n + "delete_submit 확인");

	    Map<String, Integer> response = new HashMap<>();
	    response.put("n", n);

	    return response;
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
