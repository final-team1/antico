package com.project.app.member.model;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.member.domain.MemberVO;

@Mapper
public interface MemberDAO {

	int registerMember(MemberVO mvo);

	MemberVO selectMemberByUserId(String member_user_id);

	// memberNo를 통한 단일 사용자 조회
	MemberVO selectMemberByMemberNo(String memberNo);

	// 탈퇴신청을 한 회원인지 체크
	String leaveCheck(String member_user_id);

	// 로그인시 탈퇴신청 후 72시간이 지난 회원이 있는지 조회
	String loginCheck(String member_user_id);

	// 72시간이 지난 회원이 로그인을 할 때 회원상태 업데이트
	void statusUpdate(String fk_member_no);

	// 탈퇴신청은 했지만 72시간이 지나지 않은 회원이 로그인한 경우
	void leaveDelete(String leave_member_no);

	// 카카오로그인 정보의 아이디와 회원가입되어있는 회원의 아이티를 비교하여 회언가입이 되어있는지 체크와 동시에 회원의 정보를 가져온다.
	int kakaoRegistCheckByUserId(String member_user_id);
	
	// 카카오 정보로 회원가입하는 메소드
	int registerMemberKakao(MemberVO membervo);

}
