package com.project.app.component;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class TestControllerAdvice {
	
	@ExceptionHandler(IllegalArgumentException.class)
    public ModelAndView IllegalArgumentException() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error");
		return mav;
    }

}
