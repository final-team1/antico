package com.project.app.config;

import java.io.UnsupportedEncodingException;

import org.apache.poi.util.Beta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.util.matcher.RequestMatcher;

import com.project.app.common.AES256;
import com.project.app.common.Constants;
import com.project.app.member.service.CustomAccessHandler;
import com.project.app.member.service.CustomEntryPoint;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private final CustomAccessHandler custom_handler;
	
	@Autowired
	private final CustomEntryPoint custom_entry_point;
	
	


	public SecurityConfig(CustomAccessHandler custom_handler, CustomEntryPoint custom_entry_point) {
		super();
		this.custom_handler = custom_handler;
		this.custom_entry_point = custom_entry_point;
	}

	/* 
	 * Bcrypt bean 등록
	 */
    @Bean
    PasswordEncoder pwdEncoder() {
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
      		.usernameParameter("mem_user_id")
      		.passwordParameter("mem_passwd")
      		.loginProcessingUrl("/auth/login")
      		.defaultSuccessUrl("/index", true)
      		.failureUrl("/member/login")
      		.permitAll()
    		);
     
      
     return http.build();
     }
	
}
