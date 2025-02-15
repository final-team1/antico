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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.common.FileType;
import com.project.app.component.S3FileManager;
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
	
	private final S3FileManager s3FileManager;
	
	/*
	 * 사용자 후기 메인 페이지 조회
	 */
	@GetMapping("/")
	@ResponseBody
	public ModelAndView getReviewMainPage(@RequestParam String pk_member_no, ModelAndView mav) {
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
		List<SurveyVO> survey_vo_list = reviewService.getSurveyMapList(); // 후기 설문문항 목록 조회
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
		String review_content = request.getParameter("review_content");				   	// 후기 내역
		
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
	
			// 첨부 이미지가 존재한다면 S3에 업로드 처리 후 url인 filename 및 original file name를 DB에 저장
			if(!file.isEmpty()) {
				// 2번째 파라미터는 S3 버켓에서 review(후기) 관련 이미지들만 관리하기 위해 추가한 디렉토리 경로
				// 3번째 파라미터는 저장하는 파일 형식이 image로 확장자 지정을 위한 ENUM
				Map<String, String> file_map = s3FileManager.upload(file, "review", FileType.IMAGE);
				
				para_map.put("review_img_org_name", file_map.get("org_file_name"));
				para_map.put("review_img_file_name", file_map.get("file_name"));	
			}
	
			// 후기 등록
			// 등록 성공이면 1을 저장
			review_success = reviewService.registerReview(para_map); 
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
}
