package com.project.app.mypage.model;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageDAO {

	// 탈퇴 테이블 탈퇴신청시 insert
	int delete_submit(Map<String, String> paraMap);

	// 결제하기를 눌렀을 경우 회원의 포인트 업데이트
	int pointcharge(Map<String, String> paraMap);

}
