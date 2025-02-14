package com.project.app.product.service;

import java.util.List;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;

public interface ProductService {
	
	// 상품등록 form 페이지에 상위 카테고리명 보여주기
	List<CategoryVO> getCategory();
	
	// 상품등록 form 페이지에 하위 카테고리명 보여주기
	List<CategoryDetailVO> getCategoryDetail();

}
