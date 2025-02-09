package com.project.app.review.controller;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.review.service.ReviewService;

/*
 * 판매자/구매자 리뷰 컨트롤러
 */
@Controller
@RequestMapping("/review/*")
public class ReviewController {	
	
	// private final ReviewService reviewService;
	
	/*
	 * 사용자 후기 메인 페이지 조회
	 */
	@PostMapping("/")
	@ResponseBody
	public ModelAndView getReviewMainPage(String memNo, ModelAndView mav) {
		
		// TODO AOP 커스텀 어노테이션 사용 예정
		// 회원 일련번호 숫자 유효성 검사
		if(!NumberUtils.isCreatable(memNo)) {
			throw new IllegalArgumentException("잘못된 회원 번호 입니다.");
		}
		
//		Map<String, String> paraMap = new HashMap<>();
//		paraMap.put("memNo", memNo);
//		paraMap.put("amount", "5");
//		
//		List<ReviewVO> reviewList = reviewService.getReviewList(paraMap); // 받은 후기 중 최근 5개 조회
//		Map<String, Integer> receivedSurveyMap = reviewService.getReceivedSurveyMap(memNo); // 긍정적인 후기 설문 조사 현황 조회 
		
		mav.setViewName("review/main");
//		mav.addObject("reviewList", reviewList);
//		mav.addObject("likeSurveyMap", likeSurveyMap);
		
		return mav;
	}
	
	/*
	 * 사용자 전체 후기 페이지 조회
	 */
	@PostMapping("/all_reviews")
	@ResponseBody
	public ModelAndView getReviewListPage(String memNo, ModelAndView mav) {
		
		// TODO AOP 커스텀 어노테이션 사용 예정
		// 회원 일련번호 숫자 유효성 검사
		if(!NumberUtils.isCreatable(memNo)) {
			throw new IllegalArgumentException();
		}
		
//		Map<String, String> paraMap = new HashMap<>();
//		paraMap.put("memNo", memNo);
//		paraMap.put("amount", "5");
//		
//		List<ReviewVO> reviewList = reviewService.getReviewList(paraMap); // 받은 후기 중 최근 5개 조회
//		Map<String, Integer> receivedSurveyMap = reviewService.getReceivedSurveyMap(memNo); // 긍정적인 후기 설문 조사 현황 조회 
		
		mav.setViewName("review/all_reviews");
//		mav.addObject("reviewList", reviewList);
//		mav.addObject("likeSurveyMap", likeSurveyMap);
		
		return mav;
	}
	
	

}
