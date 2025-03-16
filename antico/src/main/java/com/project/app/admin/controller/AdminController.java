package com.project.app.admin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.admin.domain.CalendarVO;
import com.project.app.admin.service.AdminService;
import com.project.app.common.FileManager;
import com.project.app.common.MyUtil;
import com.project.app.common.PagingDTO;
import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.notice.domain.NoticeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private AdminService service;
	
	@Autowired
	private GetMemberDetail getMemberDetail;
	
	@Autowired
	private MemberVO member_vo;
	
	@Autowired
	private FileManager fileManager;
	
	// 관리자 페이지
	@GetMapping("admin_page")
	public ModelAndView inquireadd(ModelAndView mav) {		
		mav.setViewName("admin/admin_page");
		return mav;
	}
	
	// 공지사항 작성폼
	@GetMapping("admin_notice_write")
	public ModelAndView notice_write(ModelAndView mav) {		
		mav.setViewName("admin/admin_notice_write");
		return mav;
	}
	
	// 공지사항 삭제폼
	@GetMapping("admin_notice_delete")
	public ModelAndView notice_delete(ModelAndView mav, @RequestParam(defaultValue = "1") int cur_page) {		
		
		List<NoticeVO> notice_list = null;

	    // 공지사항 총 개수
	    int notice_count = service.getNoticeCount();
	    
	    PagingDTO paging_dto = PagingDTO.builder()
	            .cur_page(cur_page)
	            .row_size_per_page(5)  
	            .page_size(5)  
	            .total_row_count(notice_count)
	            .build();

	    // 페이징 정보 계산
	    paging_dto.pageSetting();
	    
	    Map<String, Object> paraMap = new HashMap<>();
	    
	    paraMap.put("paging_dto", paging_dto);
	    
	    // 공지사항 목록 조회
	    notice_list = service.notice_list(paraMap);

	    mav.addObject("notice_count", notice_count);
	    mav.addObject("paging_dto", paging_dto);
	    mav.addObject("notice_list", notice_list);
		
		mav.setViewName("admin/admin_notice_delete");
		return mav;
	}
	
	// 공지사항 작성
	@PostMapping("admin_notice_write")
	public ModelAndView notice_write(ModelAndView mav, NoticeVO noticevo, MultipartHttpServletRequest mrequest) {
		
		member_vo = getMemberDetail.MemberDetail();
		
		String pk_member_no = member_vo.getPk_member_no();
		
		noticevo.setFk_member_no(pk_member_no);
		
		MultipartFile attach = noticevo.getAttach();
		
		if (attach != null) {

			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files";

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long filesize = 0;
			// 첨부파일의 크기

			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();

				// 첨부되어진 파일을 업로드 하는 것이다.
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

				noticevo.setNotice_filename(newFileName);

				noticevo.setNotice_orgfilename(originalFilename);
				
				filesize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				noticevo.setNotice_filesize(String.valueOf(filesize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			n = service.add(noticevo); // <== 파일첨부가 없는 공지사항
		} else {
			// 파일첨부가 있는 경우라면
			n = service.add_withFile(noticevo); // <== 파일첨부가 있는 공지사항
		}

		if (n == 1) {
			mav.setViewName("admin/admin_page");
			
		} 
		else {
			mav.setViewName("/WEB-INF/views/error.jsp");			
		}
		return mav;
	}
	
	// 1:1문의 미답변 리스트
	@GetMapping("admin_uninquire_list")
	public ModelAndView uninquire_list(ModelAndView mav, @RequestParam(defaultValue = "1") int cur_page) {
		
		// 1:1문의 총 개수
	    int inquire_count = service.getInquireCount();
	    
	    PagingDTO paging_dto = PagingDTO.builder()
	            .cur_page(cur_page)
	            .row_size_per_page(5)  
	            .page_size(5)  
	            .total_row_count(inquire_count)
	            .build();

	    // 페이징 정보 계산
	    paging_dto.pageSetting();
	    
	    Map<String, Object> paraMap = new HashMap<>();
	    
	    paraMap.put("paging_dto", paging_dto);
		
		List<Map<String, String>> uninquire_list = service.uninquire_list(paraMap);
		
	    mav.addObject("inquire_count", inquire_count);
	    mav.addObject("paging_dto", paging_dto);
		mav.addObject("uninquire_list", uninquire_list);
		
		mav.setViewName("admin/admin_uninquire_list");
		return mav;
	}

	// 공지사항 삭제
	@PostMapping("admin_notice_delete")
	@ResponseBody
	public Map<String, Integer> admin_notice_delete(@RequestParam Map<String, String> paraMap, HttpServletRequest request) {

		String pk_notice_no = request.getParameter("pk_notice_no");
		
		NoticeVO notice_vo = service.getView_delete(pk_notice_no);

        String filename = notice_vo.getNotice_filename();
        
        if(filename != null && !"".equals(filename.trim())) {

           HttpSession session = request.getSession(); 
		   String root = session.getServletContext().getRealPath("/");
		   
		   String filepath = root+"resources"+File.separator+"files";
        	
		   paraMap.put("filepath", filepath);
           paraMap.put("filename", filename);
        }
		
	    int n=0;
				
		try {
		  n = service.notice_delete(paraMap);
		} 
		catch(Throwable e) {
			e.printStackTrace();
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	}
	
	// 유저 관리
	@GetMapping("admin_member_management")
	public ModelAndView admin_member_management(ModelAndView mav, @RequestParam(defaultValue = "1") int cur_page) {
		
		// 유저 총 수
		int member_count = service.getmember_count();
		
		 PagingDTO paging_dto = PagingDTO.builder()
	            .cur_page(cur_page)
	            .row_size_per_page(5)  
	            .page_size(5)  
	            .total_row_count(member_count)
	            .build();

	    // 페이징 정보 계산
	    paging_dto.pageSetting();
	    
	    Map<String, Object> paraMap = new HashMap<>();
	    
	    paraMap.put("paging_dto", paging_dto);
		
		List<MemberVO> member_list = service.admin_member_management(paraMap);
		
		// 유저 조회
		mav.addObject("member_list", member_list);		
		mav.addObject("member_count", member_count);
		mav.addObject("paging_dto", paging_dto);
		
		mav.setViewName("admin/admin_member_management");
		return mav;
	}
		
	// 유저 상태 변경
	@PostMapping("admin_member_status")
	@ResponseBody
	public Map<String, Integer> admin_member_status(@RequestParam Map<String, String> paraMap) {
	    String member_no = paraMap.get("member_no");
	    String new_status = paraMap.get("new_status");
	    
	    int status = Integer.parseInt(new_status);

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("member_no", member_no);
	    paramMap.put("status", status);

	    int update_status = service.update_member_status(paramMap);

	    Map<String, Integer> map = new HashMap<>();
	    map.put("success", update_status);  // 상태 변경 성공 여부 (1: 성공, 0: 실패)

	    return map;
	}

	// 상품 리스트
	@GetMapping("admin_product_list")
	public ModelAndView admin_product_list(ModelAndView mav, @RequestParam(defaultValue = "1") int cur_page) {
		
		// 상품 총 개수
		int product_count = service.getproduct_count();
		
		 PagingDTO paging_dto = PagingDTO.builder()
	            .cur_page(cur_page)
	            .row_size_per_page(8)
	            .page_size(5)  
	            .total_row_count(product_count)
	            .build();

	    // 페이징 정보 계산
	    paging_dto.pageSetting();
	    
	    Map<String, Object> paraMap = new HashMap<>();
	    
	    paraMap.put("paging_dto", paging_dto);
		
		// 상품조회
		List<Map<String, String>> admin_product_list = service.get_admin_product_list(paraMap);
		
		// 유저 조회
		mav.addObject("admin_product_list", admin_product_list);
		mav.addObject("product_count", product_count);
		mav.addObject("paging_dto", paging_dto);
		
		mav.setViewName("admin/admin_product_list");
		return mav;
	}
	
	// 상품 상세정보
	@GetMapping("admin_product_detail")
	public ModelAndView admin_product_detail(ModelAndView mav, HttpServletRequest request) {
	    String pk_product_no = request.getParameter("pk_product_no");
	    
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("pk_product_no", pk_product_no);
		
	    Map<String, String> product_vo = service.admin_product_detail(paraMap);
	    
	    mav.addObject("product_vo", product_vo);
	    
	    mav.setViewName("admin/admin_product_detail");
	    return mav;
	}
	
	// 상품삭제하기
	@ResponseBody
	@PostMapping("admin_deleteproduct")
	public String admin_deleteproduct(HttpServletRequest request) throws Throwable {
		
		String pk_product_no = request.getParameter("pk_product_no");
				
		int n = service.admin_deleteproduct(pk_product_no);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	// 관리자 통계페이지
	@GetMapping("admin_statistics")
	public ModelAndView admin_statistics(ModelAndView mav) {		
		mav.setViewName("admin/admin_statistics");
		return mav;
	}	
	
	// 일별 방문자 차트
	@GetMapping("admin_statistics/admin_visitantchat")
	@ResponseBody
	public List<Map<String, String>> admin_visitantchat() {
		
		List<Map<String, String>> admin_visitantchat = service.admin_visitantchat();
		
		return admin_visitantchat;
	}
	
	// 월별 방문자 차트
	@GetMapping("admin_statistics/admin_visitant_monthchat")
	@ResponseBody
	public List<Map<String, String>> admin_visitant_monthchat() {
		
		List<Map<String, String>> admin_visitant_monthchat = service.admin_visitant_monthchat();
		
		return admin_visitant_monthchat;
	}	

	// 연별 방문자 차트
	@GetMapping("admin_statistics/admin_visitant_yearchat")
	@ResponseBody
	public List<Map<String, String>> admin_visitant_yearchat() {
		
		List<Map<String, String>> admin_visitant_yearchat = service.admin_visitant_yearchat();
		
		return admin_visitant_yearchat;
	}		
		
	// 일별 매출액 차트
	@GetMapping("admin_statistics/admin_saleschat")
	@ResponseBody
	public List<Map<String, String>> admin_saleschat() {
		
		List<Map<String, String>> admin_saleschat = service.admin_saleschat();
		
		return admin_saleschat;
	}

	// 카테고리별 상품 조회수차트
	@GetMapping("admin_statistics/admin_product_total_views")
	@ResponseBody
	public List<Map<String, String>> admin_product_total_views() {
		
		List<Map<String, String>> admin_product_total_views = service.admin_product_total_views();
		
		return admin_product_total_views;
	}

	// 캘린더를 불러오는것
	@ResponseBody
	@GetMapping(value="admin_selectcalendar")
	public String admin_selectcalendar(HttpServletRequest request) {

		member_vo = getMemberDetail.MemberDetail();
		
		String pk_member_no = member_vo.getPk_member_no();
				
		List<CalendarVO> calendar_list = service.admin_selectcalendar(pk_member_no);
		
		JSONArray jsArr = new JSONArray();
		
		if(calendar_list != null && calendar_list.size() > 0) {
			
			for(CalendarVO cvo : calendar_list) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("calendar_title", cvo.getCalendar_title());
				jsObj.put("calendar_startdate", cvo.getCalendar_startdate());
				jsObj.put("calendar_enddate", cvo.getCalendar_enddate());
				jsObj.put("pk_calendar_no", cvo.getPk_calendar_no());
				jsObj.put("pk_member_no", pk_member_no);
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	}

	// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
	@PostMapping("admin_insertcalendar")
	public ModelAndView insertSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// form 에서 받아온 날짜
		String choose_date = request.getParameter("choose_date");
		
		mav.addObject("choose_date", choose_date);
		mav.setViewName("admin/admin_insertcalendar");
		
		return mav;
	}

	// 캘린더 일정 등록하기
	@PostMapping("admin_registercalendar")
	public ModelAndView admin_registercalendar(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		member_vo = getMemberDetail.MemberDetail();
		
		String pk_member_no = member_vo.getPk_member_no();
		String calendar_startdate= request.getParameter("calendar_startdate");   	    
		String calendar_enddate = request.getParameter("calendar_enddate");
		String calendar_title = request.getParameter("calendar_title");
		String calendar_place = request.getParameter("calendar_place");		
		String calendar_content = request.getParameter("calendar_content");

		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("calendar_startdate", calendar_startdate);
		paraMap.put("calendar_enddate", calendar_enddate);
		paraMap.put("calendar_title", calendar_title);
		paraMap.put("calendar_place", calendar_place);
		paraMap.put("calendar_content", calendar_content);
		paraMap.put("pk_member_no", pk_member_no);
		
		int n = service.admin_registercalendar(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "일정 등록에 성공하였습니다.");
		}
		
		mav.setViewName("admin/admin_page");
		
		return mav;
	}
		
	// 일정상세보기
	@GetMapping(value="admin_detailcalendar")
	public ModelAndView admin_detailcalendar(ModelAndView mav, HttpServletRequest request) {
		
		String pk_calendar_no = request.getParameter("pk_calendar_no");
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_calendar = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_calendar",listgobackURL_calendar);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(pk_calendar_no);
			Map<String,String> map = service.admin_detailcalendar(pk_calendar_no);
			mav.addObject("map", map);
			mav.setViewName("admin/admin_detailcalendar");
		} catch (NumberFormatException e) {
			mav.setViewName("admin/admin_page");
		}
		
		return mav;
	}

	// 일정삭제하기
	@ResponseBody
	@PostMapping("admin_deletecalendar")
	public String admin_deletecalendar(HttpServletRequest request) throws Throwable {
		
		String pk_calendar_no = request.getParameter("pk_calendar_no");
				
		int n = service.admin_deletecalendar(pk_calendar_no);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	// 일정 수정하기 폼
	@PostMapping("admin_editcalendar")
	public ModelAndView admin_editcalendar(ModelAndView mav, HttpServletRequest request) {
		
		String pk_calendar_no= request.getParameter("pk_calendar_no");
   		
		try {
			Integer.parseInt(pk_calendar_no);
			
			Map<String,String> map = service.admin_detailcalendar(pk_calendar_no);

			mav.addObject("map", map);
			
			mav.setViewName("admin/admin_editcalendar");

		} catch (NumberFormatException e) {
			mav.setViewName("admin/admin_page");
		}
		
		return mav;		
	}
	
	// 일정 수정하기 
	@PostMapping("admin_editcalendar_end")
	public ModelAndView admin_editcalendar_end(CalendarVO cvo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			 int n = service.admin_editcalendar_end(cvo);
			 
			 if(n==1) {
				 mav.addObject("message", "일정을 수정하였습니다.");
				 mav.setViewName("admin/admin_page");
			 }
			 else {
				 mav.addObject("message", "일정 수정에 실패하였습니다.");
				 mav.setViewName("admin/admin_page");
			 }
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("admin/admin_page");
		}
			
		return mav;
	}

	// 검색 기능
	@GetMapping("admin_searchcalendar")
	public ModelAndView admin_searchcalendar(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> calendar_list = null;
		
		String calendar_startdate = request.getParameter("calendar_startdate");
		String calendar_enddate = request.getParameter("calendar_enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType==null || (!"calendar_title".equals(searchType) && !"calendar_content".equals(searchType))) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(calendar_startdate==null || "".equals(calendar_startdate)) {
			calendar_startdate="";
		}
		
		if(calendar_enddate==null || "".equals(calendar_enddate)) {
			calendar_enddate="";
		}

		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("calendar_startdate", calendar_startdate);
		paraMap.put("calendar_enddate", calendar_enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		calendar_list = service.admin_searchcalendar(paraMap);

		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("calendar_list", calendar_list);
		mav.setViewName("admin/admin_searchcalendar");

		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
