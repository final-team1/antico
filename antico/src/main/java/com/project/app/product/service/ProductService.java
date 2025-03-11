package com.project.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.app.common.PagingDTO;
import com.project.app.chat.domain.ProductChatDTO;
import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;

public interface ProductService {
	
	
	// 상품 개수 가져오기 (검색어, 카테고리번호, 가격대, 지역, 정렬 포함)
	int getProductCnt(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type);
	
	// 상품 가격 정보 가져오기 (검색어, 카테고리번호, 가격대, 지역, 정렬 포함)
	Map<String, String> getProductPrice(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type);

	// 모든 상품에 대한 이미지,지역 정보 가져오기 (검색어, 카테고리번호, 지역, 가격대, 정렬, 페이징 포함)
	List<Map<String, String>> getProduct(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type, PagingDTO paging_dto);
	
	// 특정 상품에 대한 상품 및 대표이미지 정보 가져오기
	Map<String, String> getProductInfo(String pk_product_no);
	
	// 상위 카테고리 정보 가져오기
	List<CategoryVO> getCategory();
	
	// 하위 카테고리 정보 가져오기
	List<CategoryDetailVO> getCategoryDetail();
	
	// 좋아요 정보 가져오기
	List<Map<String, String>> getWish();
	
	// 지역 정보 가져오기
	List<Map<String, String>> getRegion();
	
	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	List<Map<String, Object>> regionSearch(Map<String, String> paraMap);
	
	// 상품 등록 관련 부분
	String getNo(); // 상품번호 채번해오기
	int addProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list); // 상품 등록 완료 후 상품 테이블 및 이미지 테이블에 상품 정보 저장
	
	// 상품 목록 지역 선택창에서 현재 위치 클릭하여 근처 동네 5개 알아오기
	List<Map<String, Object>> nearRegion(String current_lat, String current_lng);
<<<<<<< HEAD
	
	// 관심상품에 상품 추가하기
	int wishInsert(String fk_product_no, String fk_member_no);
	
	// 특정 회원에 대한 다른 상품 정보 가져오기
	List<Map<String, String>> getProdcutOneMember(String fk_member_no2, String pk_product_no);
	
	// 특정 상품에 대한 이미지 정보 가져오기
	List<ProductImageVO> getProductImg(String pk_product_no);
	
	// 특정 상품에 대한 정보 가져오기(지역, 회원, 카테고리, 경매)
	Map<String, String> getProductDetail(String pk_product_no);
	
	// "위로올리기" 클릭 시 상품 등록일자 업데이트 하기
	int regDateUpdate(String pk_product_no);
	
	// "상태변경" 클릭 시 상품 상태 업데이트 하기
	int saleStatusUpdate(String pk_product_no, String sale_status_no);
	
	// 상품 수정하기
	int updateProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list);
	
	// "상품삭제" 클릭 시 상품 삭제하기
	int delete(String pk_product_no);
	
	
	
	// 모든 상품 조회 해오기(이미지, 지역)
	List<Map<String, String>> getProductList(String sort_views_week);
	
	// 상품 요약 정보 목록 조회
	List<ProductChatDTO> getProdcutSummaryList(List<String> pk_product_no_list);
	
=======
	
	// 관심상품에 상품 추가하기
	int wishInsert(String fk_product_no, String fk_member_no);
	
	// 특정 회원에 대한 다른 상품 정보 가져오기
	List<Map<String, String>> getProdcutOneMember(String fk_member_no2, String pk_product_no);
	
	// 특정 상품에 대한 이미지 정보 가져오기
	List<ProductImageVO> getProductImg(String pk_product_no);
	
	// 특정 상품에 대한 정보 가져오기(지역, 회원, 카테고리, 경매)
	Map<String, String> getProductDetail(String pk_product_no);
	
	// "위로올리기" 클릭 시 상품 등록일자 업데이트 하기
	int regDateUpdate(String pk_product_no);
	
	// "상태변경" 클릭 시 상품 상태 업데이트 하기
	int saleStatusUpdate(String pk_product_no, String sale_status_no);
	
	// 상품 수정하기
	int updateProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list);
	
	// "상품삭제" 클릭 시 상품 삭제하기
	int delete(String pk_product_no);
	
	// 검색어에 맞는 시세 조회
	List<Map<String, String>> getMargetPrice(String search_price);
	
	
	// 모든 상품 조회 해오기(이미지, 지역)
	List<Map<String, String>> getProductList(String sort_views_week);
	
	// 상품 요약 정보 목록 조회
	List<ProductChatDTO> getProdcutSummaryList(List<String> pk_product_no_list);
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)

	// 경매 상품 등록
	int addAuctionProduct(ProductVO productvo);

<<<<<<< HEAD
	

	
	

	
=======
	// 경매 이미지 상품 등록
	int insertAuctionProductImage(List<Map<String, String>> fileList, String cProductNo);
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
}
