package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

@Service
public class MemberDetailService implements UserDetailsService{

	@Autowired
	private final MemberDAO mdao;
	
	@Autowired
	private PasswordEncoder pass_encoder;
	
	public MemberDetailService(MemberDAO mdao) {
		this.mdao = mdao;
	}


	@Transactional
	@Override
	public UserDetails loadUserByUsername(String mem_user_id) throws UsernameNotFoundException {
		
		MemberVO mvo = mdao.selectMemberByUserId(mem_user_id);
		// TODO memberVO 유효성검사
		
		
		return new CustomUserDetails(mvo.getPk_member_no(), mvo.getMember_passwd() , mvo.getMember_user_id()
				 , mvo.getMember_regdate(),mvo.getMember_tel(), mvo.getMember_passwd_change_date()
				 ,mvo.getMember_role(), mvo.getMember_point(), mvo.getMember_score()
			     ,mvo.getMember_status());
	}
	
	
	
	
	
}
