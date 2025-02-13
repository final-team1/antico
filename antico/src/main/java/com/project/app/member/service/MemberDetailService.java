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
		
		
		return new CustomUserDetails(mvo.getPk_mem_no(), mvo.getMem_passwd() , mvo.getMem_user_id()
				 , mvo.getMem_regdate(),mvo.getMem_tel(), mvo.getMem_passwd_change_date()
				 ,mvo.getMem_authorization(), mvo.getMem_point(), mvo.getMem_score()
			     ,mvo.getMem_status());
	}
	
	
	
	
	
}
