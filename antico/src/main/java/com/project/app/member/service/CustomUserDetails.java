package com.project.app.member.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.project.app.member.domain.MemberVO;

public class CustomUserDetails implements UserDetails {
	
	private final String pk_mem_no;
	private final String mem_passwd;
	private final String mem_user_id;
	private final String mem_regdate;
	private final String mem_tel;
	private final String mem_passwd_change_date;
	private final String mem_authorization;
	private final String mem_point;
	private final String mem_score;
	private final String mem_status;
	
	
	
	
	

	public CustomUserDetails(String pk_mem_no, String mem_passwd, String mem_user_id, String mem_regdate,
			String mem_tel, String mem_passwd_change_date, String mem_authorization, String mem_point, String mem_score,
			String mem_status) {
		this.pk_mem_no = pk_mem_no;
		this.mem_passwd = mem_passwd;
		this.mem_user_id = mem_user_id;
		this.mem_regdate = mem_regdate;
		this.mem_tel = mem_tel;
		this.mem_passwd_change_date = mem_passwd_change_date;
		this.mem_authorization = mem_authorization;
		this.mem_point = mem_point;
		this.mem_score = mem_score;
		this.mem_status = mem_status;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority> grantedauthority = new ArrayList<>();
		
		String role = "";
		
		switch (mem_authorization) {
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
		return mem_passwd;
	}

	@Override
	public String getUsername() {
		return mem_user_id;
	}
	
	public String getPk_mem_no() {
		return pk_mem_no;
	}

	public String getMem_regdate() {
		return mem_regdate;
	}
	
	public String getMem_tel() {
		return mem_tel;
	}

	public String getMem_passwd_change_date() {
		return mem_passwd_change_date;
	}
	
	public String getMem_point() {
		return mem_point;
	}
	
	public String getMem_score() {
		return mem_score;
	}

	public String getMem_status() {
		return mem_status;
	}


}
