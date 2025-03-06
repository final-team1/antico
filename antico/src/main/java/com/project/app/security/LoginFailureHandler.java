package com.project.app.security;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.AccountExpiredException;
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
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
		
		String message = "";
		
		// 탈퇴한지 72시간이 지나 로그인이 불가능할 때 던진 계정만료 예외
		// TODO InternalAuthenticationServiceException로 래핑된 예외인데 이 예외도 체크해야 하는지 확인
		if(e.getCause() instanceof AccountExpiredException) {
			message = e.getMessage();
		}
		else {
			e.printStackTrace();
			message = "로그인에&nbsp;실패했습니다.&nbsp;아이디,&nbsp;비밀번호를&nbsp;확인해주세요.";
		}
		
		String ctx_path = request.getContextPath();
		
		Cookie cookie = new Cookie("message", URLEncoder.encode(message, "UTF-8"));
		
		cookie.setMaxAge(5); 
		
		cookie.setPath("/");
		
		response.addCookie(cookie);
		
		response.sendRedirect(ctx_path+"/member/login");
		

	}

}
