package com.project.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.app.member.domain.MemberVO;
import com.project.app.member.model.MemberDAO;
import com.project.app.security.CustomUserDetails;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@AllArgsConstructor
@Service
public class MemberDetailService implements UserDetailsService {

	@Autowired
	private MemberDAO member_dao;

	@Autowired
	private MemberVO member_vo;

	@Transactional
	@Override
	public UserDetails loadUserByUsername(String member_user_id) throws UsernameNotFoundException, AccountExpiredException {

		member_vo = member_dao.selectMemberByUserId(member_user_id);
		// TODO memberVO 유효성검사

		CustomUserDetails user_detail = new CustomUserDetails(member_vo);

		// 탈퇴신청을 한 회원인지 체크
		String leave_member_no = member_dao.leaveCheck(member_vo.getPk_member_no());

		if (leave_member_no != null) { // 탈퇴신청한 회원이 존재한다면

			String fk_member_no = member_dao.loginCheck(leave_member_no); // 로그인시 탈퇴신청 후 72시간이 지난 회원이 있는지 조회

			log.warn("탈퇴신청을 했지만 72시간이 지났는지 조회" + fk_member_no);

			if (fk_member_no == null) { // 탈퇴는 했지만 72시간이 지나지 않은 회원이 로그인을 했다면

				member_dao.leaveDelete(leave_member_no); // 탈퇴테이블에서 값을 지우기

				member_dao.rollback(leave_member_no); // 상태를 다시 돌려놓기
			} else { // 탈퇴를 했으면서 72시간이 지난 회원이 로그인을 했더라면
				throw new AccountExpiredException("탈퇴&nbsp;후&nbsp;72시간이&nbsp;지나&nbsp;로그인이&nbsp;불가능합니다.");
			}
		}
		return User.withUserDetails(user_detail).build();
	}

	/*   public static UserBuilder withUserDetails(UserDetails userDetails) {
      // @formatter:off
      return withUsername(userDetails.getUsername())
            .password(userDetails.getPassword())
            .accountExpired(!userDetails.isAccountNonExpired())
            .accountLocked(!userDetails.isAccountNonLocked())
            .authorities(userDetails.getAuthorities())
            .credentialsExpired(!userDetails.isCredentialsNonExpired())
            .disabled(!userDetails.isEnabled());
      // @formatter:on
   }*/

}

/*
 * 
 * return new CustomUserDetails(mvo.getPk_member_no(), mvo.getMember_passwd() ,
 * mvo.getMember_user_id() ,mvo.getMember_regdate(),mvo.getMember_tel(),
 * mvo.getMember_passwd_change_date() ,mvo.getMember_role(),
 * mvo.getMember_point(), mvo.getMember_score() ,mvo.getMember_status())
 * 
 */