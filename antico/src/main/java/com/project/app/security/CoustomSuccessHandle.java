package com.project.app.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		
		String user_id = "";
		
		// 일반 및 카카오 로그인 성공시
		user_id = authentication.getName();

		// 네이버 로그인 성공시
		if(authentication.getName().startsWith("{id=")) {
			user_id = authentication.getName().split(",")[0];
			
			user_id = user_id.substring(4);
		}else if(authentication.getName().startsWith("{sub=")){
			user_id = authentication.getName().split(",")[0];
			
			user_id = user_id.substring(5);
		}
		
		MemberVO member_vo = get_member_detail.MemberDetail();
		
		if(member_vo.getMember_oauth_type() != null) {
	        String access_token = String.valueOf(authentication.getPrincipal());

	        session.setAttribute("access_token", access_token);
		}
		
		LoginHistoryVO login_history_vo = new LoginHistoryVO();
		
		login_history_vo.setFk_member_no(member_vo.getPk_member_no());
		
		login_history_vo.setLogin_history_user_ip(request.getRemoteAddr());
		
		member_dao.loginHistoryByLoginHistoryVo(login_history_vo);
		
		response.sendRedirect(request.getContextPath()+"/index");	
	}

}
