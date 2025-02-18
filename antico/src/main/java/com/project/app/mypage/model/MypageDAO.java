package com.project.app.mypage.model;

import org.apache.ibatis.annotations.Mapper;
import com.project.app.mypage.domain.LeaveVO;

@Mapper
public interface MypageDAO {
    // 탈퇴 신청 삽입
    int insertLeaveRequest(LeaveVO lvo);

    // 회원번호로 탈퇴 신청 조회
    LeaveVO getLeaveRequestByMemberNo(int memberNo);

    // 탈퇴 신청 삭제
    int deleteLeaveRequest(int memberNo);
}
