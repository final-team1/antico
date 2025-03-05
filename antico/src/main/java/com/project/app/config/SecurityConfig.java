package com.project.app.config;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.project.app.common.AES256;
import com.project.app.common.Constants;
import com.project.app.member.service.AuthCustomDetailService;
import com.project.app.security.CoustomSuccessHandle;
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
	
	
    private final OauthFailer oauth_failer;
    
    
    private final DefaultOAuth2UserService oAuth2UserService;
    
    
    private final CoustomSuccessHandle costom_oauth_success;

	@Bean
    PasswordEncoder pwd_encoder() {
		return new BCryptPasswordEncoder();
	}
    
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
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
		
		.requestMatchers("/notice/notice_list").authenticated()
		
		.requestMatchers("/review/**").permitAll()
		
		.requestMatchers("/admin/**").hasAnyRole("ADMIN_1","ADMIN_2")
          
        .requestMatchers("/**").permitAll()
          
        .requestMatchers("/login/oauth2/**").permitAll()
          
        .requestMatchers("/oauth2/**").permitAll()
             
    )
    .exceptionHandling(ex -> ex
    	 .accessDeniedHandler(custom_handler)
    	 .authenticationEntryPoint(custom_entry_point)
    	 )
    .cors(httpSecurityCorsConfigurer -> httpSecurityCorsConfigurer.configurationSource(configurationSource()))
    .oauth2Login(oauth2Configurer -> oauth2Configurer
    		.redirectionEndpoint( redirect -> redirect
    				.baseUri("/login/oauth2/code/**")
    		)
            .failureHandler(oauth_failer)
            .successHandler(costom_oauth_success)
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
	      	.successHandler(costom_oauth_success)
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

    public CorsConfigurationSource configurationSource(){
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");
        config.setAllowedMethods(List.of("GET","POST","DELETE"));
        source.registerCorsConfiguration("/**",config);
        return source;
    }

	
}
