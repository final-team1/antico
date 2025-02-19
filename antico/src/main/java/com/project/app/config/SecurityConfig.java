package com.project.app.config;

import java.io.UnsupportedEncodingException;

import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;

import com.project.app.common.AES256;
import com.project.app.common.Constants;
import com.project.app.member.service.CustomAccessHandler;
import com.project.app.member.service.CustomEntryPoint;
import com.project.app.member.service.LoginFailureHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	
	
	private final CustomAccessHandler custom_handler;
	
	
	private final CustomEntryPoint custom_entry_point;
	
	
	private final LoginFailureHandler login_failure_handler;

	

	/* 
	 * Bcrypt bean 등록
	 */
    @Bean
    PasswordEncoder pwd_encoder() {
		return new BCryptPasswordEncoder();
	}
    
	/*
	 * AES256 암호화 클래스 bean 등록
	 */
	@Bean
	AES256 aes256() throws UnsupportedEncodingException {
		return new AES256(Constants.KEY);
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    
		
    http.authorizeHttpRequests(
    		
    	  request -> request
    	  
    	  .requestMatchers("/product/**").authenticated()
          .requestMatchers("/**").permitAll()
             
          .anyRequest().authenticated()
    )
    .exceptionHandling(ex -> ex
    	 .accessDeniedHandler(custom_handler)
    	 .authenticationEntryPoint(custom_entry_point)
    	 )
    .csrf(AbstractHttpConfigurer::disable)
    .formLogin((formLogin) ->
      	formLogin
	      		.loginPage("/member/login")
	      		.loginProcessingUrl("/auth/login")
	      		.usernameParameter("member_user_id")
	      		.passwordParameter("member_passwd")
	      		.defaultSuccessUrl("/index", true)
	      		.failureHandler(login_failure_handler)
      		.permitAll()
    		);
     
     
     return http.build();
     }

	
	
	
}
