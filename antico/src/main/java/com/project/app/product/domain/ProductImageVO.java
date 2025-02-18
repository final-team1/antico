package com.project.app.product.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductImageVO {
	
	private String pk_prod_img_no;	      // 이미지번호
	private String fk_product_no;     	  // 상품번호
	private String prod_img_name;		  // 상품 이미지 파일명
	private String prod_img_org_name;     // 상품 이미지 원본명
	private String prod_img_is_thumbnail; // 대표 사진 여부(0: 추가사진, 1: 대표사진)
	
	
	List<MultipartFile> attach;
	
	
	/*
	    form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	    진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
        조심할것은 MultipartFile attach 는 오라클 데이터베이스 테이블의 컬럼이 아니다.
        jsp 파일에서 input type="file" 인 name 의 이름(attach) 과 
        동일해야만 파일첨부가 가능해진다.!!!!           
	 */
	
	
	
	

}
