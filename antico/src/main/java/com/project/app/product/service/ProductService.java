package com.project.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

public interface ProductService {
	
	// 상품등록 form 페이지에 상위 카테고리명 보여주기
	List<CategoryVO> getCategory();
	
	// 상품등록 form 페이지에 하위 카테고리명 보여주기
	List<CategoryDetailVO> getCategoryDetail();
	
	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	List<Map<String, Object>> regionSearch(Map<String, String> paraMap);
	
	// 상품번호 채번해오기
	String getNo();
	
	// 상품 등록 완료 후 상품 테이블 및 이미지 테이블에 상품 정보 저장
	int addProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list);
	
	
}
