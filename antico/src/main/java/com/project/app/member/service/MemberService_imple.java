package com.project.app.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.component.GetMemberDetail;
import com.project.app.member.domain.KakaoUserInfoResponseVO;
import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

/*
 * MemberService 구현체
 */
@Service
public class MemberService_imple implements MemberService {
	
	@Autowired
	private MemberDAO member_dao;
	
	@Autowired
	private PasswordEncoder pwd_encoder;
	
	@Autowired
	private MemberVO member_vo;
	
	
	@Override
	public int registerMember(MemberVO mvo) {
		mvo.setMember_passwd(pwd_encoder.encode(mvo.getMember_passwd()));
		
		return member_dao.registerMember(mvo);
	}

	
	@Override
	@Transactional(readOnly = true)
	public MemberVO getMember(String pk_member_no) {
		return member_dao.selectMemberByMemberNo(pk_member_no);
	}


	// 카카오로그인 정보의 아이디와 회원가입되어있는 회원의 아이티를 비교하여 회언가입이 되어있는지 체크와 동시에 회원의 정보를 가져온다.
	@Override
	public MemberVO kakaoRegistCheckByUserId(KakaoUserInfoResponseVO user_info) {
        
        String member_user_id = String.valueOf(user_info.getId());
		
        int n = member_dao.kakaoRegistCheckByUserId(member_user_id);
		
		if(n != 0) {
			
			MemberVO kakao_member_vo = new MemberVO();
			
			kakao_member_vo.setMember_user_id(String.valueOf(user_info.getId()));
			
			kakao_member_vo.setMember_tel(user_info.getKakaoAccount().getPhoneNumber());
			
			kakao_member_vo.setMember_name(user_info.getKakaoAccount().getName());
			
			kakao_member_vo.setMember_passwd(pwd_encoder.encode("kakao"));
			
			member_dao.registerMemberKakao(kakao_member_vo);
			
			return kakao_member_vo;
			
		}else{
			
			member_vo = member_dao.selectMemberByUserId(member_user_id);
			
		}
				
		return member_vo;
	}


	
	

}
