package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("MessageDao")
public class MessageDaoImpl implements MessageDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
