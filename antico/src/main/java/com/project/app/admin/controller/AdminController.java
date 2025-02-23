package com.project.app.admin.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.admin.service.AdminService;
import com.project.app.common.FileManager;
import com.project.app.notice.domain.NoticeVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private AdminService service;
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 관리자 페이지
	@GetMapping("admin_page")
	public ModelAndView inquireadd(ModelAndView mav) {		
		mav.setViewName("admin/admin_page");
		return mav;
	}
	
	// 공지사항 작성폼
	@GetMapping("admin_notice_write")
	public ModelAndView notice_write(ModelAndView mav) {		
		mav.setViewName("admin/admin_notice_write");
		return mav;
	}
	
	// 공지사항 작성
	@PostMapping("admin_notice_write")
	public ModelAndView notice_write(ModelAndView mav, NoticeVO noticevo, MultipartHttpServletRequest mrequest) {
		
		MultipartFile attach = noticevo.getAttach();
		
		if (attach != null) {

			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files";

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long filesize = 0;
			// 첨부파일의 크기

			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();

				// 첨부되어진 파일을 업로드 하는 것이다.
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

				noticevo.setNotice_filename(newFileName);

				noticevo.setNotice_orgfilename(originalFilename);
				
				filesize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				noticevo.setNotice_filesize(String.valueOf(filesize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			n = service.add(noticevo); // <== 파일첨부가 없는 공지사항
		} else {
			// 파일첨부가 있는 경우라면
			n = service.add_withFile(noticevo); // <== 파일첨부가 있는 공지사항
		}

		if (n == 1) {
			mav.setViewName("admin/admin_page");
			
		} 
		else {
			mav.setViewName("/WEB-INF/views/error.jsp");			
		}
		return mav;
	}
	
	// 1:1문의 미답변 리스트
	@GetMapping("admin_uninquire_list")
	public ModelAndView uninquire_list(ModelAndView mav) {

		List<Map<String, String>> uninquire_list = service.uninquire_list();
		
		mav.addObject("uninquire_list", uninquire_list);
		
		mav.setViewName("admin/admin_uninquire_list");
		return mav;
	}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
