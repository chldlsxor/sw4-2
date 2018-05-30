package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.MemberDto;

@Repository("MemberDao")
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSession slqSession;

	@Override
	public void register(MemberDto memberDto) {
		slqSession.insert("register", memberDto);
	}
	
}
