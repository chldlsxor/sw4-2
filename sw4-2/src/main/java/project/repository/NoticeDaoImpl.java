package project.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("NoticeDao")
public class NoticeDaoImpl implements NoticeDao{
	
	@Autowired
	private SqlSession slqSession;
	
}
