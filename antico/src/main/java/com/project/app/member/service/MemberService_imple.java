package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

/*
 * MemberService 구현체
 */
@Service
public class MemberService_imple implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int registerMember(MemberVO mvo) {
		return memberDAO.registerMember(mvo);
	}

	@Override
	@Transactional(readOnly = true)
	public MemberVO getMember(String memberNo) {
		return memberDAO.selectMemberByMemberNo(memberNo);
	}


}
