package com.project.app.admin.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CalendarVO {
	private String pk_calendar_no;     //일정관리 번호
	private String fk_member_no;       // 캘린더 일정 작성자
	private String calendar_startdate; // 시작일자
	private String calendar_enddate;   // 종료일자
	private String calendar_title;     // 제목
	private String calendar_place;     // 장소
	private String calendar_content;   // 내용	
}
