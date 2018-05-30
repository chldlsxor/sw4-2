package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ReplyDao")
public class ReplyDaoImpl implements ReplyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
}
