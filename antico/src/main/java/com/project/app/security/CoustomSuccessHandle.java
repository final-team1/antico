package com.project.app.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.mypage.domain.LoginHistoryVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CoustomSuccessHandle implements AuthenticationSuccessHandler {

	private final MemberDAO member_dao;
	
	private final GetMemberDetail get_member_detail;
	
	private final OAuth2AuthorizedClientService authorizedClientService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		
		String user_id = "";
		
		String img_name = "";
		
		// 일반 및 카카오 로그인 성공시
		user_id = authentication.getName();

		// 네이버 로그인 성공시
		if(authentication.getName().startsWith("{id=")) {
			user_id = authentication.getName().split(",")[0];
			
			user_id = user_id.substring(4);
			
			img_name = String.valueOf(authentication.getPrincipal()).split(",")[2];
			
			img_name = img_name.substring(15);
			
			
		}else if(String.valueOf(authentication.getPrincipal()).startsWith("Name:")){
			user_id = authentication.getName().split(",")[0];
			
			user_id = user_id.substring(5);
			
			img_name = String.valueOf(authentication.getPrincipal()).split(",")[6];
			
			img_name = img_name.substring(9);

		}
		
		MemberVO member_vo = get_member_detail.MemberDetail();
		
		if(member_vo.getMember_oauth_type() != null) {
			
			OAuth2AuthenticationToken oAuth2AuthenticationToken = (OAuth2AuthenticationToken) authentication;
			
			OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(
                    oAuth2AuthenticationToken.getAuthorizedClientRegistrationId(),
                    oAuth2AuthenticationToken.getName()
                    );
	        session.setAttribute("access_token", authorizedClient.getAccessToken().getTokenValue());
		}
		
		if(member_vo.getMember_status().equals("2")) {
			session.setAttribute("member_status", member_vo.getMember_status());
		}
		
		member_vo.setMember_img_name(img_name);
		
		LoginHistoryVO login_history_vo = new LoginHistoryVO();
		
		login_history_vo.setFk_member_no(member_vo.getPk_member_no());
		
		login_history_vo.setLogin_history_user_ip(request.getRemoteAddr());
		
		member_dao.loginHistoryByLoginHistoryVo(login_history_vo);
		
		response.sendRedirect(request.getContextPath()+"/index");	
	}

}
