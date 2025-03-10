package com.project.app.member.model;

import org.apache.ibatis.annotations.Mapper;

import com.project.app.member.domain.MemberVO;
import com.project.app.mypage.domain.LoginHistoryVO;

@Mapper
public interface MemberDAO {

	int registerMember(MemberVO mvo);

	MemberVO selectMemberByUserId(String member_user_id);

	// memberNo를 통한 단일 사용자 조회
	MemberVO selectMemberByMemberNo(String memberNo);

	// 탈퇴신청을 한 회원인지 체크
	String leaveCheck(String pk_member_no);

	// 로그인시 탈퇴신청 후 72시간이 지난 회원이 있는지 조회
	String loginCheck(String member_user_id);

	// 탈퇴신청은 했지만 72시간이 지나지 않은 회원이 로그인한 경우
	void leaveDelete(String leave_member_no);

	// 카카오로그인 정보의 아이디와 회원가입되어있는 회원의 아이티를 비교하여 회언가입이 되어있는지 체크와 동시에 회원의 정보를 가져온다.
	int kakaoRegistCheckByUserId(String member_user_id);

	// 구매를 하면 포인트를 차감 update, 상품상태를 예약중으로 변경 update, 포인트내역 insert, 거래 insert
	int purchase(String pk_product_no, String member_no);

	// google oauth로그인시 전화번호만 따로 추가시키는 메소드
	void google_tel_add(String member_tel);

	// 로그인시 로그인 기록을 남기는 메소드
	void loginHistoryByLoginHistoryVo(LoginHistoryVO login_history_vo);
	
	 // 탈퇴신청은 했지만 72시간 이내에 접속한 경우
	void rollback(String leave_member_no);



}
