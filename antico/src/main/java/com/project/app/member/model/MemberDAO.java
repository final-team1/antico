package com.project.app.member.model;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.member.domain.MemberVO;

@Mapper
public interface MemberDAO {

	int registerMember(MemberVO mvo);

	MemberVO selectMemberByUserId(String mem_user_id);

	// memberNo를 통한 단일 사용자 조회
	MemberVO selectMemberByMemberNo(String memberNo);

}
