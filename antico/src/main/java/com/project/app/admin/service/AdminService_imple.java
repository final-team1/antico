package com.project.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.admin.model.AdminDAO;
import com.project.app.common.FileManager;
import com.project.app.member.domain.MemberVO;
import com.project.app.notice.domain.NoticeVO;

@Service
public class AdminService_imple implements AdminService {

	@Autowired
	private AdminDAO dao;

	@Autowired   // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 파일첨부가 없는 공지사항 작성
	@Override
	public int add(NoticeVO noticevo) {
		int n = dao.add(noticevo);
		return n;
	}

	// 파일첨부가 있는 공지사항 작성
	@Override
	public int add_withFile(NoticeVO noticevo) {
		int n = dao.add_withFile(noticevo); // 첨부파일이 있는 경우
		return n;
	}

	// 1:1문의 총개수
	@Override
	public int getInquireCount() {
		int Inquire_Count = dao.getInquireCount();
		return Inquire_Count;
	}
	
	// 미답변 1:1문의 리스트
	@Override
	public List<Map<String, String>> uninquire_list(Map<String, Object> paraMap) {
		List<Map<String, String>> uninquire_list = dao.uninquire_list(paraMap);	
		return uninquire_list;
	}
	
	// 공지사항 총개수
	@Override
	public int getNoticeCount() {
		int NoticeCount = dao.getNoticeCount();
		return NoticeCount;
	}

	// 공지사항 조회
	@Override
	public List<NoticeVO> notice_list(Map<String, Object> paraMap) {
		List<NoticeVO> notice_list = dao.notice_list(paraMap); 
		return notice_list;
	}

	// 공지사항 파일삭제
	@Override
	public NoticeVO getView_delete(String pk_notice_no) {
		NoticeVO notice_VO = dao.getView_delete(pk_notice_no);
		return notice_VO;
	}
	
	// 공지사항 삭제
	@Override
	public int notice_delete(Map<String, String> paraMap) {
		int n = dao.notice_delete(paraMap.get("pk_notice_no"));
		
		String filepath = paraMap.get("filepath");
		String filename = paraMap.get("filename");
		
		if(filename != null && !"".equals(filename.trim())) {
			try {
				fileManager.doFileDelete(filename, filepath);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return n;
	}

	// 유저 총 수
	@Override
	public int getmember_count() {
		int member_count = dao.getmember_count();
		return member_count;
	}
	
	// 유저조회
	@Override
	public List<MemberVO> admin_member_management(Map<String, Object> paraMap) {
		List<MemberVO> member_list = dao.admin_member_management(paraMap); 
		return member_list;
	}

	// 유저 상태 변경
	@Override
	public int update_member_status(Map<String, Object> paramMap) {
		int update_member_status = dao.update_member_status(paramMap);
		return update_member_status;
	}

	// 상품 총 개수
	@Override
	public int getproduct_count() {
		int product_count = dao.getproduct_count();
		return product_count;
	}
	
	// 상품 조회
	@Override
	public List<Map<String, String>> get_admin_product_list(Map<String, Object> paraMap) {
		List<Map<String, String>> product_list = dao.get_admin_product_list(paraMap);
		return product_list;
	}

	// 상품 상세정보
	@Override
	public Map<String, String> admin_product_detail(Map<String, String> paraMap) {
		Map<String, String> product_vo = dao.admin_product_detail(paraMap);
		return product_vo;
	}

	// 일별 방문자 차트
	@Override
	public List<Map<String, String>> admin_visitantchat() {
		List<Map<String, String>> admin_visitantchat = dao.admin_visitantchat();
		return admin_visitantchat;
	}

	// 월별 방문자 차트
	@Override
	public List<Map<String, String>> admin_visitant_monthchat() {
		List<Map<String, String>> admin_visitant_monthchat = dao.admin_visitant_monthchat();
		return admin_visitant_monthchat;
	}

	// 연별 방문자 차트
	@Override
	public List<Map<String, String>> admin_visitant_yearchat() {
		List<Map<String, String>> admin_visitant_yearchat = dao.admin_visitant_yearchat();
		return admin_visitant_yearchat;
	}

	// 일별 매출액	
	@Override
	public List<Map<String, String>> admin_saleschat() {
		List<Map<String, String>> admin_saleschat = dao.admin_saleschat();
		return admin_saleschat;
	}

	// 카테고리별 상품 조회수	
	@Override
	public List<Map<String, String>> admin_product_total_views() {
		List<Map<String, String>> admin_product_total_views = dao.admin_product_total_views();
		return admin_product_total_views;
	}

	








	
	
	
	
	
	
	
	
	
	
	
}
