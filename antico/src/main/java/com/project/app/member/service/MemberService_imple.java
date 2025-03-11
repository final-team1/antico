package com.project.app.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.common.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

/*
 * MemberService 구현체
 */
@Service
public class MemberService_imple implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private PasswordEncoder pwdEncoder;
	
	
	@Override
	public int registerMember(MemberVO mvo) {
		mvo.setMember_passwd(pwdEncoder.encode(mvo.getMember_passwd()));
		
		return memberDAO.registerMember(mvo);
	}

	
	@Override
	@Transactional(readOnly = true)
	public MemberVO getMember(String pk_member_no) {
		return memberDAO.selectMemberByMemberNo(pk_member_no);
	}


	
	

}
