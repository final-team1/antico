package com.project.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;

@Configuration
public class OauthConfig {
	
	@Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        ClientRegistration kakaoRegistration = ClientRegistration.withRegistrationId("kakao")
            .clientId("2fc45348c1f277afbb09c75d902df014")
            .clientSecret("Pd7oRChK002kd9Vm64ejNDEtiXBlwZr1")
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri("http://localhost:8080/antico/kakaologin/callback")
            .scope("profile_nickname", "account_email")
            .authorizationUri("https://kauth.kakao.com/oauth/authorize")
            .tokenUri("https://kauth.kakao.com/oauth/token")
            .userInfoUri("https://kapi.kakao.com/v2/user/me")
            .userNameAttributeName("id")
            .build();

        return new InMemoryClientRegistrationRepository(kakaoRegistration);
    }
	
}
