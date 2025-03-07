package com.project.app.auction.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.app.auction.model.AuctionDAO;
import com.project.app.common.FileType;
import com.project.app.component.GetMemberDetail;
import com.project.app.component.S3FileManager;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.model.ProductDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 경매 서비스 클래스
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuctionService_imple implements AuctionService {

	private final GetMemberDetail getMemberDetail;

	private final ProductDAO productDAO;

	private final AuctionDAO auctionDAO;

	private final S3FileManager s3FileManager;

	/*
	 * 경매 상품 추가
	 * 상품 추가 성공 시 상품 일련번호 반환
	 */
	@Override
	@Transactional
	public String addAuctionProduct(ProductVO productvo, ProductImageVO product_imgvo) {
		// 이미지 정보 가져오기
		List<MultipartFile> attach_list = product_imgvo.getAttach();

		// 로그인한 회원의 회원번호 값 가져오기
		String fk_member_no = getMemberDetail.MemberDetail().getPk_member_no();
		productvo.setFk_member_no(fk_member_no); // 회원 번호 값 담기

		// 상품번호 채번해오기
		String c_product_no = productDAO.getNo();
		productvo.setPk_product_no(c_product_no); // 채번 해온 값 담기

		// 상품 이미지 확인
		if (attach_list == null || attach_list.size() < 1) {
			throw new BusinessException(ExceptionCode.FILE_IS_EMPTY);
		}

		// 경매 상품 정보 등록
		int n1 = productDAO.addProduct(productvo);

		// 경매 상품 정보 등록 실패 시 예외 처리
		// mybatis xml에서 상품 판매 상태(일반판매/경매) 검사
		if (n1 < 1) {
			log.error("[ERROR] : 경매 상품 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}

		// org_file_name : 이미지 원본명
		// file_name : 이미지 저장명
		// 경매 상품 이미지 S3 저장
		List<Map<String, String>> fileList = s3FileManager.upload(attach_list, "product", FileType.IMAGE);

		// 경매 상품 이미지 정보 등록
		int n2 = productDAO.insertAuctionProductImage(fileList, c_product_no);

		// 경매 상품 이미지 정보 등록 실패 시 예외처리
		if (n2 < 1) {
			log.error("[ERROR] : 경매 상품 이미지 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}
		
		log.info(productvo.getAuction_start_date());

		// 경매 정보 등록
		int n3 = auctionDAO.insertAuction(c_product_no, productvo.getAuction_start_date());		
		
		if (n3 < 1) {
			log.error("[ERROR] : 경매 정보 등록 실패 ");
			throw new BusinessException(ExceptionCode.AUCTION_CREATE_FAILD);
		}
		
		return c_product_no;
	}

	/*
	 * 경매 시작 시간인 경매 상품 일련번호 목록 조회 및 판매 상태 수정
	 */
	@Override
	@Transactional
	public List<Map<String, String>> updateProductSaleStatusByAuctionStartDate() {
		// 경매 시작 시간인 경매 상품 일련번호 목록 조회
		List<Map<String, String>> productMapList = auctionDAO.selectProductNoListByAuctionStartDate();
		List<String> list = new ArrayList<>();
		
		// 경매 시작 시간인 경매 상품 판매 상태 수정
		if(!productMapList.isEmpty()) {
			for(Map<String, String> map : productMapList) {
				list.add(map.get("pk_product_no"));
			}
			auctionDAO.updateProductSaleStatus(list);	
		}

		return productMapList;
	}
}
