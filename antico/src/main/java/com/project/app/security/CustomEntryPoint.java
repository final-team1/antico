package com.project.app.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {

		String request_uri = request.getRequestURI();
		
		String ctx_path = request.getContextPath();
		
		System.out.println("AuthenticationEntryPoint");
		
		if(request_uri.startsWith(ctx_path + "/product/add")){
			
			Cookie cookie = new Cookie("message", URLEncoder.encode("로그인후&nbsp;판매가&nbsp;가능합니다", "UTF-8"));
			
			cookie.setMaxAge(5); 
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
			
		}else if(request_uri.startsWith(ctx_path+"/mypage/")) {
			
			Cookie cookie = new Cookie("message", URLEncoder.encode("마이페이지는&nbsp;로그인&nbsp;후에&nbsp;확인가능합니다.", "UTF-8"));
			
			cookie.setMaxAge(5); 
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
			
		}else if(request_uri.startsWith(ctx_path+"/admin")) {
			Cookie cookie = new Cookie("message", URLEncoder.encode("관리자페이지는&nbsp;관리자만&nbsp;확인가능합니다.", "UTF-8"));
			
			cookie.setMaxAge(5); 
			
			cookie.setPath("/");
			
			response.addCookie(cookie);
		}else if(request_uri.startsWith(ctx_path+"/chat")) {
			
			response.sendError(500, "msg/채팅은 로그인후에 확인가능합니다.");
			
			return;
		}else if(request_uri.startsWith(ctx_path+"/inquire/inquire_add")) {
			
			response.sendError(500, "msg/문의는 로그인 후에 보실수 있습니다.");
			
			return;
		}
		
		response.sendRedirect(ctx_path+"/member/login");
		
	}

}
