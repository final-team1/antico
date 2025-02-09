package com.project.app.member.model;

import com.project.app.member.domain.MemberVO;

public interface MemberDAO {

	int registerMember(MemberVO mvo);

	MemberVO selectMemberByUserId(String mem_user_id);

}
