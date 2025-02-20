package com.project.app.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException e) throws IOException, ServletException {
		
		String ctx_path = request.getContextPath();
		System.out.println("AuthenticationEntryPoint");
		
		Cookie cookie = new Cookie("message", URLEncoder.encode("로그인에&nbsp;실패했습니다.&nbsp;아이디,&nbsp;비밀번호를&nbsp;확인해주세요.", "UTF-8"));
		
		cookie.setMaxAge(5); 
		
		cookie.setPath("/");
		
		response.addCookie(cookie);
		
		response.sendRedirect(ctx_path+"/member/login");
		

	}

}
