package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class MemberDetailService implements UserDetailsService{

	@Autowired
	private MemberDAO member_dao;
	
	@Autowired
	private MemberVO member_vo;
	




	@Transactional
	@Override
	public UserDetails loadUserByUsername(String member_user_id) throws UsernameNotFoundException {
		
		member_vo = member_dao.selectMemberByUserId(member_user_id);
		// TODO memberVO 유효성검사
		
		CustomUserDetails user_detail = new CustomUserDetails(member_vo);
		
		
		return User.withUserDetails(user_detail).build();		
	}
	
	
/*	public static UserBuilder withUserDetails(UserDetails userDetails) {
		// @formatter:off
		return withUsername(userDetails.getUsername())
				.password(userDetails.getPassword())
				.accountExpired(!userDetails.isAccountNonExpired())
				.accountLocked(!userDetails.isAccountNonLocked())
				.authorities(userDetails.getAuthorities())
				.credentialsExpired(!userDetails.isCredentialsNonExpired())
				.disabled(!userDetails.isEnabled());
		// @formatter:on
	}*/
	
	
}


/*
 * 
 * return new CustomUserDetails(mvo.getPk_member_no(), mvo.getMember_passwd() ,
 * mvo.getMember_user_id() ,mvo.getMember_regdate(),mvo.getMember_tel(),
 * mvo.getMember_passwd_change_date() ,mvo.getMember_role(),
 * mvo.getMember_point(), mvo.getMember_score() ,mvo.getMember_status())
 * 
 */