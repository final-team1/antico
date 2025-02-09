package com.project.app.review.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

/*
 * 사용자 후기 VO
 */

@Getter
@Setter // TODO 추후에 setter 함수 제거 
@Builder
public class ReviewVO {
	
	private String pkRevNo; // 후기 PK 일련번호
	
	private String fkWrtNo; // 작성자 회원 일련번호
	
	private String fkRcvNo; // 작성대상 회원 일련번호
	
	private String fkTraNo; // 거래 일련번호
	
	private String prodName; // 거래 상품명
	
	private String revContent; // 후기 내역
	
	private String revRegdate; // 후기 작성 일자
	
	private String revImgFileName; // 후기 사진 파일명
	
	private String revImgOrgName; // 후기 원본 사진명

}
