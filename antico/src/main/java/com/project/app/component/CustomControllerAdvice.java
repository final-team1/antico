package com.project.app.component;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.exception.BusinessException;
import com.project.app.exception.S3Exception;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * 컨트롤러 전역 예외 처리
 */
@ControllerAdvice
public class CustomControllerAdvice {

	/*
	 * 비즈니스 로직에서 발생한 예외 처리
	 */
	@ExceptionHandler(BusinessException.class)
	public Object handleBusinessException(BusinessException e, HttpServletRequest request) {
		e.printStackTrace();

		// ajax 요청인 경우 지정된 예외 정보를 반환
		if ("XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
			return ResponseEntity.status(e.getExceptionCode().getStatus()).body("msg/" + e.getMessage());
		}

		// 폼 요청인 경우 에러페이지 이동
		else {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("error");
			return mav;
		}
	}
	
	/*
	 * S3 업로드 및 파일 I/O 작업에 대한 예외
	 */
	@ExceptionHandler(S3Exception.class)
	public Object handleS3Exception(S3Exception e, HttpServletRequest request, HttpServletResponse response) {
		e.printStackTrace();
		
		// ajax 요청인 경우 지정된 예외 정보를 반환
		if ("XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
			return ResponseEntity.status(e.getExceptionCode().getStatus()).body("msg/");
		}

		// 폼 요청인 경우 에러페이지 이동
		else {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("error");
			return mav;
		}
	}

	/*
	 * ResponseEntity
	 */
	private Object handleExceptionResponse(Exception e, HttpServletRequest request) {
		String msg = e.getMessage(); // 사용자 전달 에러 메시지
		// TODO log로 변경하기
		e.printStackTrace();

		// ajax 요청인 경우 map 반환
		if ("XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
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
