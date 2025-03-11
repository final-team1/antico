package com.project.app.review.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.common.PagingDTO;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.product.service.ProductService;
import com.project.app.review.domain.SurveyVO;
import com.project.app.review.service.ReviewService;
import com.project.app.trade.domain.TradeVO;
import com.project.app.trade.service.TradeService;

import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 판매자/구매자 리뷰 컨트롤러
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/review/*")
public class ReviewController {	
	
	private final ReviewService reviewService;

	private final TradeService tradeService;
	private final ProductService productService;

	/*
	 * 사용자 후기 메인 페이지 조회
	 * 비 로그인 사용자도 접근 가능
	 */
	@GetMapping("/")
	@ResponseBody
	public ModelAndView getReviewMainPage(@RequestParam String pk_member_no, ModelAndView mav) {
		
		// 판매자 구매 후기 통계 조회(긍정적 리뷰, 부정적 리뷰, 리뷰 당 받은 개수)
		// keys
		//    pk_survey_no : 설문 문항 일련번호
		//    survey_content : 설문 문항
		//    count : 개수
		List<Map<String, String>> survey_stat_list = reviewService.getConsumerSurveyStatList(pk_member_no);
	
		// 사용자가 받은 총 리뷰 개수
		int review_count = reviewService.getConsumerTotalReviewCount(pk_member_no);
		
		// 5개의 행만 가져오도록 설정
		PagingDTO paging_dto = PagingDTO.builder()
				.cur_page(1)
				.row_size_per_page(5)
				.page_size(5)
				.total_row_count(review_count)
				.build();
		
		
		// 페이징 정보 계산
		paging_dto.pageSetting();
		
		// 최근 받은 리뷰 목록 가져오기
		List<Map<String, String>> review_map_list = reviewService.getConsumerReviewList(paging_dto, pk_member_no);

		mav.addObject("seller_no", pk_member_no);
		mav.addObject("survey_stat_list", survey_stat_list);
		mav.addObject("review_count", review_count);
		mav.addObject("review_map_list", review_map_list);
		
		mav.setViewName("review/main");
		return mav;
	}
	
	/*
	 * 사용자 전체 후기 페이지 조회
	 * 비 로그인 사용자도 접근 가능
	 */
	@GetMapping("all_reviews")
	@ResponseBody
	public ModelAndView getReviewListPage(@RequestParam String pk_member_no, ModelAndView mav) {
		int review_count = reviewService.getConsumerTotalReviewCount(pk_member_no); // 판매자가 받은 총 리뷰 개수
		mav.addObject("review_count", review_count);
		mav.addObject("pk_member_no", pk_member_no);
		mav.setViewName("review/all_reviews");
		return mav;
	}
	
	/*
	 * 사용자 전체 후기 페이지 조회
	 * 비 로그인 사용자도 접근 가능
	 */
	@GetMapping("reviews/{pk_member_no}/{cur_page}")
	@ResponseBody
	public List<Map<String, String>> getReviewList(@PathVariable String pk_member_no, @PathVariable String cur_page) {
		int current_page = 1;
		
		if(NumberUtils.isDigits(cur_page)) {
			current_page = Integer.parseInt(cur_page);
		}
		
		// 판매자가 받은 총 리뷰 개수
		int review_count = reviewService.getConsumerTotalReviewCount(pk_member_no);
		
		List<Map<String, String>> review_map_list = new ArrayList<>();
		
		if((current_page - 1) * 5 < review_count) {
			PagingDTO paging_dto = PagingDTO.builder()
					.cur_page(current_page)
					.total_row_count(review_count)
					.row_size_per_page(5)
					.page_size(5)
					.build();
			
			// 페이징 정보 계산
			paging_dto.pageSetting();
			
			// 판매자가 최근 받은 리뷰 목록 가져오기
			review_map_list = reviewService.getConsumerReviewList(paging_dto, pk_member_no);
		}
		
		return review_map_list;
	}
	
	/*
	 * 사용자 후기 등록 페이지 조회
	 */
	@GetMapping("register")
	@ResponseBody
	public ModelAndView getReviewRegisterPage(@RequestParam String pk_product_no, ModelAndView mav) {
		// 이미 후기를 작성하였는지 확인
		int n = reviewService.getCountReview(pk_product_no);
		if(n != 0) {
			throw new BusinessException(ExceptionCode.REVIEW_AREADY_EXISTS);
		}

		List<SurveyVO> survey_vo_list = reviewService.getSurveyMapList(); // 후기 설문문항 목록 조회
		Map<String, String> product_map = productService.getProductInfo(pk_product_no); // 거래상품 조회
		TradeVO trade_vo = tradeService.getTradeByProductNo(pk_product_no); // 거래내역 조회

		mav.addObject("product_map", product_map);
		mav.addObject("trade_vo", trade_vo);
		mav.addObject("survey_vo_list", survey_vo_list);
		mav.setViewName("review/register");
		return mav;
	}
	
	/*
	 * 사용자 후기 등록
	 */
	@PostMapping("register")
	@ResponseBody
	public Map<String, Integer> registerReivew(MultipartHttpServletRequest request) {
		int review_success = 0; // 리뷰 작성 성공/실패 여부를 반환하기 위한 정수 1 : 성공, 0 : 실패

		String str_pk_survey_resp_no =  request.getParameter("arr_pk_survey_resp_no"); 	// 사용자가 선택한 설문문항 테이블 일련번호 문자열
		String pk_trade_no = request.getParameter("pk_trade_no");					   	// 거래 일련번호
		String review_content = request.getParameter("review_content");				   	// 후기 내역			// 후기 타입 0 : 구매후기, 1 : 판매 홍보 후기

		String feedback_type = request.getParameter("feedback_type"); // 피드백 선택 타입 (최고에요, 좋아요, 아쉬워요)
		
		Map<String, String> para_map = new HashMap<>();
		
		para_map.put("str_pk_survey_resp_no", str_pk_survey_resp_no);
		para_map.put("pk_trade_no", pk_trade_no);
		para_map.put("review_content", review_content);
		
		// 첨부 이미지가 없는 후기도 작성 가능하기에 빈 값으로 초기화
		para_map.put("review_img_org_name", ""); 
		para_map.put("review_img_file_name", "");
		
		// 사용자 선택 설문문항 테이블 일련번호 문자열이 유효할 경우 삽입 처리
		if(StringUtils.isNotBlank(str_pk_survey_resp_no)) {
			
			MultipartFile file = request.getFile("file");

			// 후기 등록
			// 등록 성공이면 1을 저장
			review_success = reviewService.registerReview(para_map, file); 
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("review_success", review_success);		
		
		return map;
	}
	
	/*
	 * 사용자 블랙리스트 추가
	 * pk_target_member_no : 차단 대상 사용자 일련번호
	 */
	@PostMapping("add_blacklist")
	@ResponseBody
	public Map<String, Integer> addBlacklist(@RequestParam String pk_target_member_no) {
		int blacklist_success = 0;  // 블랙리스트 등록 성공/실패 여부를 반환하기 정수 1 : 성공, 0 : 실패
		blacklist_success = reviewService.addBlacklist(pk_target_member_no);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("blacklist_success", blacklist_success);
		
		return map;
	}
	
	/*
	 * 사용자 후기 상세 조회 (후기 내역, 설문 응답 내역)
	 * review_map keys
	 *  pk_review_no : 후기 일련번호
	 *  fk_consumer_no : 구매자 일련번호
	 *  consumer_name : 구매자 명
	 *  fk_seller_no : 판매자 일련번호
	 * 	seller_name : 판매자 명
	 *  pk_trade_no : 거래내역 일련번호
	 *  review_content : 후기 내용
	 *  review_regdate : 후기 등록일자
	 *  review_img_file_name : 후기 이미지 파일 명
	 *  review_img_org_name : 후기 이미지 파일 원본명
	 *  product_title : 거래 상품명
	 */
	@GetMapping("details/{pk_review_no}")
	@ResponseBody
	public Map<String, Object> getReviewDetails(@PathVariable String pk_review_no){		
		// 후기 상세 내역
		Map<String, String> review_map = reviewService.getConsumeReviewDetails(pk_review_no);
		
		// 후기 설문 문항 선택 내역
		List<SurveyVO> survey_list = reviewService.getSurveyRespList(pk_review_no);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("review_map", review_map);
		map.put("survey_list", survey_list);
		
		return map;
	}

	/*
	 * 사용자 받은 후기 상세 조회 (후기 내역, 설문 응답 내역)
	 * review_map keys
	 *  pk_review_no : 후기 일련번호
	 *  fk_consumer_no : 구매자 일련번호
	 *  consumer_name : 구매자 명
	 *  fk_seller_no : 판매자 일련번호
	 * 	seller_name : 판매자 명
	 *  pk_trade_no : 거래내역 일련번호
	 *  review_content : 후기 내용
	 *  review_regdate : 후기 등록일자
	 *  review_img_file_name : 후기 이미지 파일 명
	 *  review_img_org_name : 후기 이미지 파일 원본명
	 *  product_title : 거래 상품명
	 */
	@GetMapping("seller/details")
	@ResponseBody
	public Map<String, Object> getSellerReviewDetailsByTradeNo(@RequestParam String pk_trade_no){

		// 후기 상세 내역
		Map<String, String> review_map = reviewService.getSellerReviewDetailsByTradeNo(pk_trade_no);

		// 후기 설문 문항 선택 내역
		List<SurveyVO> survey_list = reviewService.getSurveyRespList(review_map.get("pk_review_no"));

		Map<String, Object> map = new HashMap<>();

		map.put("review_map", review_map);
		map.put("survey_list", survey_list);

		return map;
	}
}
