package project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.FriendDto;

@Repository("FriendDao")
public class FriendDaoImpl implements FriendDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void follow(FriendDto friendDto) {
		sqlSession.insert("follow", friendDto);
	}

	@Override
	public void unfollow(FriendDto friendDto) {
		sqlSession.delete("unfollow", friendDto);
	}

	@Override
	public List<String> follow_list(String id) {
		return sqlSession.selectList("follow_list", id);
	}

	@Override
	public List<String> follower_list(String id) {
		return sqlSession.selectList("follower_list", id);
	}

	@Override
	public int follow_cnt(String id) {
		return sqlSession.selectOne("follow_cnt",id);
	}

	@Override
	public int follower_cnt(String id) {
		return sqlSession.selectOne("follower_cnt",id);
	}

	@Override
	public boolean search(FriendDto friendDto) {
		return sqlSession.selectOne("search",friendDto)==null?false:true;
	}

	@Override
	public List<String> follow_list_search(String follower, String type, String keyword) {
//		Object[] args = {follower, name};
		Map<String, String> map = new HashMap<>();
		map.put("follower", follower);
		map.put("keyword", keyword);
		if(type.equals("name"))
			return sqlSession.selectList("follow_list_search_name", map);
		else
			return sqlSession.selectList("follow_list_search_nick", map);
	}
	
	@Override
	public List<String> follower_list_search(String follow, String type, String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("follow", follow);
		map.put("keyword", keyword);
		if(type.equals("name"))
			return sqlSession.selectList("follower_list_search_name", map);
		else
			return sqlSession.selectList("follower_list_search_nick", map);
	}
}
