package com.project.app.product.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.chat.domain.ProductChatDTO;
import com.project.app.common.FileType;
import com.project.app.common.PagingDTO;
import com.project.app.component.GetMemberDetail;
import com.project.app.component.ProductSaleStatusEventListener;
import com.project.app.component.ProductStatusChangedEvent;
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
	
	@Autowired
	private GetMemberDetail get_member_detail;
	
	@Autowired
	private ApplicationEventPublisher eventPublisher;
	
	@Autowired
	private ProductSaleStatusEventListener productSaleStatusEventListener;
		

	// 상품 개수 가져오기 (검색어, 카테고리번호, 가격대, 지역, 정렬 포함)
	@Override
	public int getProductCnt(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type) {
		int product_list_cnt = productDAO.getProductCnt(search_prod, category_no, category_detail_no, min_price, max_price, region, town, sort_type, sale_type);
		return product_list_cnt;
	}
		
	
	// 상품 가격 정보 가져오기 (검색어, 카테고리번호, 가격대, 지역, 정렬 포함)
	@Override
	public Map<String, String> getProductPrice(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type) {
		Map<String, String> prodcut_price_info = productDAO.getProductPrice(search_prod, category_no, category_detail_no, min_price, max_price, region, town, sort_type, sale_type);
		return prodcut_price_info;
	}



	// 모든 상품에 대한 이미지,지역 정보 가져오기 (검색어, 카테고리번호, 가격대, 지역, 정렬, 페이징 포함)
	@Override
	public List<Map<String, String>> getProduct(String search_prod, String category_no, String category_detail_no, String min_price, String max_price, String region, String town, String sort_type, String sale_type, PagingDTO paging_dto) {
		List<Map<String, String>> product_list = productDAO.getProduct(search_prod, category_no, category_detail_no, min_price, max_price, region, town, sort_type, sale_type, paging_dto);
		return product_list;
	}
	
	
	// 상품 목록 지역 선택창에서 현재 위치 클릭하여 근처 동네 5개 알아오기
	@Override
	public List<Map<String, Object>> nearRegion(String current_lat, String current_lng) {
		List<Map<String, Object>> near_region_list = productDAO.nearRegion(current_lat, current_lng);
		return near_region_list;
	}
	
	
	// 특정 회원에 대한 다른 상품 정보 가져오기
	@Override
	public List<Map<String, String>> getProdcutOneMember(String fk_member_no2, String pk_product_no) {
		List<Map<String, String>> product_list_one_member = productDAO.getProdcutOneMember(fk_member_no2, pk_product_no);
		return product_list_one_member;
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
		
		// System.out.println(attach_list.size());
		
		if (n > 0 ) { // 상품 저장이 성공한 경우면
		
			if (attach_list != null && attach_list.size() > 0) { // 이미지 리스트가 있는 경우라면
				int index = 0; // 이미지 순서를 나타내는 변수
				
				// #2. S3에 첨부파일 업로드 하기
				List<Map<String, String>> fileList = s3fileManager.upload(attach_list, "product", FileType.IMAGE);
			
				// System.out.println(fileList.size());
				
				for (int i=0; i < fileList.size(); i++) {	
					if (!fileList.get(i).isEmpty()) { // 이미지 리스트에 파일이 존재하는 경우라면
						
						// System.out.println(fileList.get(i).get("org_file_name")); // 첨부파일 원본 파일명 가져오기
						// System.out.println(fileList.get(i).get("file_name")); 	 // 첨부파일 업로드되는 파일명 가져오기
						
						// 이미지 VO에 값 넣어주기
						product_imgvo.setProd_img_name(fileList.get(i).get("file_name")); 		  // 저장된 파일명
						product_imgvo.setProd_img_org_name(fileList.get(i).get("org_file_name")); // 원본 파일명
						
						// 첫 번째 이미지는 대표사진, 나머지는 일반사진 
						product_imgvo.setProd_img_is_thumbnail(index == 0 ? "1" : "0");
						
						// 이미지VO에 상품번호를 추가하여 저장 
						product_imgvo.setFk_product_no(productvo.getPk_product_no());
						// System.out.println(productvo.getPk_product_no());	
						
						// #3. 이미지 테이블에 이미지 정보 저장
						result = productDAO.addImage(product_imgvo);
		
						index++; // 첫 번째 이미지 이후는 일반 사진으로 설정
					}	
				} // end of for (MultipartFile attach : attach_list)		

			} // end of if (attach_list != null && attach_list.size() > 0)
		
		} // end of if (n > 0 ) { // 상품 저장이 성공한 경우면
		else {
			System.out.println("상품 저장에 실패하였습니다.");
		}
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

	
	
	// 특정 상품에 대한 정보 가져오기(지역, 회원, 카테고리, 경매)
	@Override
	public Map<String, String> getProductDetail(String pk_product_no) {

		// #1. 특정 상품에 대한 정보 조회해오기
		Map<String, String> product_map = productDAO.getProductDetail(pk_product_no);
		
		
		String login_member_no = get_member_detail.MemberDetail().getPk_member_no(); // 로그인 한 유저번호 가져오기
		
		// 상품 조회수 증가는 로그인을 한 상태에서 다른 사람의 상품을 볼때만 증가하도록 한다.
		if(login_member_no != null && !product_map.isEmpty() && !login_member_no.equals(product_map.get("fk_member_no"))) {
			
			// #2. 상품 조회수 증가하기 (DB)
			int n = productDAO.increaseViewCount(pk_product_no);
			
		
			if(n == 1) { // #3. 특정 상품 실제 정보에 업데이트 해주기 
				 product_map.put("product_views", String.valueOf(Integer.parseInt(product_map.get("product_views")) +1 )); 
			}
		};
		
		return product_map;
	}

	
	
	// "위로올리기" 클릭 시 상품 등록일자 업데이트 하기
	@Override
	public int regDateUpdate(String pk_product_no) {
		int result = productDAO.regDateUpdate(pk_product_no);
		return result;
	}
	
	
	// "상태변경" 클릭 시 상품 상태 업데이트 하기
	@Override
	@Transactional
	public int saleStatusUpdate(String pk_product_no, String sale_status_no) {
		int result = productDAO.saleStatusUpdate(pk_product_no, sale_status_no);
		
		eventPublisher.publishEvent(new ProductStatusChangedEvent(pk_product_no, sale_status_no));
		
		return result;
	}
	
	
	
	// 상품 수정하기
	@Override
	@Transactional(value = "transactionManager_mymvc_user", propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class })
	public int updateProduct(ProductVO productvo, ProductImageVO product_imgvo, List<MultipartFile> attach_list) {
		/*
			1. 상품 내용 먼저 업데이트
			2. 기존이미지 테이블 삭제
			3. 기존이미지 서버삭제
			4. 새로 업로드된 이미지 서버 등록 
			5. 새로 업로드된 이미지 테이블 등록
		*/	
		
		int n = 0, n2 = 0; // 결과값
		// #1. 상품 테이블 수정 내용 업데이트
		n = productDAO.updateProduct(productvo);
		
		if(n == 1) { // 상품 테이블 수정이 성공했다면
		
			// 삭제 버튼을 클릭한 기존 이미지 이름 알아와서 삭제하기
			if(!product_imgvo.getProd_img_name().isEmpty()) { // update 페이지에서 삭제 버튼(X)을 클릭한 기존 이미지가 있다면
				List<String> prod_img_name_list = Arrays.asList(product_imgvo.getProd_img_name().split(","));
				
				for(int i=0; i < prod_img_name_list.size(); i++) {
					// System.out.println("prod_img_name " + prod_img_name_list.get(i));
					
					// #2. 삭제 버튼을 클릭한 기존 이미지 테이블에서 지우기
					n2 = productDAO.deleteOriginImg(prod_img_name_list.get(i));
					
					if (n2 == 1) { // 테이블에서 삭제를 성공 했다면
						// #3. S3 서버에서 기존 이미지를 지우기
						s3fileManager.deleteImageFromS3(prod_img_name_list.get(i));				
					}
					else {
						System.out.println("이미지 테이블에서 삭제를 실패하였습니다.");
					}
				}
			} // end of if(!product_imgvo.getProd_img_name().isEmpty()
			
			
			// 기존 이미지 중 썸네일 설정
			if (n2 == 1) { // 기존 이미지 삭제 후
			    List<ProductImageVO> product_img_list = productDAO.getProductImg(productvo.getPk_product_no());

			    if (!product_img_list.isEmpty()) {
			        // 첫 번째 이미지에 썸네일을 설정
			        ProductImageVO first_image_vo = product_img_list.get(0);
			        first_image_vo.setProd_img_is_thumbnail("1");
			        productDAO.updateThumbnail(first_image_vo); // 썸네일 업데이트
			    }
			}
			
			
			// input 파일 첨부 안해도 빈 파일 하나 넘어오는거 정리하기
			List<MultipartFile> filtered_AttachList = new ArrayList<>();
			for (MultipartFile file : attach_list) {
			    if (file != null && !file.isEmpty() && !file.getOriginalFilename().isEmpty()) {
			    	filtered_AttachList.add(file); // 유효한 파일만 필터링
			    }
			}
			
			// 새로 업로드된 이미지 서버 및 테이블에 저장하기
			if (filtered_AttachList != null && filtered_AttachList.size() > 0) { // 새로 업로드된 이미지가 있다면
				
				int index = 0; // 새로 업로드된 이미지 순서를 나타내는 변수
				
				// #4. S3에 첨부파일 업로드 하기
				List<Map<String, String>> fileList = s3fileManager.upload(filtered_AttachList, "product", FileType.IMAGE);
				
				for (int i=0; i < fileList.size(); i++) {
					
					ProductImageVO new_product_imgvo = new ProductImageVO();
					
					// 이미지 VO에 값 넣어주기
					new_product_imgvo.setProd_img_name(fileList.get(i).get("file_name")); 		  // 저장된 파일명
					new_product_imgvo.setProd_img_org_name(fileList.get(i).get("org_file_name")); // 원본 파일명
					
					
					// 기존 이미지 가져오기 
					List<ProductImageVO> product_img_list = productDAO.getProductImg(productvo.getPk_product_no());
					
					// System.out.println("product_img_list size: " + product_img_list.size());
					
					// 첫 번째 이미지는 대표사진, 나머지는 일반사진 
					if (product_img_list.isEmpty()) { // 기존 이미지가 비어있다면
						new_product_imgvo.setProd_img_is_thumbnail(index == 0 ? "1" : "0");
					}
					else { // 기존 이미지가 있다면
						new_product_imgvo.setProd_img_is_thumbnail("0");
					}
					
					// 이미지VO에 상품번호를 추가하여 저장 
					new_product_imgvo.setFk_product_no(productvo.getPk_product_no());
					// System.out.println(productvo.getPk_product_no());	
					
					// #5. 이미지 테이블에 이미지 정보 저장
					n2 = productDAO.addImage(new_product_imgvo);
	
					index++; // 첫 번째 이미지 이후는 일반 사진으로 설정
					
				}
			} // end of if (attach_list != null && attach_list.size() > 0)
			
		} 
		else {
			System.out.println("상품 수정이 실패하였습니다.");
		}
		
		return n2;
	}

	
	// "상품삭제" 클릭 시 상품 삭제하기
	@Override
	public int delete(String pk_product_no) {

		// 해당 상품에 대한 이미지 정보 가져오기
		List<ProductImageVO> product_img_list = productDAO.getProductImg(pk_product_no);
		
		for (int i=0; i < product_img_list.size(); i++) {
			String file_name = product_img_list.get(i).getProd_img_name(); // 이미지 S3 업로드명 가져오기
			
			// System.out.println("file_name : " + file_name);
			
			// #1. S3에서 이미지 삭제하기
			s3fileManager.deleteImageFromS3(file_name);
		}
		// #2. 해당 상품 삭제하기 (외래키 설정으로 이미지 테이블 같이 삭제됨)
		int result = productDAO.delete(pk_product_no);
		
		return result;
	}

	
	
<<<<<<< HEAD
=======
	// 검색어에 맞는 시세 조회
	@Override
	public List<Map<String, String>> getMargetPrice(String search_price) {
		List<Map<String, String>> marketPrice = productDAO.getMargetPrice(search_price);
		return marketPrice;
	}

	
	
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
	//모든 상품 조회 해오기(이미지, 지역)
	@Override
	public List<Map<String, String>> getProductList(String sort_views_week) {
		List<Map<String, String>> product_list_reg_date = productDAO.getProductList(sort_views_week);
		return product_list_reg_date;
	}
	
		
	
	/*
	 * 상품 요약 정보 목록 조회
	 */
	@Override
	public List<ProductChatDTO> getProdcutSummaryList(List<String> pk_product_no_list) {
		return productDAO.selectProductSummaryList(pk_product_no_list);
	}
<<<<<<< HEAD
=======

	/*
	 * 경매 상품 등록
	 */
	@Override
	@Transactional
	public int addAuctionProduct(ProductVO productvo) {
		return productDAO.addProduct(productvo);
	}

	/*
	 * 경매 상품 이미지 등록
	 */
	@Override
	public int insertAuctionProductImage(List<Map<String, String>> fileList, String cProductNo) {
		return productDAO.insertAuctionProductImage(fileList, cProductNo);
	}
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)


}
