package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.EmailDto;

@Repository("EmailDao")
public class EmailDaoImpl implements EmailDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void register(EmailDto emailDto) {
		sqlSession.insert("register", emailDto);
	}

	@Override
	public boolean check(EmailDto emailDto) {
		return sqlSession.selectOne("check", emailDto)==null?false:true;
	}

	@Override
	public void check_ok(EmailDto emailDto) {
		sqlSession.update("check_ok",emailDto);
	}

	@Override
	public void delete(EmailDto emailDto) {
		sqlSession.delete("delete",emailDto);
		
	}

}
