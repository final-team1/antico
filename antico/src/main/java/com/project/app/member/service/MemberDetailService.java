package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

@Service
public class MemberDetailService implements UserDetailsService{

	@Autowired
	MemberDAO mdao;
	
	
	@Transactional
	@Override
	public UserDetails loadUserByUsername(String mem_user_id) throws UsernameNotFoundException {
		
		System.out.println(mem_user_id);
		
		MemberVO mvo = mdao.selectMemberByUserId(mem_user_id);
		
		System.out.println(mvo.getMem_passwd());
		
		// TODO memberVO 유효성검사
		
		 return User.builder()
	                .username(mvo.getMem_user_id())
	                .password(mvo.getMem_passwd())
	                .build();
	}
	
	
	
	
	
}
