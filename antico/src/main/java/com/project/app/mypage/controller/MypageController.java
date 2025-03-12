package com.project.app.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.prefs.BackingStoreException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.Oauth2Service;
import com.project.app.mypage.domain.ChargeVO;
import com.project.app.mypage.domain.LeaveVO;
import com.project.app.mypage.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;


@RequiredArgsConstructor
@Controller
@RequestMapping(value="/mypage/*")
public class MypageController {
	
	
	private final GetMemberDetail get_member_detail;
	
	private final Oauth2Service oauth2_service;
	
	// 카카오 api키
	@Value("${kakao.apikey}")
	private String kakao_api_key;
	
	// 이니시스결제 api 키
	@Value("${pointcharge.chargekey}")
	private String pointcharge_chargekey;
	
	private final MypageService service;
	
	@GetMapping("/mypagecheck")
	@ResponseBody
	public Map<String, Object> myPageCheck() {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
	    Map<String, Object> result = new HashMap<>();
        result.put("pk_member_no", pk_member_no);
	    return result;
	}
	
	// 마이페이지 메인
	@GetMapping("mypagemain/{member_no}")
	@ResponseBody
	public ModelAndView mypagemain(@PathVariable String member_no, ModelAndView mav) {
	    // favicon.ico 요청 방지
	    if ("favicon.ico".equals(member_no)) {
	        return mav;
	    }

	    // 현재 로그인한 회원 정보 가져오기
	    MemberVO member_vo = get_member_detail.MemberDetail();
	    if (member_vo == null) {
	        mav.setViewName("error/404");
	        return mav;
	    }

	    String pk_member_no = member_vo.getPk_member_no();
	    String userid = member_vo.getMember_user_id();
	    String member_name = member_vo.getMember_name();
	    String member_point = member_vo.getMember_point();
	    String member_score = member_vo.getMember_score();
	    String member_role = member_vo.getMember_role();

	    // URL에 입력된 회원 번호로 회원 정보 조회
	    Map<String, String> member_info = service.member_select(member_no);
	    if (member_info == null) {
	        mav.setViewName("error/404");
	        return mav;
	    }

	    String mvo = member_info.get("pk_member_no");
	    String seller_name = member_info.get("member_name");
	    // 신뢰지수에 따른 역할 업데이트
	    if (Integer.parseInt(member_score) >= 1000) {
	        String role = Integer.parseInt(member_score) < 2000 ? "1" : "2";
	        service.role_update(role, pk_member_no);
	    }

	    Map<String, String> trade_map = service.tradeCnt(member_no); // 거래횟수와 단골을 알아오기 위함.
		String role_color; // 회원등급별 색상을 주기 위한 것.
		if("0".equals(member_role)) {
			member_role = "브론즈";
			role_color = "#b87333";
		} else if("1".equals(member_role)) {
			member_role = "실버";
			role_color = "#c0c0c0";
		} else {
			member_role = "골드";
			role_color = "#ffd700";
		}
	    List<Map<String, String>> myproduct_list = service.myproduct(mvo);

	    // 판매자 정보 설정
	    try {
	        Map<String, String> seller_info = service.sellerList(mvo);
	        setSellerInfo(mav, seller_info, myproduct_list.size());
	    } catch (NullPointerException e) {
	        setSellerInfo(mav, member_info, myproduct_list.size());
	    }

	    // 마이페이지 또는 판매자 페이지 설정
	    if (pk_member_no.equals(mvo)) {
	        mav.setViewName("mypage/mypage");
	    } else {
	        mav.setViewName("mypage/sellerpage");
	    }

	    mav.addObject("trade_map", trade_map);
	    mav.addObject("mvo", mvo);
	    mav.addObject("seller_name", seller_name);
	    mav.addObject("myproduct_list", myproduct_list);
	    mav.addObject("member_score", member_score);
	    mav.addObject("userid", userid);
	    mav.addObject("member_role", member_role);
	    mav.addObject("role_color", role_color);
	    mav.addObject("member_name", member_name);
	    mav.addObject("member_point", member_point);
	    mav.addObject("pk_member_no", pk_member_no);
	    mav.addObject("kakao_api_key", kakao_api_key);

	    return mav;
	}

	// 판매자 정보 설정 메서드
	private void setSellerInfo(ModelAndView mav, Map<String, String> seller_info, int list_size) {
	    String seller_role = seller_info.get("member_role");
	    String seller_role_color = "";
	    String member_score = seller_info.get("member_score");
		if("0".equals(seller_role)) {
			seller_role = "브론즈";
			seller_role_color = "#b87333";
		} else if("1".equals(seller_role)) {
			seller_role = "실버";
			seller_role_color = "#c0c0c0";
		} else {
			seller_role = "골드";
			seller_role_color = "#ffd700";
		}
		
	    mav.addObject("seller_role_color", seller_role_color);
	    mav.addObject("seller_role", seller_role);
	    mav.addObject("seller_info", seller_info);
	    mav.addObject("list_size", list_size);
	}

	// 포인트 충전
	@GetMapping("pointcharge")
	public ModelAndView pointcharge(ModelAndView mav) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String member_user_id = member_vo.getMember_user_id(); // 회원아이디
		String pk_member_no = member_vo.getPk_member_no(); 	   // 회원번호
		String member_role = member_vo.getMember_role(); 	   // 회원등급
		String charge_commission;							   // 회원의 수수료
		
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
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String fk_member_no = chargevo.getFk_member_no(); // 회원번호
		String charge_price = chargevo.getCharge_price(); // 충전금액
		String charge_commission = chargevo.getCharge_commission(); // 수수료
		String point_history_reason = "포인트충전"; // 포인트내역 테이블 상세내역
		String member_point = member_vo.getMember_point(); // 회원의 현재 포인트
		
		
		int point_pct = (int) (Integer.parseInt(charge_price) * (Integer.parseInt(charge_commission)/100.0));
		
		int point_insert = Integer.parseInt(charge_price) - point_pct; // 수수료를 제외한 실제 충전금액
		
		int point_sum = service.point_sum(pk_member_no, charge_price); // 회원의 총 충전금액을 알아오고 충전금액만큼 포인트충전하기
		
		
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
	@ResponseBody
	public ModelAndView sellList(ModelAndView mav) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String fk_seller_no = "fk_seller_no";
		String search_sell = "";
		String search_date = "";
		List<Map<String, String>> sell_list = service.sellList(pk_member_no, fk_seller_no, search_sell, search_date); // 로그인 한 회원의 판매확정된 판매내역들 가져오기
		search_sell = search_sell.trim(); // 검색어 공백 없애주기
		mav.addObject("search_sell", search_sell);  // 검색어 전달
		mav.addObject("sell_list", sell_list);
		mav.setViewName("mypage/sellList");
		return mav;
	}
	
	// 검색어가 있는 경우
	@PostMapping("search_list")
	@ResponseBody
	public List<Map<String, String>> search_list (@RequestParam(defaultValue = "") String search_sell, @RequestParam(defaultValue = "") String search_date) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String fk_seller_no = "fk_seller_no";
		List<Map<String, String>> sell_list = service.sellList(pk_member_no, fk_seller_no, search_sell, search_date); // 로그인 한 회원의 판매확정된 판매내역들 가져오기
		return sell_list;
	}
	
	@PostMapping("sell_list_info")
	@ResponseBody
	public ModelAndView sell_list_info(@RequestParam(required = false, defaultValue = "0") String pk_trade_no,
	                                   ModelAndView mav) {
	    Map<String, String> Info_sell = service.infoSell(pk_trade_no);
	    String pk_product_no = service.productNo(pk_trade_no); // 상품페이지 이동
	    Info_sell.put("pk_product_no", pk_product_no);
	    mav.addObject("Info_sell", Info_sell);
	    mav.setViewName("mypage/sell_info");
	    return mav;
	}

	// 구매내역
	@GetMapping("buy_list")
	public ModelAndView buyList(ModelAndView mav) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String fk_consumer_no = "fk_consumer_no";
		String search_sell = "";
		String search_date = "";
		List<Map<String, String>> buy_list = service.sellList(pk_member_no, fk_consumer_no, search_sell, search_date);
		mav.addObject("buy_list", buy_list);
		mav.setViewName("mypage/buyList");
		return mav;
	}
	
	// 검색어가 있는 경우
	@PostMapping("buy_search_list")
	@ResponseBody
	public List<Map<String, String>> buy_search_list (@RequestParam(defaultValue = "") String search_sell, @RequestParam(defaultValue = "") String search_date) {
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		String fk_consumer_no = "fk_consumer_no";
		List<Map<String, String>> buy_list = service.sellList(pk_member_no, fk_consumer_no, search_sell, search_date); // 로그인 한 회원의 판매확정된 판매내역들 가져오기
		return buy_list;
	}
	
	@PostMapping("buy_list_info")
	@ResponseBody
	public ModelAndView buy_list_info(@RequestParam(required = false, defaultValue = "0") String pk_trade_no,
	                                   ModelAndView mav) {
	    Map<String, String> Info_buy = service.infoSell(pk_trade_no);
	    String pk_product_no = service.productNo(pk_trade_no); // 상품페이지 이동
	    Info_buy.put("pk_product_no", pk_product_no);
	    mav.addObject("Info_buy", Info_buy);
	    mav.setViewName("mypage/buy_info");
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
		MemberVO member_vo = get_member_detail.MemberDetail();
		String pk_member_no = member_vo.getPk_member_no();
		mav.addObject("pk_member_no", pk_member_no);
		mav.setViewName("mypage/memberDelete");
		return mav;
	}
	
	// 탈퇴 신청시 탈퇴테이블에 insert
	@PostMapping("delete_submit")
	@ResponseBody
	public Map<String, Integer> delete_submit(@RequestBody LeaveVO lvo, HttpServletRequest request) {
		
		MemberVO member_vo = get_member_detail.MemberDetail();
		
		String fk_member_no = lvo.getFk_member_no();
	    String leave_reason = lvo.getLeave_reason();

	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("fk_member_no", fk_member_no);
	    paraMap.put("leave_reason", leave_reason);
		
		if(member_vo.getMember_oauth_type() != null) {
			
			HttpSession session = request.getSession();
			
			System.out.println("access_token -> "+session.getAttribute("access_token"));
			
			String ck = oauth2_service.unlinkOauthUser(String.valueOf(session.getAttribute("access_token")), member_vo.getMember_user_id());
			
		}
		
		int n = service.delete_submit(paraMap);

	    Map<String, Integer> response = new HashMap<>();
	    response.put("n", n);

	    return response;
	}

	// 계좌변경 리스트
	@GetMapping("mybank_list")
	public ModelAndView mybank_list(ModelAndView mav) {
		mav.setViewName("mypage/mybank_list");
		return mav;
	}
	
	// 계좌등록시 은행테이블 insert, 대표계좌 유무체크, 계좌테이블 등록
	@PostMapping("register_account")
	@ResponseBody
	public int registerAccount(@RequestParam String account_num, @RequestParam String bank_name, @RequestParam String account_type) {
	    System.out.println("bank_num: " + bank_name);  // 서버에서 확인
	    System.out.println("bank_num: " + account_num);  // 서버에서 확인
	    System.out.println("bank_num: " + account_type);  // 서버에서 확인
	    MemberVO member_vo = get_member_detail.MemberDetail();
	    String pk_member_no = member_vo.getPk_member_no();
	    int n = service.register_account(pk_member_no, account_num, bank_name, account_type);
	    System.out.println(n+"확인");
	    return n;
	}

	// 계좌 편집
	@GetMapping("edit_bank")
	public ModelAndView editBank(ModelAndView mav) {
		MemberVO member_vo = get_member_detail.MemberDetail();
	    String pk_member_no = member_vo.getPk_member_no();
	    String member_name = member_vo.getMember_name();
		List<Map<String, String>> bank_list = service.bankList(pk_member_no); // 회원의 게좌 리스트 조회
		mav.addObject("bank_list", bank_list);
		mav.addObject("member_name", member_name);
		mav.setViewName("mypage/edit_bank");
		return mav;
	}
	
	// 계좌 삭제
	@PostMapping("account_delete")
	@ResponseBody
	public int accountDelete(@RequestParam String account_no, @RequestParam String account_type) {
		int response = service.accountDelete(account_no, account_type);
		return response;
	}
	
	// 대표계좌 변경
	@PostMapping("account_type_update")
	@ResponseBody
	public int accountTypeUpdate(@RequestParam String account_no) {
		MemberVO member_vo = get_member_detail.MemberDetail();
	    String pk_member_no = member_vo.getPk_member_no();
		int response = service.accountTypeUpdate(account_no, pk_member_no);
		return response;
	}
	
	
}
