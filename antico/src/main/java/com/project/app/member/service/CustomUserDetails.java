	package com.project.app.member.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.project.app.member.domain.MemberVO;

public class CustomUserDetails implements UserDetails {
	
	private final String pk_member_no;
	private final String member_regdate;
	private final String member_user_id;
	private final String member_passwd;
	private final String member_tel;
	private final String member_passwd_change_date;
	private final String member_role;
	private final String member_point;
	private final String member_score;
	private final String member_status;
	
	
	
	
	


	public CustomUserDetails(String pk_member_no, String member_regdate, String member_user_id, String member_passwd,
			String member_tel, String member_passwd_change_date, String member_role, String member_point,
			String member_score, String member_status) {
		super();
		this.pk_member_no = pk_member_no;
		this.member_regdate = member_regdate;
		this.member_user_id = member_user_id;
		this.member_passwd = member_passwd;
		this.member_tel = member_tel;
		this.member_passwd_change_date = member_passwd_change_date;
		this.member_role = member_role;
		this.member_point = member_point;
		this.member_score = member_score;
		this.member_status = member_status;
	}

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
	
	public String getPk_member_no() {
		return pk_member_no;
	}

	public String getMember_regdate() {
		return member_regdate;
	}
	
	public String getMember_tel() {
		return member_tel;
	}

	public String getMember_passwd_change_date() {
		return member_passwd_change_date;
	}
	
	public String getMember_point() {
		return member_point;
	}
	
	public String getMember_score() {
		return member_score;
	}

	public String getMember_status() {
		return member_status;
	}


}
