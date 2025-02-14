package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductImageVO {
	
	private String pk_prod_img_no;	      // 이미지번호
	private String fk_product_no;     	  // 상품번호
	private String prod_img_name;		  // 상품 이미지 파일명
	private String prod_img_org_name;     // 상품 이미지 원본명
	private String prdo_img_is_thumbnail; // 대표 사진 여부(0: 추가사진, 1: 대표사진)

}
