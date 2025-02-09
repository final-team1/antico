package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;


@Service
public class MemberService {
	
	
	@Autowired
	MemberDAO mdao;
	
	@Autowired
	PasswordEncoder pwdEncoder;
	
	public int registerMember(MemberVO mvo) {
		
		mvo.setMem_passwd(pwdEncoder.encode(mvo.getMem_passwd()));
		
		int n = mdao.registerMember(mvo);
		
		return n;
	}
	
	
	
}
