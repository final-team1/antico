package com.project.app.review.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 사용자 후기 VO
 */

@Getter
@Setter // TODO 추후에 setter 함수 제거 
public class ReviewVO {
	
	private String pk_review_no; // 후기 PK 일련번호
	
	private String fk_member_no; // 작성자 회원 일련번호
	
	private String fk_trade_no; // 거래 일련번호
	
	private String review_content; // 후기 내용
	
	private String review_regdate; // 후기 등록일자
	
	private String review_img_file_name; // 후기 사진 파일명
	
	private String review_img_org_name; // 후기 원본 사진명

}
