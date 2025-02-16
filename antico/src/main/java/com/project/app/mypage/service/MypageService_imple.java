package com.project.app.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.mypage.model.MypageDAO;

@Service
public class MypageService_imple implements MypageService {

	@Autowired
	private MypageDAO mypagedao;
	

	
}
