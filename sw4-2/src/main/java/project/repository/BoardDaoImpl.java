package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BoardDao")
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
