package com.project.app.member.service;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAccessHandler implements AccessDeniedHandler {
	
	
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException access_denied_exception) throws IOException, ServletException {
		
		String request_url = request.getRequestURI();
		String ctx_path = request.getContextPath();
		
		
		if(request_url.startsWith(ctx_path+"/product")) {
			
			response.sendRedirect(ctx_path+"/index");
			System.out.println("AccessDeniedHandler");
		}
		

	}

}
