package com.project.app.component;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

/*
 * 컨트롤러 전역 예외 처리
 */
@ControllerAdvice
public class CustomControllerAdvice {
	
	// TODO 상태코드를 지정해야 하는지에 대한 논의 필요
	
	/*
	 * 호출자가 파라미터로 부적절한 값을 넘길 때 던지는 예외
	 */
	@ExceptionHandler(IllegalArgumentException.class)
    public Object handleIllegalArgumentException(IllegalArgumentException e, HttpServletRequest request) {
		return handleExceptionResponse(e, request);
    }
	
	/*
	 * 요청되는 요소가 존재하지 않을 때 던지는 예외
	 */
	@ExceptionHandler(NoSuchElementException.class)
    public Object handleNoSuchElementException(NoSuchElementException e, HttpServletRequest request) {
		return handleExceptionResponse(e, request);
    }
	
	/*
	 * ResponseEntity
	 */
	private Object handleExceptionResponse(Exception e, HttpServletRequest request) {
		String msg = e.getMessage(); // 사용자 전달 에러 메시지
		// TODO log로 변경하기
		e.printStackTrace();
		
		Enumeration<String> headerNames = request.getHeaderNames();

	    // 헤더 이름을 순회하며 값 출력
	    while (headerNames.hasMoreElements()) {
	        String headerName = headerNames.nextElement();
	        String headerValue = request.getHeader(headerName);
	        
	        // 헤더 이름과 값을 출력
	        System.out.println(headerName + ": " + headerValue);
	    }
		
		// ajax 요청인 경우 map 반환
		if("XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
			Map<String, String> map = new HashMap<>();
			map.put("msg", msg);
			return new ResponseEntity<>(map, HttpStatus.BAD_REQUEST);
		}
		// 폼 요청인 경우 및 서버 에러인 경우 에러페이지 이동
		else {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("error");
			return mav;
		}
	}

}
