package com.project.app.product.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

@Mapper
public interface ProductDAO {
	
	
	// 상품 개수 가져오기 (검색어, 카테고리번호 포함)
	int getProductCnt(String search_prod, String pk_category_no, String pk_category_detail_no);
	
	// 상품 가격 정보 가져오기 (검색어, 카테고리번호 포함)
	Map<String, String> getProductPrice(String search_prod, String pk_category_no, String pk_category_detail_no);
			
	// 모든 상품 및 이미지 정보 가져오기 (검색어, 카테고리번호 포함)
	List<Map<String, String>> getProduct(String search_prod, String pk_category_no, String pk_category_detail_no);
	
	// 특정 상품에 대한 상품 및 대표이미지 정보 가져오기
	Map<String, String> getProductInfo(String pk_product_no);
	
	// 상위 카테고리 정보 가져오기
	List<CategoryVO> getCategory();
	
	// 하위 카테고리 정보 가져오기
	List<CategoryDetailVO> getCategoryDetail();
	
	// 지역 정보 가져오기
	List<Map<String, String>> getRegion();
	
	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	List<Map<String, Object>> regionSearch(Map<String, String> paraMap);
	
	// 상품 등록 관련 부분
	String getNo(); // 상품번호 채번해오기
	int addProduct(ProductVO productvo); // 상품 테이블에 상품 정보 저장
	int addImage(ProductImageVO product_imgvo); // 이미지 테이블에 파일 넣어주기

	// 상품 요약 정보 목록 조회
	List<Map<String, String>> selectProductSummaryList(List<String> pk_product_no_list);

	
}
