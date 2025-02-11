package com.project.app.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/notice/*")
public class NoticeController {
	
	
	@GetMapping("list")
	public ModelAndView list(ModelAndView mav) {
		mav.setViewName("notice/list");
		return mav;
	}
}
