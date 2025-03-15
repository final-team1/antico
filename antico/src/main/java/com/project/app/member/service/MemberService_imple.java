package com.project.app.member.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * MemberService 구현체
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class MemberService_imple implements MemberService {
	
	private final MemberDAO member_dao;
	
	private final MemberVO member_vo;
	
	private final PasswordEncoder pwd_encoder;
    
	
	@Override
	public int registerMember(MemberVO member_vo) {
		
		if(member_vo.getMember_passwd() == null) {
			return member_dao.registerMember(member_vo);
		}else {
			member_vo.setMember_passwd(pwd_encoder.encode(member_vo.getMember_passwd()));
		}
		
		return member_dao.registerMember(member_vo);
	}

	
	@Override
	@Transactional(readOnly = true)
	public MemberVO getMember(String member_user_id) {
		return member_dao.selectMemberByUserId(member_user_id);
	}


	@Override
	public void google_tel_add(String member_tel) {
		
		member_dao.google_tel_add(member_tel);
	}

	@Override
	public MemberVO getMemberByMemberNo (String pk_member_no) {
		return member_dao.selectMemberByMemberNo(pk_member_no);
	}

	@Override
	public void updateScore(String fk_seller_no, int score) {
		member_dao.updateScore(fk_seller_no, score);
	}

}
