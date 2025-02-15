package com.project.app.review.domain;

import lombok.Getter;
import lombok.Setter;

/*
 * 사용자 개인 블랙리스트 VO
 */

@Getter
@Setter
public class BlacklistVO {

	private String pk_blacklist_no; // 블랙리스트 일련번호
	
	private String fk_target_member_no; // 차단 대상 일련번호
	
	private String fk_member_no; // 차단자 일련번호
	
	private String blacklist_regdate; // 차단일

}
