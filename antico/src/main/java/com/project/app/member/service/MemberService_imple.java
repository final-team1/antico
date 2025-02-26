package com.project.app.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

/*
 * MemberService 구현체
 */
@Service
public class MemberService_imple implements MemberService {
	
	@Autowired
	private MemberDAO member_dao;
	
	@Autowired
	private PasswordEncoder pwd_encoder;
	
	@Autowired
	private MemberVO member_vo;
	
	
	@Override
	public int registerMember(MemberVO member_vo) {
		member_vo.setMember_passwd(pwd_encoder.encode(member_vo.getMember_passwd()));
		
		return member_dao.registerMember(member_vo);
	}

	
	@Override
	@Transactional(readOnly = true)
	public MemberVO getMember(String member_user_id) {
		return member_dao.selectMemberByUserId(member_user_id);
	}




	
	

}
