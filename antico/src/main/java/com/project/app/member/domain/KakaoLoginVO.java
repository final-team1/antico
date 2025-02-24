package com.project.app.member.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@AllArgsConstructor
@Builder
@Getter
public class KakaoLoginVO {
	
    public String accessToken;
    public String refreshToken;
	
}
