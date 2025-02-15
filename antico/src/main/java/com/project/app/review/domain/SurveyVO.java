package com.project.app.review.domain;

import lombok.*;

/*
 * 후기 설문 문항 VO
 */

@Getter
@Setter
public class SurveyVO {

	private String pk_survey_no; // 설문 문항 일련번호
	
	private String survey_content; // 설문 문항 내역

}
