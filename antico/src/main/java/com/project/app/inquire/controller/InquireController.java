package com.project.app.inquire.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.comment.domain.CommentVO;
import com.project.app.common.FileManager;
import com.project.app.component.GetMemberDetail;
import com.project.app.inquire.domain.InquireVO;
import com.project.app.inquire.service.InquireService;
import com.project.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/inquire/*")
public class InquireController {	
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private InquireService service;
	
	@Autowired
	private MemberVO member_vo;
	
	@Autowired
	private GetMemberDetail getMemberDetail;
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 문의 내역
	@GetMapping("inquire_list")
	public ModelAndView inquirelist(ModelAndView mav) {
		
		List<InquireVO> inquire_list = null;
		
		member_vo = getMemberDetail.MemberDetail();
		
		String member_name = member_vo.getMember_name();
		
		inquire_list = service.inquire_list();
		
		mav.addObject("inquire_list", inquire_list);
		mav.addObject("member_name", member_name);
		
		mav.setViewName("inquire/inquire_list");
		return mav;
	}
	
	// 문의 작성폼
	@GetMapping("inquire_add")
	public ModelAndView inquireadd(ModelAndView mav) {		
		mav.setViewName("inquire/inquire_add");
		return mav;
	}
	
	// 문의 작성
	@PostMapping("inquire_add")
	public ModelAndView inquirewrite(ModelAndView mav,
			                        InquireVO inquirevo, MultipartHttpServletRequest mrequest) {
		
		member_vo = getMemberDetail.MemberDetail();
		
		String pk_member_no = member_vo.getPk_member_no();
		
		inquirevo.setFk_member_no(pk_member_no);
		
<<<<<<< HEAD
		MultipartFile attach = inquirevo.getAttach();
=======
		MultipartFile attach = mrequest.getFile("attach");
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
		
		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			n = service.add(inquirevo); // <== 파일첨부가 없는 1:1문의
		} else {
			// 파일첨부가 있는 경우라면
			n = service.add_withFile(inquirevo, attach); // <== 파일첨부가 있는 1:1문의
		}

		if (n == 1) {
			mav.setViewName("redirect:/notice/notice_list");
			
		} 
		else {
			mav.setViewName("/WEB-INF/views/error.jsp");			
		}
		return mav;
	}
	
	// 문의 상세보기
	@GetMapping("inquire_detail")
	public ModelAndView inquireDetail(ModelAndView mav, HttpServletRequest request) {
	    String pk_inquire_no = request.getParameter("pk_inquire_no");
	    
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("pk_inquire_no", pk_inquire_no);
	    
	    member_vo = getMemberDetail.MemberDetail();
		
		String member_name = member_vo.getMember_name();
	    String member_no = member_vo.getPk_member_no();
		
	    InquireVO inquirevo = service.inquire_detail(paraMap);
	    List<CommentVO> comment_list = service.inquire_comment(pk_inquire_no);
	    
	    mav.addObject("inquirevo", inquirevo);
	    mav.addObject("comment_list", comment_list);
	    mav.addObject("member_name", member_name);
	    mav.addObject("member_no", member_no);
	    
	    mav.setViewName("inquire/inquire_detail");
	    return mav;
	}


	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}