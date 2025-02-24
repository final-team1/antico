package com.project.app.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.mypage.domain.ChargeVO;
import com.project.app.mypage.domain.LeaveVO;
import com.project.app.mypage.service.MypageService;
import com.project.app.product.domain.ProductVO;

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
	
	private ProductVO prod_vo = new ProductVO();
	
//	private final ProductVO prod_vo = new ProductVO();
	
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
	public ModelAndView mypagemain(ModelAndView mav) {
		member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String userid = member_vo.getMember_user_id(); // 회원아이디
		String member_name = member_vo.getMember_name(); // 회원이름
		String member_score = member_vo.getMember_score(); // 신뢰점수
		String member_point = member_vo.getMember_point(); // 회원의 포인트
		
		int point_sum = service.point_sum(pk_member_no); // 회원의 총 충전금액을 알아오기 위한 용도 (등급때매)
	//	System.out.println("point_sum 체크"+point_sum);
		
		int rank = point_sum / 1000; // 충전 포인트의 지수를 나타내기 위함
		int data = 0;
		String member_role = member_vo.getMember_role(); // 회원등급
		String role_color; // 회원등급별 색상을 주기 위한 것.
		if("0".equals(member_role)) {
			member_role = "브론즈";
			role_color = "#b87333";
			data = rank;
		} else if("1".equals(member_role)) {
			member_role = "실버";
			role_color = "#c0c0c0";
			data = rank - 1000;
			data = Math.min(700, data); // 나머지 30은 신뢰지수와 합산
		//	System.out.println(data+"data 확인");
		} else {
			member_role = "골드";
			role_color = "#ffd700";
		}
		
		List<Map<String, String>> myproduct = service.myproduct(pk_member_no); // 마이페이지에서 내상품 조회하기
		
		mav.addObject("myproduct", myproduct);
		mav.addObject("data", data);
		mav.addObject("userid", userid);
		mav.addObject("member_role", member_role);
		mav.addObject("role_color", role_color);
		mav.addObject("member_name", member_name);
		mav.addObject("member_point", member_point);
		
		mav.addObject("kakao_api_key", kakao_api_key);

		//	mav.addObject("category_detail_list", category_detail_list);
		mav.setViewName("mypage/mypage");
		
		
		
		
		return mav;
	}
	
	// 포인트 충전
	@GetMapping("pointcharge")
	public ModelAndView pointcharge(ModelAndView mav) {
		String member_user_id = member_vo.getMember_user_id(); // 회원아이디
		String pk_member_no = member_vo.getPk_member_no(); 	// 회원번호
		String member_role = member_vo.getMember_role(); 	// 회원등급
		String charge_commission;							// 회원의 수수료
		
		if("0".equals(member_role)) { 			// 브론즈일 때 수수료
			charge_commission = "5";
		} else if("1".equals(member_role)) { 	// 실버일 때 수수료
			charge_commission = "4";
		} else { 								// 골드일 때 수수료
			charge_commission = "3";
		}
		
		mav.addObject("member_user_id", member_user_id);
		mav.addObject("pk_member_no", pk_member_no);
		mav.addObject("charge_commission", charge_commission);
		mav.addObject("pointcharge_chargekey", pointcharge_chargekey);
		mav.setViewName("mypage/pointcharge");
		return mav;
	}
	
	@PostMapping("point_update")
	@ResponseBody
	public Map<String, Integer> point_update(@RequestBody ChargeVO chargevo) {
	//	System.out.println("point_update방문");
	//	String member_no = member_vo.getPk_member_no();
		String fk_member_no = chargevo.getFk_member_no(); // 회원번호
		String charge_price = chargevo.getCharge_price(); // 충전금액
		String charge_commission = chargevo.getCharge_commission(); // 수수료
		String point_history_reason = "포인트충전"; // 포인트내역 테이블 상세내역
		String member_point = member_vo.getMember_point(); // 회원의 현재 포인트
		int point_pct = (int) (Integer.parseInt(charge_price) * (Integer.parseInt(charge_commission)/100.0));
		
		int point_insert = Integer.parseInt(charge_price) - point_pct; // 수수료를 제외한 실제 충전금액
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_no", fk_member_no);
		paraMap.put("charge_price", charge_price);
		paraMap.put("charge_commission", charge_commission);
		paraMap.put("point_insert", String.valueOf(point_insert));
		paraMap.put("point_history_reason", point_history_reason);
		paraMap.put("member_point", member_point);
		
		int n  = service.pointcharge(paraMap); // 결제하기를 눌렀을 경우 회원의 포인트 업데이트
		
		Map<String, Integer> response = new HashMap<>();
		response.put("n", n);
		
		return response;
	}
	
	// 판매내역
	@GetMapping("sell_list")
	public ModelAndView sellList(ModelAndView mav) {
		mav.setViewName("mypage/sellList");
		return mav;
	}
	
	// 구매내역
	@GetMapping("buy_list")
	public ModelAndView buyList(ModelAndView mav) {
		mav.setViewName("mypage/buyList");
		return mav;
	}
	
	// 계좌관리
	@GetMapping("mybank")
	public ModelAndView myBank(ModelAndView mav) {
		mav.setViewName("mypage/myBank");
		return mav;
	}
	
	// 탈퇴뷰단
	@GetMapping("member_delete")
	public ModelAndView memberDelete(ModelAndView mav) {
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

	
	@GetMapping("mybank_list")
	public ModelAndView mybank_list(ModelAndView mav) {
		mav.setViewName("mypage/mybank_list");
		return mav;
	}
	
	@GetMapping("sellerpage")
	public ModelAndView sellerpage(ModelAndView mav) {

//		String fk_member_no = prod_vo.getFk_member_no(); // 판매자 회원번호
//		System.out.println("fk_member_no 체크"+fk_member_no);
		String n = "63"; // 테스트용
		Map<String, String> seller_info = service.sellerList(n); // 판매자 정보 불러오기
		System.out.println("seller_info 테스트" + seller_info);
		
		String member_role = String.valueOf(seller_info.get("member_role"));
		String member_name = String.valueOf(seller_info.get("member_name"));
		String member_score = String.valueOf(seller_info.get("member_score"));
		String role_color; // 회원등급별 색상을 주기 위한 것.
		if("0".equals(member_role)) {
			member_role = "브론즈";
			role_color = "#b87333";
		} else if("1".equals(member_role)) {
			member_role = "실버";
			role_color = "#c0c0c0";
		//	System.out.println(data+"data 확인");
		} else {
			member_role = "골드";
			role_color = "#ffd700";
		}
		
		mav.addObject("member_name", member_name);
		mav.addObject("member_role", member_role);
		mav.addObject("member_score", member_score);
		mav.addObject("role_color", role_color);
		mav.addObject("seller_info", seller_info);
		mav.setViewName("mypage/sellerpage");
		return mav;
	}
	
}
