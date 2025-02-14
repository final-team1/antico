package com.project.app.exception;

import lombok.Getter;

/*
 * 비즈니스 로직에서 발생되는 예외를 처리하기 위한 예외 클래스
 */
@Getter
public class BusinessException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	private ExceptionCode exceptionCode; // ENUM 예외 정의 필드
	
	public BusinessException(ExceptionCode exceptionCode) {
		super(exceptionCode.getMessage()); // 정의된 예외 메시지 지정
		this.exceptionCode = exceptionCode;
	}

}
