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
import com.project.app.product.model.ProductMapper;

@Service
public class ProductService_imple implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	

	@Autowired
	private S3FileManager s3fileManager;
		
	
	// 특정 상품에 대한 상품 및 대표이미지 정보 가져오기
	@Override
	public Map<String, String> getProductInfo(String pk_product_no) {
		Map<String, String> product_info = productMapper.getProductInfo(pk_product_no);
		return product_info;
	}


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
	
	
	// 상품 등록 완료 후 상품 테이블 및 이미지 테이블에 상품 정보 저장
	@Override
	@Transactional(value = "transactionManager_mymvc_user", propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class })
	public int addProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list) {
				
		int n = 0, result = 0; // result 값
		
		// #1. 상품 테이블에 상품 저장
		n = productMapper.addProduct(productvo); 
		
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
						product_imgvo.setProd_img_name(fileList.get(i).get("org_file_name")); // 저장된 파일명
						product_imgvo.setProd_img_org_name(fileList.get(i).get("file_name")); // 원본 파일명
						
						// 첫 번째 이미지는 대표사진, 나머지는 일반사진 
						product_imgvo.setProd_img_is_thumbnail(index ==0 ? "1" : "0");
						
						// 이미지VO에 상품번호를 추가하여 저장 
						product_imgvo.setFk_product_no(productvo.getPk_product_no());
						// System.out.println(productvo.getPk_product_no());	
						
						// #2. 이미지 테이블에 이미지 정보 저장
						result = productMapper.addImage(product_imgvo);
		
						index++; // 첫 번째 이미지 이후는 일반 사진으로 설정
					}	
				} // end of for (MultipartFile attach : attach_list)		
			
			} // end of if (attach_list != null && attach_list.size() > 0)
		
		} // end of if (n > 0 ) { // 상품 저장이 성공한 경우면
		
	    return result;
	}

	
}
