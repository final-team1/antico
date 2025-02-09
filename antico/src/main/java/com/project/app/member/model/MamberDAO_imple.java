package com.project.app.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.app.member.domain.MemberVO;

@Repository
public class MamberDAO_imple implements MemberDAO {

	
	@Autowired
	SqlSessionTemplate sqlsession;
	
	
	@Override
	public int registerMember(MemberVO mvo) {
		
		int n = sqlsession.insert("member.registerMember", mvo);
		
		return n;
	}


	@Override
	public MemberVO selectMemberByUserId(String mem_user_id) {
		
		
		
		return sqlsession.selectOne("member.selectMemberByUserId", mem_user_id);
	}
	
	
	
}
