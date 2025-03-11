package com.project.app.chat.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class Participant {

	private String memberNo; // 사용자 일련번호
	
	private String memberName; // 사용자 이름
	
	private String lastReadChatId; // 마지막으로 읽은 메시지 식별자

	// Participant 생성 정적 팩토리 메소드
	public static Participant createParticipant(String memberNo, String memberName) {
		return Participant.builder()
				.memberNo(memberNo)
				.memberName(memberName)
				.build();
	}
	
	// Participant 생성 정적 팩토리 메소드
	public static Participant createParticipant(String memberNo, String memberName, String lastReadChatId) {
		return Participant.builder()
				.memberNo(memberNo)
				.memberName(memberName)
				.lastReadChatId(lastReadChatId)
				.build();
	}
	
}
