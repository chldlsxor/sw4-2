package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.MemberDto;
import project.bean.PageDto;

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
	public void exit(String id) {
		sqlSession.delete("exit", id);
	}
	
	@Override
	public void reset_pw(MemberDto memberDto) {
		sqlSession.update("reset_pw",memberDto);
	}

	@Override
	public MemberDto get(String id) {
		return sqlSession.selectOne("member_get", id);
	}

	@Override
	public MemberDto get_by_nick(String nick) {
		return sqlSession.selectOne("member_get_by_nick", nick);
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

	@Override
	public boolean select_id(String id) {
		return sqlSession.selectOne("select_id", id)==null?false:true;
	}

	@Override
	public void edit(MemberDto memberDto) {
		sqlSession.update("edit",memberDto);
	}

	@Override
	public boolean select_nick(String nick) {
		return sqlSession.selectOne("select_nick", nick)==null?false:true;
	}

	@Override
	public List<MemberDto> name_search(String name) {
		return sqlSession.selectList("name_search", name);
	}
	
	@Override
	public List<MemberDto> nick_search(String nick) {
		return sqlSession.selectList("nick_search", nick);
	}

	@Override
	public List<MemberDto> member_page_list(PageDto pageDto) {
		return sqlSession.selectList("member_page_list", pageDto);
	}

	@Override
	public List<MemberDto> member_page_search(PageDto pageDto) {
		return sqlSession.selectList("member_page_search", pageDto);
	}
	
	@Override
	public int member_get_count() {
		return sqlSession.selectOne("member_get_count");
	}

	@Override
	public int member_get_count_by_search(PageDto pageDto) {
		return sqlSession.selectOne("member_get_count_by_search", pageDto);
	}

	

	

	

	
}
