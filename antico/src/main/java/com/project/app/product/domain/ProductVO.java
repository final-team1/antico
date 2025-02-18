package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVO {
	
	private String pk_product_no; 			// 상품번호
	private String fk_member_no;  			// 회원번호
	private String fk_region_no;   			// 지역번호
	private String fk_category_no;   		// 상위카테고리번호
	private String fk_category_detail_no;  	// 하위카테고리번호
	private String product_title;  			// 상품제목
	private String product_contents; 		// 상품내용
	private String product_price;    		// 상품가격
	private String product_status;	  		// 상품상태 (0: 중고, 1: 새상품)
	private String product_sale_status; 	// 판매상태 (0: 판매중, 1: 예약중, 2: 구매확정, 3: 경매시작전, 4: 경매중, 5: 경매완료)
	private String product_regdate;  		// 상품등록일
	private String product_update_date;   	// 상품수정일
	private String product_sale_type;  		// 판매유형 (0: 일반, 1: 경매)
	private String product_views;    		// 조회수
	
}
