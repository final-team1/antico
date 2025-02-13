package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductImageVO {
	
	private String pk_pi_no;	  // 이미지번호
	private String fk_prod_no;    // 상품번호
	private String pi_name;		  // 상품 이미지 파일명
	private String pi_org_name;   // 상품 이미지 원본명
	private String pi_is_tumnail; // 대표 사진 여부(0: 추가사진, 1: 대표사진)

}
