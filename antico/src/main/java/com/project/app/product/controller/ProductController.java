package com.project.app.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.app.product.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;

/*
 * 상품 컨트롤러
 */
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	ProductService service;
	
	
	@GetMapping("add")  
	public String add(HttpServletRequest request) {

		return "product/add";
		
	}
	
}
