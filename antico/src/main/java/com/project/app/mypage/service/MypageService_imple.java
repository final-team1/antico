package com.project.app.mypage.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.app.mypage.model.MypageDAO;

@Service
public class MypageService_imple implements MypageService {

    @Autowired
    private MypageDAO mypagedao;
    
	// 탈퇴 테이블 탈퇴신청시 insert
	@Override
	public int delete_submit(Map<String, String> paraMap) {
		int n = mypagedao.delete_submit(paraMap);
		return n;
	}

	@Override
	public int pointcharge(Map<String, String> paraMap) {
		int n = mypagedao.pointcharge(paraMap); // 충전테이블 insert
		int m = 0;
		if(n == 1) {
			m = mypagedao.pointupdate(paraMap); // 회원의 포인트 update
		}
		return n*m;
	}
}
