package com.project.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	private final String[] permittedUrls = {"/**"};


    @Bean
    PasswordEncoder pwdEncoder() {
		
		return new BCryptPasswordEncoder();
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
