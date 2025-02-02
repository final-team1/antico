package com.project.app.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/*")
public class IndexController {
	
	@GetMapping("/")   // http://localhost:9090/final/
	public String main() {
		return "redirect:/index";  //  http://localhost:9090/final/index
	}
	
	
	@GetMapping("index")  //  http://localhost:9090/final/index
	public String index(HttpServletRequest request) {

		return "main/index";
		//   /WEB-INF/views/main/index.jsp 페이지를 만들어야 한다.
	}
	
}
