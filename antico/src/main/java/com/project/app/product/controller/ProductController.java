package com.project.app.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.app.product.domain.CategoryVO;
import com.project.app.product.domain.ProductImageVO;
import com.project.app.product.domain.ProductVO;
import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.service.ProductService;
import com.project.app.common.FileManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


/*
 * 상품 컨트롤러
 */
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	ProductService service;
	
	// 파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) === 
	@Autowired
	private FileManager fileManager; 
	
	
	// 상품등록 form 페이지 요청 
	@GetMapping("add")
	public ModelAndView add(HttpServletRequest request, ModelAndView mav) {
		

		// 상품등록 form 페이지에 상위 카테고리명 보여주기
		List<CategoryVO> category_list = service.getCategory();
		
		// 상품등록 form 페이지에 하위 카테고리명 보여주기
		List<CategoryDetailVO> category_detail_list = service.getCategoryDetail();
		
		mav.addObject("category_list", category_list);
		mav.addObject("category_detail_list", category_detail_list);
		
		mav.setViewName("product/add");

		return mav;
	}
	
	
	// 상품등록 완료 요청
	@PostMapping("add")
	@Transactional(value="transactionManager_mymvc_user", propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public ModelAndView add(Map<String, String> paraMap, ModelAndView mav
			              , ProductVO productvo, ProductImageVO product_imgvo, MultipartHttpServletRequest mrequest) {
		
		/*
	    form 태그의 name 명과  ProductVO 의 필드명이 같다라면 
	    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	    자동적으로 ProductVO productvo 에 set 되어진다.
		*/
		
		// 상품번호 채번해오기
		String c_product_no = service.getNo();
		
		productvo.setPk_product_no(c_product_no); // 채번 해온 값 담기
		
		// 상품 테이블에 상품 정보 저장
		int n = service.addProduct(productvo);
		
		
		if(n > 0) { // 상품 테이블에 저장이 성공한 경우
			// 첨부파일 작업 시작
			List<MultipartFile> attachList = product_imgvo.getAttach(); 
			
			// System.out.println("파일 사이즈: " + attachList.size());
		
		    if (attachList != null && !attachList.isEmpty()) {
		    	
		    	int index = 0; // 이미지 순서를 나타내는 변수
		    	
		        for (MultipartFile attach : attachList) {
		        	
		            if (!attach.isEmpty()) {
		            	
		                // System.out.println("파일 이름: " + attach.getOriginalFilename());
		                // System.out.println("파일 크기: " + attach.getSize());
		                
		        		// 1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.	
		        		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		        		HttpSession session = mrequest.getSession();
		        		String root = session.getServletContext().getRealPath("/");
		        		
		        		String path =  root+"resources"+File.separator+"productImages";
		        		//String path = root + "WEB-INF" + File.separator + "classes" + File.separator + "static" + File.separator + "images" + File.separator + "product";
		        		/* 
		        		   File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		        	       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		        	       운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		        	    */
		        		
		        		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
		        		String newFileName = "";
		        		// WAS(톰캣)의 디스크에 저장될 파일명
		        		
		        		byte[] bytes = null;
		        		// 첨부파일의 내용물을 담는 것

		        		try {

		        			// 첨부파일의 내용물을 읽어오는 것
		        			bytes = attach.getBytes();
		        			
		        			// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다. 
		        			String originalFilename = attach.getOriginalFilename();
		        							
		        			// 첨부되어진 파일을 업로드 하는 것이다.
		        			newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
		        			
		                    //fileName 값과 orgFilename 값을 넣어주기
		                    
		                    product_imgvo.setProd_img_name(newFileName);  				// 저장된 파일명
		                    // EX) WAS(톰캣)에 저장된 파일명(2025020709291535243254235235234.png)
		                    
		                    product_imgvo.setProd_img_org_name(originalFilename);  		// 원본 파일명
		        			// 페이지에서 첨부된 파일(EX) 강아지.png)을 보여줄 때 사용.
		        			// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
		                    
		                    // 첫 번째 이미지는 대표사진, 나머지는 일반사진
		                    product_imgvo.setProd_img_is_thumbnail(index == 0 ? "1" : "0");
		                            
		        			// 이미지VO에 상품번호를 추가하여 저장
		        	        product_imgvo.setFk_product_no(c_product_no);
		        	
	
		        			// 이미지 테이블에 파일 넣어주기
		        			service.addImage(product_imgvo);
		                    
		                    index++; // 첫 번째 이미지 이후는 일반 사진으로 설정
		        	                    
		        		} catch (Exception e) {
		        			e.printStackTrace();
		        		}
	  
		            } // end of if (!attach.isEmpty())
		            
		        } // end of for (MultipartFile attach : attachList)
		        
		    } // end of if (attachList != null && !attachList.isEmpty())
		    
		    mav.setViewName("product/add_success");
		    
		} // end of if(n > 0) 
	    
		return mav;
	}
	

	// 지역 추가 버튼 클릭 시 사이드바 지역 검색창 요청
	@GetMapping("regionlist")
	public ModelAndView region(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("product/regionlist");
		return mav;
		
	}
	
	
	// 지역 검색창에서 지역 검색 시 자동글 완성하기 및 정보 가져오기
	@GetMapping("region_search")
	@ResponseBody
	public List<Map<String, String>> region_search(@RequestParam Map<String, String> paraMap) {
	    
	    List<Map<String, Object>> region_list = service.regionSearch(paraMap); 
	    
	    List<Map<String, String>> map_list = new ArrayList<>();
	    
	    if(region_list != null) {
	        for(Map<String, Object> region : region_list) {
	            Map<String, String> map = new HashMap<>();
	            map.put("word", region.get("full_address").toString());  		// full_address 값을 word로 저장
	            map.put("region_town", region.get("region_town").toString());	// 읍면동 
	            map.put("fk_region_no", region.get("pk_region_no").toString()); // 지역번호
	            map.put("region_lat", region.get("region_lat").toString());     // 위도 값
	            map.put("region_lng", region.get("region_lng").toString());     // 경도 값
	            map_list.add(map);
	        }
	    }

	    return map_list;
	}
	

} // end of public class ProductController
