package com.project.app.comment.controller;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.comment.domain.CommentVO;
import com.project.app.comment.service.CommentService;
import com.project.app.common.FileManager;
import com.project.app.component.GetMemberDetail;
import com.project.app.inquire.domain.InquireVO;
import com.project.app.inquire.service.InquireService;
import com.project.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment/*")
public class CommentController {
	
	//@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	//private CommentService service;
	
	@Autowired
	private GetMemberDetail getMemberDetail;
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 문의 작성
	@PostMapping("comment_add")
	public ModelAndView comment_write(Map<String, String> paraMap, ModelAndView mav,
			                        CommentVO commentvo, MultipartHttpServletRequest mrequest) {
		
		MemberVO member_VO = getMemberDetail.MemberDetail();

		MultipartFile attach = commentvo.getAttach();
		
		if (attach != null) {

			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files";

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long fileSize = 0;
			// 첨부파일의 크기

			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();

				// 첨부되어진 파일을 업로드 하는 것이다.
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

				commentvo.setComment_filename(newFileName);

				commentvo.setComment_orgfilename(originalFilename);
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				commentvo.setComment_filesize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			//n = service.add(commentvo); // <== 파일첨부가 없는 답변
		} else {
			// 파일첨부가 있는 경우라면
			//n = service.add_withFile(commentvo); // <== 파일첨부가 있는 답변
		}

		if (n == 1) {
			mav.setViewName("redirect:/inquire/inquire_list");
			
		} 
		else {
			mav.setViewName("/WEB-INF/views/error.jsp");			
		}
		return mav;
	}
}
