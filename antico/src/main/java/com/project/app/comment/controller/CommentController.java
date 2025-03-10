package com.project.app.comment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.comment.domain.CommentVO;
import com.project.app.comment.service.CommentService;
import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comment/*")
public class CommentController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private CommentService service;
	
	@Autowired
	private GetMemberDetail getMemberDetail;
	
	@Autowired
	private MemberVO member_vo;
	
	// 문의 작성
	@PostMapping("comment_add")
	public ModelAndView comment_write(ModelAndView mav, CommentVO comment_vo
			                          , MultipartHttpServletRequest mrequest, HttpServletRequest request) {
		
		member_vo = getMemberDetail.MemberDetail();
		
		String fk_member_no = member_vo.getPk_member_no();
		String member_name = member_vo.getMember_name();		
		comment_vo.setFk_member_no(fk_member_no);
		comment_vo.setMember_name(member_name);
		
		String fk_inquire_no = request.getParameter("pk_inquire_no");		
		comment_vo.setFk_inquire_no(fk_inquire_no);
		
		String fk_parent_no = request.getParameter("fk_parent_no");		
		comment_vo.setFk_parent_no(fk_parent_no);
		
		MultipartFile attach = mrequest.getFile("attach");
		
		int n = 0;
		
		if (attach.isEmpty()) {
			n = service.add_comment(comment_vo);
		}
		else {
			n = service.add_file_comment(comment_vo, attach);
		}
		
		if (n == 1) {
			String referer = request.getHeader("Referer");
			 mav.setViewName("redirect:" + referer);			
		} 
		else {
			mav.setViewName("/WEB-INF/views/error.jsp");			
		}
		return mav;
	}
	
	
}
