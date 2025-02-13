package com.project.app.component;

import java.util.NoSuchElementException;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.service.MemberService;

@Aspect
@Component
public class MemberValidationAspect {
	
	@Autowired
	private MemberService memberService;
	
	/*
	 * 사용자 일련번호 유효성 검사 AOP
	 */
	@Before("@annotation(com.project.app.component.annotation.MemberNoValidation)")
	public void memberNoValid(JoinPoint joinPoint) throws Exception {
		// 사용자 일련번호
		String memberNo = (String) joinPoint.getArgs()[0];
		
		// 숫자 문자열인지 검사
		if(!StringUtils.isNumeric(memberNo)) {
			throw new IllegalArgumentException("[ERROR] : 유효한 회원 일련번호가 아닙니다.");
		}
		
		MemberVO memberVO = memberService.getMember(memberNo);
			
		// MemberVO가 유효성 검사
		if(memberVO == null) {
			throw new NoSuchElementException("[ERROR] : 회원 일련번호 " + memberNo + " 에 해당하는 회원을 찾을 수 없습니다.");
		}

		// MemberVO가 유효하다면 기존 비즈니스 로직 진행
	}

}
