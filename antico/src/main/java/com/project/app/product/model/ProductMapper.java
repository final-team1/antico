package com.project.app.product.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;

@Mapper
public interface ProductMapper {
	
	// 상품등록 form 페이지에 상위 카테고리명 보여주기
	List<CategoryVO> getCategory();
	
	// 상품등록 form 페이지에 하위 카테고리명 보여주기
	List<CategoryDetailVO> getCategoryDetail();

}
