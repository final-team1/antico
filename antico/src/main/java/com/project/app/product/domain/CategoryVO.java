package com.project.app.product.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryVO {
	private String pk_category_no;	// 카테고리상위번호
	private String category_name;	// 카테고리명(상위)
}
