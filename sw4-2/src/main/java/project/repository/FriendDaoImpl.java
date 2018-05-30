package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("FriendDao")
public class FriendDaoImpl implements FriendDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
