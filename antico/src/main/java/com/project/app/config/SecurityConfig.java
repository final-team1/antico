package com.project.app.config;

import java.io.UnsupportedEncodingException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.project.app.common.AES256;
import com.project.app.common.Constants;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	private final String[] permittedUrls = {"/**"};

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
              
              .requestMatchers(permittedUrls).permitAll()
              .anyRequest().authenticated()
      )
      .csrf(AbstractHttpConfigurer::disable)
      .formLogin((formLogin) ->
      		formLogin
      			.loginPage("/member/login")
      			.usernameParameter("mem_user_id")
      			.passwordParameter("mem_passwd")
      			.loginProcessingUrl("/auth/login")
      			.defaultSuccessUrl("/index", true)
      			.permitAll()
    		  );
     
      
     return http.build();
     }
	
}
