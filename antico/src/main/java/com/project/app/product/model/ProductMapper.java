package com.project.app.product.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

@Mapper
public interface ProductMapper {
	
	
	// 상품 테이블 및 이미지 테이블로 상품 정보 가져오기
	List<Map<String, String>> getProductInfo();
	
	// 상품등록 form 페이지에 상위 카테고리명 보여주기
	List<CategoryVO> getCategory();
	
	// 상품등록 form 페이지에 하위 카테고리명 보여주기
	List<CategoryDetailVO> getCategoryDetail();
	
	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	List<Map<String, Object>> regionSearch(Map<String, String> paraMap);
	
	// 상품 등록 관련 부분 //
	String getNo(); // 상품번호 채번해오기
	int addProduct(ProductVO productvo); // 상품 테이블에 상품 정보 저장
	int addImage(ProductImageVO product_imgvo); // 이미지 테이블에 파일 넣어주기


}
