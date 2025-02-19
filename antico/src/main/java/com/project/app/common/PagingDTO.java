package com.project.app.common;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

/*
 * 페이징을 위해 페이지 정보를 담는 DTO 
 */
@Getter
@Setter
@Builder
public class PagingDTO {
	
	// 입력 데이터
	private int cur_page; // 현재 페이지 번호

	private int row_size_per_page; // 페이지 당 레코드 수

	private int page_size; // 페이지리스트에서 보여줄 페이지 개수 (1페이지, 2페이지 ...)

	private int total_row_count; // 전체 레코드(데이터) 개수

	// 계산되는 데이터
	private int first_row; // 시작 레코드 번호 ex) 1번 레코드

	private int last_row; // 마지막 레코드 번호 ex) 10번 레코드

	private int total_page_count; // 총 페이지 수

	private int first_page; // 페이지 리스트에서 시작 페이지 번호 ex) [6], [7], [8], [9], [10] 에서 6를 뜻함

	private int last_page; // 페이지 리스트에서 마지막 페이지 번호 ex) [6], [7], [8], [9], [10] 에서 10를 뜻함

	public void pageSetting() {
		// curPage 유효성 검사
		if(cur_page > total_row_count || cur_page < 1 ) {
			cur_page = 1;
		}
		
		total_page_count= (total_row_count-1) / row_size_per_page + 1;
		
		first_row = (cur_page - 1) * row_size_per_page + 1;
		
		last_row = first_row + row_size_per_page - 1;
		
		if(last_row > total_row_count) {
			last_row = total_row_count;
		}

		// 현재 보고 있는 페이지 라인 기준 첫번째 페이지이다.
		// ex) [6], [7], [8], [9], [10] 이 중 어떤 페이지라도 6으로 나온다
		first_page = (cur_page - 1) / page_size * page_size + 1;  
 
		// 현재 보고 있는 페이지 라인 기준 마지막 페이지이다.
		// ex) [6], [7], [8], [9], [10] 이 중 어떤 페이지라도 10으로 나온다
		last_page = first_page+page_size-1;
		
		if(last_page > total_page_count) {
			last_page = total_page_count;
		}
	}
}
