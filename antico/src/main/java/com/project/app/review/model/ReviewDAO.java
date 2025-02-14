package com.project.app.review.model;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.review.domain.BlacklistVO;
import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;
import com.project.app.review.domain.TradeVO;

@Mapper
public interface ReviewDAO {

	// 거래 일련번호를 통한 후기 조회
	ReviewVO selectReview(String pk_member_no, String pk_trade_no);
	
	// 거래 일련번호를 통해 거래 내역 유무 조회 TODO 추후에 거래 관련 DAO로 이동
	Optional<TradeVO> selectTrade(String pk_trade_no);
	
	// 후기 설문 문항 정보 조회
	List<SurveyVO> selectSurveyList();

	// 후기 삽입 전 시퀀스 값 조회
	String selectPkReviewNo();
	
	// 후기 저장
	int insertReview(Map<String, String> map);

	// 후기 설문조사 저장
	int insertSurveyResp(String[] arr_pk_survey_resp_no, String pk_review_no);

	// 상대 회원을 블랙리스트에 추가
	int insertBlackList(String pk_member_no, String pk_target_member_no);

	// 블랙리스트 조회
	BlacklistVO selectBlacklist(String pk_member_no, String pk_target_member_no);

}
