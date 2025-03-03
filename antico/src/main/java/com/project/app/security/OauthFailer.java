package com.project.app.security;

import java.io.IOException;
import java.util.Collections;
import java.util.stream.Collectors;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class OauthFailer implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		log.error("❌ [OAuth2 Authentication Failed] Reason: {}", exception.getMessage());

	        if (exception instanceof OAuth2AuthenticationException) {
	            OAuth2Error error = ((OAuth2AuthenticationException) exception).getError();
	            log.error("❌ [OAuth2 Error] Code: {}", error.getErrorCode());
	            log.error("❌ [OAuth2 Error] Description: {}", error.getDescription());
	            log.error(""+ error.toString());
	        }
	        
	        
	        
		
	}

}
