package com.project.app.exception;

import lombok.Getter;

/*
 * 구체적인 예외 정보들을 정의하기 위한 ENUM 클래스
 */
@Getter
public enum ExceptionCode {
	
	TRADE_NOT_FOUND(404, "거래내역을 찾을 수 없습니다."), // 조회한 TRADE VO가 NULL인 경우
	
	REVIEW_NOT_FOUND(404, "후기내역을 찾을 수 없습니다."), // 조회한 REVIEW VO가 NULL인 경우
	
	REVIEW_AREADY_EXISTS(400, "이미 작성된 후기입니다."), // 동일한 거래에서 중복되는 후기를 작성하려는 경우
	
	BLACKLIST_AREADY_EXISTS(400, "이미 차단한 회원입니다."); // 이미 차단한 회원을 차단하려는 경우

	private final int status;
	
	private final String message;
	
	ExceptionCode(int status, String message) {
		this.status = status;
		this.message = message;
	}

}
