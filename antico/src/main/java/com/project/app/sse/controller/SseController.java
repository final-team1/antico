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
	@GetMapping(value = "{member_user_id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> connectSSE(@PathVariable String member_user_id) {
		SseEmitter emitter = sseService.connectSSE(member_user_id);
		return ResponseEntity.ok(emitter);
	}
	
	/*
	 * 알림 방송
	 */
	@PostMapping("broadcast")
	@ResponseBody
	public ResponseEntity<String> sendNotification(@RequestParam String member_user_id, String eventName ,@RequestBody String message) {
		sseService.sendNotification(member_user_id, eventName, message);
		return ResponseEntity.ok("notification to " + member_user_id);
	}
}
