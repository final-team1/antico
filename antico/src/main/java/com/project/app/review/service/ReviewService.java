package com.project.app.review.service;

import java.util.List;
import java.util.Map;

import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;

public interface ReviewService {

	// 사용자 후기 조회
	ReviewVO getReview(String pk_trade_no);
	
	// 후기 설문 문항 정보 조회
	List<SurveyVO> getSurveyMapList();

	// 사용자 후기 등록
	int registerReview(Map<String, String> para_map);
	
	// 블랙리스트 추가
	int addBlacklist(String pk_target_member_no);

}
