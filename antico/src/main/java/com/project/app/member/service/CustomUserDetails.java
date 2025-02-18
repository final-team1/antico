	package com.project.app.member.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import com.project.app.member.domain.MemberVO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class CustomUserDetails implements UserDetails {
	
	private final String pk_member_no;
	private final String member_passwd;
	private final String member_user_id;
	private final String member_regdate;
	private final String member_tel;
	private final String member_passwd_change_date;
	private final String member_role;
	private final String member_point;
	private final String member_score;
	private final String member_status;
	

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority> grantedauthority = new ArrayList<>();
		
		String role = "";
		
		switch (member_role) {
		case "0":
			role = "ROLE_USER_1";
			break;
		case "1":
			role = "ROLE_USER_2";
			break;
		case "2":
			role = "ROLE_USER_3";
			break;
		case "3":
			role = "ROLE_ADMIN_1";
			break;	
		case "4":
			role = "ROLE_ADMIN_2";
			break;	
		default:
			break;
		}
		
		if("ROLE_USER_3".equals(role)){
			
			grantedauthority.add(new SimpleGrantedAuthority("ROLE_USER_1"));
			grantedauthority.add(new SimpleGrantedAuthority("ROLE_USER_2"));
			grantedauthority.add(new SimpleGrantedAuthority(role));
			
		}else if("ROLE_USER_2".equals(role)) {
			
			grantedauthority.add(new SimpleGrantedAuthority(role));
			grantedauthority.add(new SimpleGrantedAuthority("ROLE_USER_1"));
			
		}else if("ROLE_USER_1".equals(role)) {
			
			grantedauthority.add(new SimpleGrantedAuthority(role));
			
		}else if("ROLE_ADMIN_1".equals(role)) {
			
			grantedauthority.add(new SimpleGrantedAuthority(role));
			
		}else if("ROLE_ADMIN_2".equals(role)) {
			
			grantedauthority.add(new SimpleGrantedAuthority(role));
			grantedauthority.add(new SimpleGrantedAuthority("ROLE_ADMIN_1"));
			
		}
		
		
		return grantedauthority;
	}

	@Override
	public String getPassword() {
		return member_passwd;
	}

	@Override
	public String getUsername() {
		return member_user_id;
	}
	


}
