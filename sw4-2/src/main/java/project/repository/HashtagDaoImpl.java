package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("HashtagDao")
public class HashtagDaoImpl implements HashtagDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
