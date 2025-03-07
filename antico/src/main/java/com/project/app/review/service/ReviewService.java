package com.project.app.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.app.common.PagingDTO;
import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;

public interface ReviewService {
	
	// 후기 설문 문항 정보 조회
	List<SurveyVO> getSurveyMapList();

	// 사용자 후기 등록
	int registerReview(Map<String, String> para_map, MultipartFile file);
	
	// 블랙리스트 추가
	int addBlacklist(String pk_target_member_no);
	
	// 판매자 구매 후기 통계 조회(긍정적 리뷰, 부정적 리뷰, 리뷰 당 받은 개수)
	List<Map<String, String>> getConsumerSurveyStatList(String pk_member_no);
	
	// 판매자가 받은 후기 전체 개수
	int getConsumerTotalReviewCount(String pk_member_no);

	// 최근 받은 구매 후기 목록 가져오기
	List<Map<String, String>> getConsumerReviewList(PagingDTO paging_dto, String pk_member_no);

	// 후기 상세 내역 조회
	Map<String, String> getConsumeReviewDetails(String pk_review_no);

	// 후기 설문 문항 선택 내역 조회
	List<SurveyVO> getSurveyRespList(String pk_review_no);

	// 후기가 이미 존재하는지 조회
	int getCountReview(String pk_review_no);

}
