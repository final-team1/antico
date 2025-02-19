package com.project.app.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.app.mypage.domain.LeaveVO;
import com.project.app.mypage.model.MypageDAO;

@Service
public class MypageService_imple implements MypageService {

    @Autowired
    private MypageDAO mypagedao;

    // 회원 탈퇴 신청 처리
    @Override
    public int deletesubmit(LeaveVO lvo) {
        return mypagedao.insertLeaveRequest(lvo);
    }

    // 로그인 시 탈퇴 신청 확인 및 취소 로직
    @Override
    public int cancelLeaveRequest(int memberNo) {
        // 72시간이 지나지 않은 탈퇴 신청이 있는지 확인
        LeaveVO leaveRequest = mypagedao.getLeaveRequestByMemberNo(memberNo);

        if (leaveRequest != null) {
            // 탈퇴 신청 취소 (레코드 삭제)
            return mypagedao.deleteLeaveRequest(memberNo);
        }

        return 0; // 취소할 탈퇴 신청이 없음
    }
}
