package com.project.app.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.notice.domain.NoticeVO;
import com.project.app.notice.service.NoticeService;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="notice/*")
public class NoticeController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private NoticeService service;

	// 공지사항 조회
	@GetMapping("notice_list")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request, 
			                 @RequestParam(defaultValue = "") String searchType, @RequestParam(defaultValue = "") String searchWord,
			                 @RequestParam(defaultValue = "1") String currentShowPageNo) {
		
		List<NoticeVO> notice_list = null;

		notice_list = service.notice_list();
		
		mav.addObject("notice_list", notice_list);
		
		mav.setViewName("notice/notice_list");
		
		return mav;
	}
}