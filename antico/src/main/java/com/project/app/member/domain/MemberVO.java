package com.project.app.member.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	
	private String pk_mem_no;
	private String mem_regdate;
	private String mem_user_id;
	private String mem_passwd;
	private String mem_tel;
	private String mem_passwd_change_date;
	private String mem_authorization;
	private String mem_rank;
	private String mem_point;
	
}
