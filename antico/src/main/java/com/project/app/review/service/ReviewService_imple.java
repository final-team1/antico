package com.project.app.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.common.FileType;
import com.project.app.common.PagingDTO;
import com.project.app.component.S3FileManager;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.review.domain.BlacklistVO;
import com.project.app.review.domain.ReviewVO;
import com.project.app.review.domain.SurveyVO;
import com.project.app.review.model.ReviewDAO;
import com.project.app.trade.domain.TradeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService_imple implements ReviewService {
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	// aws s3 api
	private final S3FileManager s3FileManager;
	
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
	  	arr_pk_survey_resp_no : 사용자가 선택한 설문문항 테이블 일련번호 문자열
	  	pk_trade_no : 거래 일련번호
	  	review_content : 후기 내역
		review_img_org_name : 첨부이미지 원본 파일명 
		review_img_file_name : 첨부이미지 파일명(URL 경로) 
	 */
	@Override
	@Transactional
	public int registerReview(Map<String, String> para_map, MultipartFile file) {
		int n1, n2 = 0; // 결과값을 저장할 정수
		
		// TODO security context 에서 로그인 사용자 정보 가져오기
		String pk_member_no = "4"; // 후기 작성자 회원 일련번호
		
		// 동일한 거래에서 사용자가 작성힌 후기가 존재하면 예외 발생
		ReviewVO reviewVO = reviewDAO.selectReview(pk_member_no, para_map.get("pk_trade_no"));
		
		if(reviewVO != null) {
			throw new BusinessException(ExceptionCode.REVIEW_AREADY_EXISTS);
		}
		
		// 실제로 거래가 진행됬는지 및 후기 작성자가 구매자인지 확인
		TradeVO tradeVO = reviewDAO.selectTrade(para_map.get("pk_trade_no"))
				.orElseThrow(() -> new BusinessException(ExceptionCode.TRADE_NOT_FOUND));
		
		if(!tradeVO.getFk_consumer_no().equals(pk_member_no)) {
			throw new BusinessException(ExceptionCode.NOT_CONSUMER_MEMBER);
		}
		
		// 첨부 이미지가 존재한다면 S3에 업로드 처리 후 url인 filename 및 original file name를 DB에 저장
		if(!file.isEmpty()) {
			// 2번째 파라미터는 S3 버켓에서 review(후기) 관련 이미지들만 관리하기 위해 추가한 디렉토리 경로
			// 3번째 파라미터는 저장하는 파일 형식이 image로 확장자 지정을 위한 ENUM
			Map<String, String> file_map = s3FileManager.upload(file, "review", FileType.IMAGE);
			
			para_map.put("review_img_org_name", file_map.get("org_file_name"));
			para_map.put("review_img_file_name", file_map.get("file_name"));	
		}

		// 후기 삽입 전 PK로 저장할 seq 일련번호 조회
		String pk_review_no = reviewDAO.selectPkReviewNo(); 
		
		para_map.put("pk_member_no", pk_member_no);
		para_map.put("pk_review_no", pk_review_no);

		// 후기 테이블 삽입
		n1 = reviewDAO.insertReview(para_map);
		
		String[] arr_pk_survey_resp_no = para_map.get("str_pk_survey_resp_no").split(","); 
		
		// 사용자 선택 설문 문항 삽입
		n2 = reviewDAO.insertSurveyResp(arr_pk_survey_resp_no, pk_review_no);
		
		return n1 * n2;
	}

	/*
	 * 상대 회원 블랙리스트 추가
	 */
	@Override
	@Transactional
	public int addBlacklist(String pk_target_member_no) {
		// TODO security context 에서 로그인 사용자 정보 가져오기
		String pk_member_no = "4"; // 후기 작성자 회원 일련번호
		
		// 이미 블랙리스트에 추가된 경우 예외 발생
		BlacklistVO blacklistVO = reviewDAO.selectBlacklist(pk_member_no, pk_target_member_no);
		
		if(blacklistVO != null) {
			throw new BusinessException(ExceptionCode.BLACKLIST_AREADY_EXISTS);
		}
		
		// 사용자 블랙리스트에 저장
		return reviewDAO.insertBlackList(pk_member_no, pk_target_member_no);
	}

	/*
	 * 리뷰 통계 조회(긍정적 리뷰, 부정적 리뷰, 리뷰 당 받은 개수)
	 * keys
	 * 	pk_survey_no : 설문 문항 일련번호
	 * 	survey_content : 설문 문항
	 *  count : 개수
	 */
	@Override
	@Transactional(readOnly=true)
	public List<Map<String, String>> getConsumerSurveyStatList(String pk_member_no) {
		return reviewDAO.selectConsumerSurveyStatList(pk_member_no);
	}
	
	/*
	 * 사용자가 받은 구매 후기 전체 개수
	 */
	@Override
	@Transactional(readOnly=true)
	public int getConsumerTotalReviewCount(String pk_member_no) {
		return reviewDAO.selectConsumerTotalReviewCount(pk_member_no);
	}

	/*
	 * 최근 받은 구매 후기 목록 조회
	 */
	@Override
	@Transactional(readOnly=true)
	public List<Map<String, String>> getConsumerReviewList(PagingDTO paging_dto, String pk_member_no) {
		return reviewDAO.selectConsumerReviewList(paging_dto, pk_member_no);
	}

	/*
	 * 후기 상세 내역 조회
	 */
	@Override
	public Map<String, String> getConsumeReviewDetails(String pk_review_no) {		
		return reviewDAO.selectConsumerReviewDetails(pk_review_no)
				.orElseThrow(() -> new BusinessException(ExceptionCode.REVIEW_NOT_FOUND));
	}

	/*
	 * 후기에 따른 설문 문항 선택 내역 조회
	 */
	@Override
	public List<SurveyVO> getSurveyRespList(String pk_review_no) {	
		return reviewDAO.selectSurveyRespList(pk_review_no);
	}

}
