package com.project.app.admin.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.admin.domain.CalendarVO;
import com.project.app.member.domain.MemberVO;
import com.project.app.notice.domain.NoticeVO;
import com.project.app.product.domain.ProductImageVO;

@Mapper
public interface AdminDAO {

	// 파일첨부가 없는 공지사항 작성
	int add(NoticeVO noticevo);

	// 파일첨부가 있는 공지사항 작성
	int add_withFile(NoticeVO noticevo);

	// 1:1문의 총개수
	int getInquireCount();
	
	// 미답변 1:1문의 리스트
	List<Map<String, String>> uninquire_list(Map<String, Object> paraMap);

	// 공지사항 총개수
	int getNoticeCount();

	// 공지사항 조회
	List<NoticeVO> notice_list(Map<String, Object> paraMap);

	// 공지사항 파일삭제
	NoticeVO getView_delete(String pk_notice_no);

	// 공지사항 삭제
	int notice_delete(String pk_notice_no);

	// 유저 총 수
	int getmember_count();
	
	// 멤버 조회
	List<MemberVO> admin_member_management(Map<String, Object> paramMap);

	// 유저 상태 변경
	int update_member_status(Map<String, Object> paramMap);
	
	// 상품 총 개수
	int getproduct_count();
	
	// 상품 조회
	List<Map<String, String>> get_admin_product_list(Map<String, Object> paraMap);

	// 상품 상세정보
	Map<String, String> admin_product_detail(Map<String, String> paraMap);

	// 일별 방문자 차트
	List<Map<String, String>> admin_visitantchat();

	// 월별 방문자 차트
	List<Map<String, String>> admin_visitant_monthchat();

	// 연별 방문자 차트
	List<Map<String, String>> admin_visitant_yearchat();

	// 일별 매출액	
	List<Map<String, String>> admin_saleschat();

	// 카테고리별 상품 조회수
	List<Map<String, String>> admin_product_total_views();

	// 캘린더 일정 등록하기
	int admin_registercalendar(Map<String, String> paraMap);

	// 캘린더를 불러오는것
	List<CalendarVO> admin_selectcalendar(String pk_member_no);

	// 일정상세보기
	Map<String, String> admin_detailcalendar(String pk_calendar_no);

	// 일정삭제하기
	int admin_deletecalendar(String pk_calendar_no);

	// 상품삭제하기
	int admin_deleteproduct(String pk_product_no);

	// 일정 수정하기
	int admin_editcalendar_end(CalendarVO cvo);

	// 검색 기능
	List<Map<String, String>> admin_searchcalendar(Map<String, String> paraMap);

	// 해당 상품에 대한 이미지 정보 가져오기
	List<ProductImageVO> getproductimg(String pk_product_no);








	


}
