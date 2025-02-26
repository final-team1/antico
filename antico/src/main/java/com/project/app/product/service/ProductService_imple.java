package com.project.app.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.common.FileType;
import com.project.app.component.S3FileManager;
import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.model.ProductDAO;

@Service
public class ProductService_imple implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private S3FileManager s3fileManager;
		

	// 상품 개수 가져오기 (검색어, 카테고리번호, 가격대, 정렬 포함)
	@Override
	public int getProductCnt(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String sort_type) {
		int product_list_cnt = productDAO.getProductCnt(search_prod, category_no, category_detail_no, min_price, max_price, sort_type);
		return product_list_cnt;
	}
		
	
	// 상품 가격 정보 가져오기 (검색어, 카테고리번호, 가격대, 정렬 포함)
	@Override
	public Map<String, String> getProductPrice(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String sort_type) {
		Map<String, String> prodcut_price_info = productDAO.getProductPrice(search_prod, category_no, category_detail_no, min_price, max_price, sort_type);
		return prodcut_price_info;
	}



	// 모든 상품에 대한 이미지,지역 정보 가져오기 (검색어, 카테고리번호, 가격대, 정렬 포함)
	@Override
	public List<Map<String, String>> getProduct(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String sort_type) {
		List<Map<String, String>> product_list = productDAO.getProduct(search_prod, category_no, category_detail_no, min_price, max_price, sort_type);
		return product_list;
	}
	
	
	// 특정 상품에 대한 상품 및 대표이미지 정보 가져오기
	@Override
	public Map<String, String> getProductInfo(String pk_product_no) {
		Map<String, String> product_info = productDAO.getProductInfo(pk_product_no);
		return product_info;
	}


	// 상위 카테고리 정보 가져오기
	@Override
	public List<CategoryVO> getCategory() {
		List<CategoryVO> category_list = productDAO.getCategory();
		return category_list;
	}

	
	// 하위 카테고리 정보 가져오기
	@Override
	public List<CategoryDetailVO> getCategoryDetail() {
		 List<CategoryDetailVO> category_detail_list = productDAO.getCategoryDetail();
		return category_detail_list;
	}
	
	
	// 좋아요 정보 가져오기
	@Override
	public List<Map<String, String>> getWish() {
		List<Map<String, String>> wish_list = productDAO.getWish();
		return wish_list;
	}
	
	
	// 지역 정보 가져오기
	@Override
	public List<Map<String, String>> getRegion() {
		List<Map<String, String>> region_list = productDAO.getRegion();
		return region_list;
	}
	

	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	@Override
	public List<Map<String, Object>> regionSearch(Map<String, String> paraMap) {
		List<Map<String, Object>> region_list = productDAO.regionSearch(paraMap);
		return region_list;
	}
	
	// 상품번호 채번해오기
	@Override
	public String getNo() {
		String c_product_no = productDAO.getNo();
		return c_product_no;
	}
	
	
	// 상품 등록 완료 후 상품 테이블 및 이미지 테이블에 상품 정보 저장
	@Override
	@Transactional(value = "transactionManager_mymvc_user", propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class })
	public int addProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list) {
				
		int n = 0, result = 0; // result 값
		
		// #1. 상품 테이블에 상품 저장
		n = productDAO.addProduct(productvo); 
		
		if (n > 0 ) { // 상품 저장이 성공한 경우면
		
			if (attach_list != null && attach_list.size() > 0) { // 이미지 리스트가 있는 경우라면
				int index = 0; // 이미지 순서를 나타내는 변수
				
				for (int i=0; i < attach_list.size(); i++) {	
					if (!attach_list.get(i).isEmpty()) { // 이미지 리스트에 파일이 존재하는 경우라면
						
						// S3에 첨부파일 업로드 하기
						List<Map<String, String>> fileList = s3fileManager.upload(attach_list, "product", FileType.IMAGE);
						// System.out.println(fileList.get(i).get("org_file_name")); // 첨부파일 원본 파일명 가져오기
						// System.out.println(fileList.get(i).get("file_name")); 	 // 첨부파일 업로드되는 파일명 가져오기
						
						// 이미지 VO에 값 넣어주기
						product_imgvo.setProd_img_name(fileList.get(i).get("file_name")); 		  // 저장된 파일명
						product_imgvo.setProd_img_org_name(fileList.get(i).get("org_file_name")); // 원본 파일명
						
						// 첫 번째 이미지는 대표사진, 나머지는 일반사진 
						product_imgvo.setProd_img_is_thumbnail(index ==0 ? "1" : "0");
						
						// 이미지VO에 상품번호를 추가하여 저장 
						product_imgvo.setFk_product_no(productvo.getPk_product_no());
						// System.out.println(productvo.getPk_product_no());	
						
						// #2. 이미지 테이블에 이미지 정보 저장
						result = productDAO.addImage(product_imgvo);
		
						index++; // 첫 번째 이미지 이후는 일반 사진으로 설정
					}	
				} // end of for (MultipartFile attach : attach_list)		
			
			} // end of if (attach_list != null && attach_list.size() > 0)
		
		} // end of if (n > 0 ) { // 상품 저장이 성공한 경우면
		
	    return result;
	}

	
	// 관심상품에 상품 추가하기
	@Override
	public int wishInsert(String fk_product_no, String fk_member_no) {
		
		int result = 0;
		
		// #1. 관심상품에 이미 상품이 존재하는지 확인하기
		Map<String, String> wish_check_list = productDAO.getWishCheck(fk_product_no, fk_member_no);
		
		if(wish_check_list != null) { // 관심상품에 이미 상품이 존재한다면
			// #2. 관심 상품에서 상품 삭제하기
			result = productDAO.wishDelete(fk_product_no, fk_member_no);
		}
		else { // 관심 상품에 상품이 없다면
			// #3. 관심 상품에 상품 추가하기
			result = productDAO.wishInsert(fk_product_no, fk_member_no);

		}
		
		return result;	
	}
	
	
	// 특정 상품에 대한 이미지 정보 가져오기
	@Override
	public List<ProductImageVO> getProductImg(String pk_product_no) {
		List<ProductImageVO> product_img_list = productDAO.getProductImg(pk_product_no);
		return product_img_list;
	}

	
	
	// 특정 삼품에 대한 정보 가져오기(지역, 회원, 카테고리)
	@Override
	public Map<String, String> getProductDetail(String pk_product_no) {

		Map<String, String> product_map = productDAO.getProductDetail(pk_product_no);
		
		return product_map;
	}

	
	/*
	 * 상품 요약 정보 목록 조회
	 */
	@Override
	public List<Map<String, String>> getProdcutSummaryList(List<String> pk_product_no_list) {
		return productDAO.selectProductSummaryList(pk_product_no_list);
	}
	
	


}
