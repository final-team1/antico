package com.project.app.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.review.domain.BlacklistVO;
import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;
import com.project.app.review.model.ReviewDAO;

@Service
public class ReviewService_imple implements ReviewService {
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	/*
	 * 후기 조회
	 */
	@Override
	@Transactional(readOnly=true)
	public ReviewVO getReview(String pk_trade_no) {
		// TODO security context에서 회원정보 가져오기
		String pk_member_no = "3";
		
		// TODO 추후 거래내역 service에서 가져오는 방식으로 변경
		// 거래내역이 존재하지 않는다면 예외 발생
		reviewDAO.selectTrade(pk_trade_no)
				.orElseThrow(() -> new BusinessException(ExceptionCode.TRADE_NOT_FOUND));
		
		return reviewDAO.selectReview(pk_member_no, pk_trade_no);
	}
	
	/*
	 * 후기 설문 문항 정보 조회 
	 */
	@Override
	@Transactional(readOnly=true)
	public List<SurveyVO> getSurveyMapList() {
		return reviewDAO.selectSurveyList();
	}

	/*
	 * 사용자 후기 등록
	 * map keys
	 * 	arr_pk_survey_resp_no : 사용자가 선택한 설문문항 테이블 일련번호 문자열
	 * 	pk_trade_no : 거래 일련번호
	 * 	review_content : 후기 내역
	 */
	@Override
	@Transactional
	public int registerReview(Map<String, String> para_map) {
		int n1, n2 = 0; // 결과값을 저장할 정수
		
		// TODO security context 에서 로그인 사용자 정보 가져오기
		String pk_member_no = "3"; // 후기 작성자 회원 일련번호

		// 후기 삽입 전 PK로 저장할 seq 일련번호 조회
		String pk_review_no = reviewDAO.selectPkReviewNo(); 
		
		// TODO 이미지 저장하기
		para_map.put("pk_member_no", pk_member_no);
		para_map.put("pk_review_no", pk_review_no);

		// 후기 테이블 삽입
		n1 = reviewDAO.insertReview(para_map);
		
		String[] arr_pk_survey_resp_no = para_map.get("arr_pk_survey_resp_no").split(","); 
		
		// 사용자 선택 설문 문항 삽입
		n2 = reviewDAO.insertSurveyResp(arr_pk_survey_resp_no, pk_review_no);
		
		return n1 * n2;
	}

	/*
	 * 상대 회원 블랙리스트 추가
	 */
	@Override
	public int addBlacklist(String pk_target_member_no) {
		// TODO security context 에서 로그인 사용자 정보 가져오기
		String pk_member_no = "3"; // 후기 작성자 회원 일련번호
		
		// 이미 블랙리스트에 추가된 경우 예외 발생
		BlacklistVO blacklistVO = reviewDAO.selectBlacklist(pk_member_no, pk_target_member_no);
		
		if(blacklistVO != null) {
			throw new BusinessException(ExceptionCode.BLACKLIST_AREADY_EXISTS);
		}
		
		return reviewDAO.insertBlackList(pk_member_no, pk_target_member_no);
	}

}
