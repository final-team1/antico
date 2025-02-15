package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryDetailVO {
	
	private String pk_category_detail_no; 	// 카테고리하위번호
	private String fk_category_no;			// 카테고리상위번호
	private String category_detail_name;	// 카테고리명(하위)
	
}
