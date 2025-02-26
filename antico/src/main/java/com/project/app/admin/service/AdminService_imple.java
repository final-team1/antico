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

	// 1:1문의 총개수
	@Override
	public int getInquireCount() {
		int Inquire_Count = dao.getInquireCount();
		return Inquire_Count;
	}

	// 유저조회
	@Override
	public List<MemberVO> admin_member_management() {
		List<MemberVO> member_list = dao.admin_member_management(); 
		return member_list;
	}

	// 유저 상태 변경
	@Override
	public int update_member_status(Map<String, Object> paramMap) {
		int update_member_status = dao.update_member_status(paramMap);
		return update_member_status;
	}





	
	
	
	
	
	
	
	
	
	
	
}
