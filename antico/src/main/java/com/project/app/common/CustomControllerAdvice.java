package com.project.app.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/*
 * 컨트롤러 전역 예외 처리
 */
@ControllerAdvice
public class CustomControllerAdvice {
	
	/*
	 * 호출자가 파라미터로 부적절한 값을 넘길 때 던지는 예외
	 */
	@ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Map<String, String>> handleIllegalArgumentException(IllegalArgumentException e) {
		Map<String, String> map = new HashMap<>();
		map.put("msg", e.getMessage());
		return new ResponseEntity<>(map, HttpStatus.BAD_REQUEST);
    }

}
