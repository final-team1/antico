package com.project.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
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

	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	@Override
	public List<Map<String, Object>> regionSearch(Map<String, String> paraMap) {
		List<Map<String, Object>> region_list = productMapper.regionSearch(paraMap);
		return region_list;
	}
	
	// 상품번호 채번해오기
	@Override
	public String getNo() {
		String c_product_no = productMapper.getNo();
		return c_product_no;
	}

	// 상품 테이블에 상품 정보 저장
	@Override
	public int addProduct(ProductVO productvo) {
		int n = productMapper.addProduct(productvo);
		return n;
	}	
	
	// 이미지 테이블에 파일 넣어주기
	@Override
	public int addImage(ProductImageVO product_imgvo) {
		int n = productMapper.addImage(product_imgvo);
		return n;
	}

	


}
