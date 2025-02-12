package com.project.app.mypage.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO_imple implements MypageDAO {

	
	@Autowired
	SqlSessionTemplate sqlsession;
}
