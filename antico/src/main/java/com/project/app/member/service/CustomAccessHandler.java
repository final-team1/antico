package com.project.app.member.service;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAccessHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException access_denied_exception) throws IOException, ServletException {
		
		String request_url = request.getRequestURI();
		
		if(request_url.startsWith("/product")) {
			response.sendRedirect("/index");
		}else {
			response.sendRedirect("/index");
		}
		

	}

}
