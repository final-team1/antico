package com.project.app.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.review.mapper.ReviewMapper;

@Service
public class ReviewService_imple implements ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;

	@Override
	@Transactional
	public List<String> select() {
		return reviewMapper.select();
	}


}
