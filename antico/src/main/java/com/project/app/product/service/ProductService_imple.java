package com.project.app.product.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.product.model.ProductMapper;

@Service
public class ProductService_imple implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	
}
