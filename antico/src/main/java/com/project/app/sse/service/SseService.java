package com.project.app.sse.service;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.extern.slf4j.Slf4j;
/*
 사용자 알람을 위한 SSE 서비스
 */
@Slf4j
@Service
public class SseService {

	// SSE 객체를 저장하는 동시성 제어 HashMap
	private final ConcurrentHashMap<String, SseEmitter> sseEmitters = new ConcurrentHashMap<>();

	/*
	  사용자 SSE 연결 메소드 
	 */
	public SseEmitter connectSSE(String pk_member_no) {
		SseEmitter emitter = new SseEmitter(300_000L); // SSE 1분 유지
		sseEmitters.put(pk_member_no, emitter);

		emitter.onCompletion(() -> sseEmitters.remove(pk_member_no)); // SSE 종료 시 자원 해제
		emitter.onTimeout(() -> sseEmitters.remove(pk_member_no)); // SSE 연결 시간 종료 시 자원 해제
		return emitter;
	}

	/*
		사용자 SSE 알림 발송 메소드
	 */
	public void sendNotification(String pk_member_no, String eventName, String message) {
		SseEmitter emitter = sseEmitters.get(pk_member_no); // 사용자에게 배정된 SSE 객체 조회
		if (emitter != null) {
			try {
				emitter.send(SseEmitter.event().name(eventName).data(message));
			} catch (IOException e) {
				log.error(e.getMessage());
				sseEmitters.remove(pk_member_no);
			}
		}
	}
}
