package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("PhotoDao")
public class PhotoDaoImpl implements PhotoDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
