package com.project.app.member.service;

import java.util.Map;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.project.app.component.oauth2member.GoogleUser;
import com.project.app.component.oauth2member.KakaoUser;
import com.project.app.component.oauth2member.NaverUser;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.security.CustomUserDetails;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RequiredArgsConstructor
@Slf4j
@Service
public class AuthCustomDetailService extends DefaultOAuth2UserService{
	
	private final KakaoUser kakao_user;
	
	private final NaverUser naver_user;
	
	private final GoogleUser google_user;
	
	private final MemberDAO member_dao;
	
	private final MemberVO member_vo;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
        
        MemberVO extra_member_vo = new MemberVO();
        
        Map<String, Object> user_info = oAuth2User.getAttributes();
        
        Map<String, Object> kakao_account = (Map<String,Object>)user_info.get("kakao_account");
        
        Map<String, Object> attributes = oAuth2User.getAttributes();
        
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        
        Map<String, Object> google_info = oAuth2User.getAttributes();
        
        String name_attribute_key = "";
        
        if("kakao".equals(userRequest.getClientRegistration().getRegistrationId())){
        	extra_member_vo = kakao_user.oauth2User(oAuth2User);
        	
        	if(member_dao.selectMemberByUserId(String.valueOf(user_info.get("id"))) == null) {
        		member_dao.registerMember(extra_member_vo);
        	}
        	name_attribute_key = "id";
        	extra_member_vo = member_dao.selectMemberByUserId(String.valueOf(user_info.get("id")));
        	
        }else if("naver".equals(userRequest.getClientRegistration().getRegistrationId())){
        	extra_member_vo  = naver_user.oauth2User(oAuth2User);
        	
        	if(member_dao.selectMemberByUserId(String.valueOf(response.get("id"))) == null) {
        		
        		member_dao.registerMember(extra_member_vo);
        		
        	}
        	
        	name_attribute_key = "response";
        	extra_member_vo = member_dao.selectMemberByUserId(String.valueOf(response.get("id")));
        	
        }else if("google".equals(userRequest.getClientRegistration().getRegistrationId())){
        	
        	extra_member_vo = google_user.oauth2User(oAuth2User);
        	
        	if(member_dao.selectMemberByUserId(String.valueOf(google_info.get("sub"))) == null) {
        		
        		member_dao.registerMember(extra_member_vo);
        		
        	}
        	
        	extra_member_vo.setMember_tel(userRequest.getAccessToken().getTokenValue());
        	extra_member_vo = member_dao.selectMemberByUserId(String.valueOf(google_info.get("sub")));
        	name_attribute_key = "sub";
        }
        
        member_vo.setMember_role(extra_member_vo.getMember_role());
        member_vo.setMember_oauth_type(extra_member_vo.getMember_oauth_type());
        
        String leave_member_no = member_dao.leaveCheck(extra_member_vo.getPk_member_no());

		if (leave_member_no != null) { // 탈퇴신청한 회원이 존재한다면

			String fk_member_no = member_dao.loginCheck(leave_member_no); // 로그인시 탈퇴신청 후 72시간이 지난 회원이 있는지 조회

			log.warn("탈퇴신청을 했지만 72시간이 지났는지 조회" + fk_member_no);

			if (fk_member_no == null) { // 탈퇴는 했지만 72시간이 지나지 않은 회원이 로그인을 했다면

				member_dao.leaveDelete(leave_member_no); // 탈퇴테이블에서 값을 지우기

				member_dao.rollback(leave_member_no); // 상태를 다시 돌려놓기
			} else { // 탈퇴를 했으면서 72시간이 지난 회원이 로그인을 했더라면
				throw new AccountExpiredException("탈퇴&nbsp;후&nbsp;72시간이&nbsp;지나&nbsp;로그인이&nbsp;불가능합니다.");
			}
		}
        
        CustomUserDetails user_detail = new CustomUserDetails(member_vo);
        
        return new DefaultOAuth2User(user_detail.getAuthorities(), oAuth2User.getAttributes(), name_attribute_key);
	}

}