package com.project.app.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAccessHandler implements AccessDeniedHandler {
	
	
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException access_denied_exception) throws IOException, ServletException {
		
		String request_uri = request.getRequestURI();
		String ctx_path = request.getContextPath();
		
		if(request_uri.startsWith(ctx_path+"/admin")) {
			Cookie cookie = new Cookie("message", URLEncoder.encode("관리자페이지는&nbsp;관리자만&nbsp;확인가능합니다.", "UTF-8"));
			
			cookie.setMaxAge(5);
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
		}else if(request_uri.startsWith(ctx_path+"/auction/chatroom")) {
			response.sendError(600, "msg/경매는 실버회원부터 가능합니다.");
			
			return;
		}else if(request_uri.startsWith(ctx_path+"/comment/comment_add")) {
			response.sendError(600, "msg/경매는 실버회원부터 가능합니다.");
			
			return;
		}
		
		response.sendRedirect(ctx_path+"/index");

	}

}
