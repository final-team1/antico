package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVO {
	
	private String pk_prod_no; 			// 상품번호
	private String fk_mem_no;  			// 회원번호
	private String fk_rg_no;   			// 지역번호
	private String fk_ct_no;   			// 상위카테고리번호
	private String fk_ctd_no;  			// 하위카테고리번호
	private String prod_name;  			// 상품명
	private String prod_contents; 		// 상품내용
	private String prod_price;    		// 상품가격
	private String prod_status;	  		// 상품상태 (0: 중고, 1: 새상품)
	private String prod_sale_status; 	// 판매상태 (0: 판매중, 1: 예약중, 2: 구매확정, 3: 경매시작전, 4: 경매중, 5: 경매완료)
	private String prod_regdate;  		// 상품등록일
	private String prod_update;   		// 상품수정일
	private String prod_sale_type;  	// 판매유형 (0: 일반, 1: 경매)
	private String prod_views;    		// 조회수
	
}
