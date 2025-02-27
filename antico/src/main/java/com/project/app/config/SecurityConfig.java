package com.project.app.config;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.project.app.common.AES256;
import com.project.app.common.Constants;
import com.project.app.member.service.KAuthCustomUserInfoService;
import com.project.app.security.CustomAccessHandler;
import com.project.app.security.CustomEntryPoint;
import com.project.app.security.LoginFailureHandler;
import com.project.app.security.OauthFailer;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	
	
	private final CustomAccessHandler custom_handler;
	
	
	private final CustomEntryPoint custom_entry_point;
	
	
	private final LoginFailureHandler login_failure_handler;
	
	
	private final KAuthCustomUserInfoService kauth_custom_user_info;
	
	
	private final OAuth2AuthorizedClientRepository client_registration_repository;
	
	
    private final OauthFailer oauth_failer;
    
    
    private final OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService;
	

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
	

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
    	  .requestMatchers("/chat/**").authenticated()
    	  
    	  .requestMatchers("/product/**").authenticated()
    	  
    	  .requestMatchers("/mypage/**").authenticated()
    	  
          .requestMatchers("/kakaologin/**").permitAll()
          
          .requestMatchers("/**").permitAll()
             
          .anyRequest().authenticated()
    )
    .exceptionHandling(ex -> ex
    	 .accessDeniedHandler(custom_handler)
    	 .authenticationEntryPoint(custom_entry_point)
    	 )
    .oauth2Login(oauth2Configurer -> oauth2Configurer
            .loginPage("/member/login")
            .authorizedClientRepository(client_registration_repository)
            .userInfoEndpoint(userInfo -> userInfo
                    .userService(oAuth2UserService))
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
     )
     
     .logout(logout -> logout
    		 .logoutUrl("/logout")
    		 .logoutSuccessUrl("/index")
    		 .clearAuthentication(true)
    		 );
    
     return http.build();
     }

	
	
}
