package com.project.app.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.notice.domain.NoticeVO;
import com.project.app.notice.service.NoticeService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="notice/*")
public class NoticeController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private NoticeService service;

	// 공지사항 조회
	@GetMapping("notice_list")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request, 
			                 @RequestParam(defaultValue = "") String searchWord,
			                 @RequestParam(defaultValue = "1") String currentShowPageNo) {
		
		List<NoticeVO> notice_list = null;

		searchWord = searchWord.trim();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		
		notice_list = service.notice_list(paraMap);
		
		mav.addObject("notice_list", notice_list);
		
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
			}// end of for-------------
		}
		
		return searchshow_mapList;
	}
}