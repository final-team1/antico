package com.project.app.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.service.ProductService;
import com.project.app.component.GetMemberDetail;

/*
 * 상품 컨트롤러
 */
@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	ProductService service;

	@Autowired
	private GetMemberDetail get_member_detail;

	// 상품등록 form 페이지 요청
	@GetMapping("add")
	public ModelAndView add(ModelAndView mav) {

		// 상품등록 form 페이지에 상위 카테고리명 보여주기
		List<CategoryVO> category_list = service.getCategory();

		// 상품등록 form 페이지에 하위 카테고리명 보여주기
		List<CategoryDetailVO> category_detail_list = service.getCategoryDetail();

		mav.addObject("category_list", category_list);
		mav.addObject("category_detail_list", category_detail_list);

		mav.setViewName("product/add");

		return mav;
	}

	// 상품 등록 완료 요청
	@PostMapping("add")
	public ModelAndView add(Map<String, String> paraMap, ModelAndView mav, ProductVO productvo
						  , ProductImageVO product_imgvo, MultipartHttpServletRequest mrequest) {
	      	
		  // 로그인한 회원의 회원번호 값 가져오기
		  String fk_member_no = get_member_detail.MemberDetail().getPk_member_no();
		  productvo.setFk_member_no(fk_member_no); // 회원 번호 값 담기
		  // System.out.println("확인용 fk_member_no : " + fk_member_no);
		  	  
		  // 상품번호 채번해오기
		  String c_product_no = service.getNo();
	      productvo.setPk_product_no(c_product_no); // 채번 해온 값 담기
		  // System.out.println(productvo.getFk_member_no());
		
	      // 이미지 정보 가져오기 
	      List<MultipartFile> attach_list = product_imgvo.getAttach();
	      
	      // 상품 등록 완료 후 상품 테이블 및 이미지 테이블에 상품 정보 저장
	      int n = service.addProduct(productvo, product_imgvo, attach_list);

	      if (n > 0) { // 저장이 성공한 경우 성공 페이지로 이동한다.
	         mav.setViewName("product/add_success");

	      } // end of if(n > 0)
	      
	      return mav;
	      	      
	}
			
	// 지역 추가 버튼 클릭 시 사이드바 지역 검색창 요청
	@GetMapping("regionlist")
	public ModelAndView region(ModelAndView mav) {

		mav.setViewName("product/regionlist");
		return mav;

	}

	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	@GetMapping("region_search")
	@ResponseBody
	public List<Map<String, String>> region_search(@RequestParam Map<String, String> paraMap) {

		List<Map<String, Object>> region_list = service.regionSearch(paraMap);

		List<Map<String, String>> map_list = new ArrayList<>();

		if (region_list != null) {
			for (Map<String, Object> region : region_list) {
				Map<String, String> map = new HashMap<>();
				map.put("word", region.get("full_address").toString()); // full_address 값을 word로 저장
				map.put("region_town", region.get("region_town").toString()); // 읍면동
				map.put("fk_region_no", region.get("pk_region_no").toString()); // 지역번호
				map.put("region_lat", region.get("region_lat").toString()); // 위도 값
				map.put("region_lng", region.get("region_lng").toString()); // 경도 값
				map_list.add(map);
			}
		}
		return map_list;
	}

	// 상품 목록 조회해오기
	@GetMapping("prodlist")
	public ModelAndView prodlist(ModelAndView mav) {

		mav.setViewName("product/prodlist");
		return mav;

	}

} // end of public class ProductController
