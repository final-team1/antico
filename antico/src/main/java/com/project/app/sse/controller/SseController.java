package com.project.app.sse.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.project.app.sse.service.SseService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * Server Send Event 알림 컨트롤러
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/sse/*")
public class SseController {
	
	private final SseService sseService;
	
	/*
	 * 알림 등록
	 */
	@GetMapping(value = "{pk_member_no}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> connectSSE(@PathVariable String pk_member_no) {
		log.info("connectSSE pk_member_no = " + pk_member_no);
		SseEmitter emitter = sseService.connectSSE(pk_member_no);
		return ResponseEntity.ok(emitter);
	}
	
	/*
	 * 알림 방송
	 */
	@PostMapping("broadcast")
	@ResponseBody
	public ResponseEntity<String> sendNotification(@RequestParam String pk_member_no, String eventName ,@RequestBody String message) {
		log.info("sendNotification pk_member_no = " + pk_member_no);
		sseService.sendNotification(pk_member_no, eventName, message);
		return ResponseEntity.ok("notification to " + pk_member_no);
	}
}
