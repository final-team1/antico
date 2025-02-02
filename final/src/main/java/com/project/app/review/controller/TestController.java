package com.project.app.review.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.review.service.ReviewService;

@Controller
@RequestMapping("/test/*")
public class TestController {	
	
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("test1")
	public ModelAndView test(ModelAndView mav) {
		// List<String> list = reviewService.select();

		throw new IllegalArgumentException();
		
		// mav.addObject("list", list);
		// mav.setViewName("test");
		// return mav;
	}

}
