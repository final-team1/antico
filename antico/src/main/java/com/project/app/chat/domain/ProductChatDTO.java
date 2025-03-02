package com.project.app.chat.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ProductChatDTO {

	private String pk_product_no; // 상품번호

	private String seller_no; // 판매자 일련번호

	private String seller_name; // 판매자 명

	private String fk_region_no; // 지역번호

	private String product_title; // 상품제목

	private String product_price; // 상품가격

	private String product_sale_status; // 판매상태 (0: 판매중, 1: 예약중, 2: 구매확정, 3: 경매시작전, 4: 경매중, 5: 경매완료)

	private String product_sale_type; // 판매유형 (0: 일반, 1: 경매)

	private String prod_img_name; // 대표 이미지 파일명

}
