package com.project.app.mypage.service;

import com.project.app.mypage.domain.LeaveVO;

public interface MypageService {
    // 탈퇴 신청 로직
    int deletesubmit(LeaveVO lvo);

    // 로그인 시 탈퇴 신청 확인 및 취소 로직
    int cancelLeaveRequest(int memberNo);
}
