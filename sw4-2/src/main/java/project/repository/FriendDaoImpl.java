package project.repository;

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
	
}
