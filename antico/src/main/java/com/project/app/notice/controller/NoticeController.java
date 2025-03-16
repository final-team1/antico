package com.project.app.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.common.FileManager;
import com.project.app.common.PagingDTO;
import com.project.app.notice.domain.NoticeVO;
import com.project.app.notice.service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="notice/*")
public class NoticeController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private NoticeService service;

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	@GetMapping("notice_list")
	public ModelAndView list(ModelAndView mav,
	                         @RequestParam(defaultValue = "") String searchWord,
	                         @RequestParam(defaultValue = "1") int cur_page) {

	    List<NoticeVO> notice_list = null;

	    // 공백 제거
	    searchWord = searchWord.trim();

	    Map<String, Object> paraMap = new HashMap<>();
	    paraMap.put("searchWord", searchWord);

	    // 공지사항 총 개수
	    int notice_count = service.getNoticeCount(paraMap);

	    PagingDTO paging_dto = PagingDTO.builder()
	            .cur_page(cur_page)
	            .row_size_per_page(5)  
	            .page_size(5)  
	            .total_row_count(notice_count)
	            .build();

	    // 페이징 정보 계산
	    paging_dto.pageSetting();
	    
	    paraMap.put("paging_dto", paging_dto);
	    
	    // 공지사항 목록 조회
	    notice_list = service.notice_list(paraMap);

	    // 모델에 데이터 추가
	    mav.addObject("notice_count", notice_count);
	    mav.addObject("paging_dto", paging_dto);
	    mav.addObject("notice_list", notice_list);

	    // 뷰 이름 설정
	    mav.setViewName("notice/notice_list");

	    return mav;
	}

	
	// 검색어 입력시 자동글 완성하기
	@GetMapping("notice_searchshow")
	@ResponseBody
	public List<Map<String, String>> notice_searchshow(@RequestParam Map<String, String> paraMap) {
		
		List<String> searchshow_list = service.notice_searchshow(paraMap); 
		
		List<Map<String, String>> searchshow_mapList = new ArrayList<>();
		
		if(searchshow_list != null) {
			for(String word : searchshow_list) {
				Map<String, String> map = new HashMap<>();
				map.put("word", word);
				searchshow_mapList.add(map);
			}
		}
		
		return searchshow_mapList;
	}
	
	// 첨부파일 다운로드
	@GetMapping("notice_download")
	public void notice_download(HttpServletRequest request, HttpServletResponse response) {

		String notice_no = request.getParameter("notice_no");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("notice_no", notice_no);
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");

		// **** 웹브라우저에 출력하기**** //
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = null;

		NoticeVO noticeVO = service.getnotice_file(paraMap);
		
		String fileName = noticeVO.getNotice_filename();

		String orgFilename = noticeVO.getNotice_orgfilename();

		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");

		String path = root + "resources" + File.separator + "files";

		// 파일다운로드
		boolean flag = false;
		flag = fileManager.doFileDownload(fileName, orgFilename, path, response);

		if (!flag) {
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// out 은 웹브라우저에 기술하는 대상체
			out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
		}

	}
				

			
		
	
	
}