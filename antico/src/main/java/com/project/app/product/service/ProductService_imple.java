package com.project.app.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.model.ProductMapper;

@Service
public class ProductService_imple implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	
	
	// 상품등록 form 페이지에 상위 카테고리명 보여주기
	@Override
	public List<CategoryVO> getCategory() {
		List<CategoryVO> category_list = productMapper.getCategory();
		return category_list;
	}

	
	// 상품등록 form 페이지에 하위 카테고리명 보여주기
	@Override
	public List<CategoryDetailVO> getCategoryDetail() {
		 List<CategoryDetailVO> category_detail_list = productMapper.getCategoryDetail();
		return category_detail_list;
	}
	
}
