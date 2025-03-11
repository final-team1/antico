package com.project.app.chat.domain;

<<<<<<< HEAD
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
=======
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
public class Participant {

	private String memberNo; // 사용자 일련번호
	
	private String memberName; // 사용자 이름
<<<<<<< HEAD
	
	private String lastReadChatId; // 마지막으로 읽은 메시지 식별자
=======
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)

	// Participant 생성 정적 팩토리 메소드
	public static Participant createParticipant(String memberNo, String memberName) {
		return Participant.builder()
				.memberNo(memberNo)
				.memberName(memberName)
				.build();
	}
<<<<<<< HEAD
	
	// Participant 생성 정적 팩토리 메소드
	public static Participant createParticipant(String memberNo, String memberName, String lastReadChatId) {
		return Participant.builder()
				.memberNo(memberNo)
				.memberName(memberName)
				.lastReadChatId(lastReadChatId)
				.build();
=======

	@Override
	public boolean equals(Object o) {
		if(this == o) return true; // 현재 객체와 주소값이 동일한 객체인지 확인
		if(o == null || getClass() != o.getClass()) return false; // 현재 클래스와 다른 클래스인지 확인
		Participant participant = (Participant) o;
		return Objects.equals(memberNo, participant.memberNo); // 회원 번호를 기준으로 비교
	}

	@Override
	public int hashCode() {
		// eqauls 비교 구문에는 hashCode를 기준으로 비교하기에 회원번호를 기준으로 해시값 생성
		return Objects.hash(memberNo);
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
	}
	
}
