package com.project.app.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

import javax.naming.directory.NoSuchAttributeException;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;
import com.project.app.review.domain.TradeVO;
import com.project.app.review.service.ReviewService;

import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;

/*
 * 판매자/구매자 리뷰 컨트롤러
 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/review/*")
public class ReviewController {	
	
	private final ReviewService reviewService;
	
	/*
	 * 사용자 후기 메인 페이지 조회
	 */
	@GetMapping("/")
	@ResponseBody
	public ModelAndView getReviewMainPage(@RequestParam String pk_member_no, ModelAndView mav) {
		
		// 회원 일련번호 숫자 유효성 검사
//		if(!NumberUtils.isCreatable(memNo)) {
//		}
		
		mav.setViewName("review/main");

		return mav;
	}
	
	/*
	 * 사용자 전체 후기 페이지 조회
	 */
	@GetMapping("all_reviews")
	@ResponseBody
	public ModelAndView getReviewListPage(@RequestParam String pk_member_no, ModelAndView mav) {
		
		// TODO AOP 커스텀 어노테이션 사용 예정
		// 회원 일련번호 숫자 유효성 검사
		if(!NumberUtils.isCreatable(pk_member_no)) {
			throw new IllegalArgumentException();
		}
		
		mav.setViewName("review/all_reviews");
		return mav;
	}
	
	/*
	 * 사용자 후기 등록 페이지 조회
	 */
	@GetMapping("register")
	@ResponseBody
	public ModelAndView getReviewRegisterPage(@RequestParam String pk_trade_no, ModelAndView mav) {
		
		// TODO 페이지를 띄울 경우 상품정보, 회원정보, 거래정보가 존재하는 상황 확인
		// 작성자가 로그인 유저임과 동시에 거래내역이 존재하며, 후기를 작성한 상태가 아니여야한다.
		// 거래내역이 동일하고 작성자가 로그인 유저인 후기 내역이 존재하면 BACK 시킨다.

		ReviewVO reviewVO = reviewService.getReview(pk_trade_no);
		
		// 동일한 거래에서 작성된 후기가 존재하면 예외 발생
		if(reviewVO != null) {
			throw new BusinessException(ExceptionCode.REVIEW_AREADY_EXISTS);
		}

		// 후기 설문문항 목록 조회
		List<SurveyVO> survey_vo_list = reviewService.getSurveyMapList();
		mav.addObject("survey_vo_list", survey_vo_list);
		mav.setViewName("review/register");
		return mav;
	}
	
	/*
	 * 사용자 블랙리스트 추가
	 * pk_target_member_no : 차단 대상 사용자 일련번호
	 */
	@PostMapping("add_blacklist")
	@ResponseBody
	public Map<String, Integer> addBlacklist(@RequestParam String pk_target_member_no) {
		int blacklist_success = 0;  

		blacklist_success = reviewService.addBlacklist(pk_target_member_no);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("blacklist_success", blacklist_success);
		
		return map;
	}
	
	/*
	 * 사용자 후기 등록
	 * map keys
	 * 	arr_pk_survey_resp_no : 사용자가 선택한 설문문항 테이블 일련번호 문자열
	 * 	pk_trade_no : 거래 일련번호
	 * 	review_content : 후기 내역
	 */
	@PostMapping("register")
	@ResponseBody
	public Map<String, Integer> registerReivew(@RequestParam Map<String, String> para_map) {
		int review_success = 0;

		// TODO 이미지 추가
		
		String str_pk_survey_resp_no =  para_map.get("arr_pk_survey_resp_no");

		// 사용자 선택 설문문항 테이블 일련번호 문자열이 유효할 경우 삽입 처리
		if(StringUtils.isNotBlank(str_pk_survey_resp_no)) {
			// 후기 등록
			review_success = reviewService.registerReview(para_map); 
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("review_success", review_success);		
		
		return map;
	}

}
