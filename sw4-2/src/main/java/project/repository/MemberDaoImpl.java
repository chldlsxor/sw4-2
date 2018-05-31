package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.MemberDto;

@Repository("MemberDao")
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void register(MemberDto memberDto) {
		sqlSession.insert("register", memberDto);
	}

	@Override
	public boolean login(MemberDto memberDto) {
		return sqlSession.selectOne("login", memberDto)==null?false:true;
	}


	@Override
	public String reset_pw(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDto get(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSalt(String id) {
		return sqlSession.selectOne("get_salt", id);
	}

	@Override
	public int getLoop(String id) {
		return sqlSession.selectOne("get_loop", id);
	}

	@Override
	public List<MemberDto> member_list() {
		return sqlSession.selectList("member_list");
	}
	
}
