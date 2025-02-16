package com.project.app.inquire.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/inquire/*")
public class InquireController {	
	
	@GetMapping("inquirelist")
	public ModelAndView inquirelist(ModelAndView mav) {
		mav.setViewName("inquire/inquirelist");
		return mav;
	}
	
	@GetMapping("inquireadd")
	public ModelAndView inquireadd(ModelAndView mav) {
		mav.setViewName("inquire/inquireadd");
		return mav;
	}
}