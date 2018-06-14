package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.HashtagDto;

@Repository("HashtagDao")
public class HashtagDaoImpl implements HashtagDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addHashTag(HashtagDto hashtagDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("addHashTag", hashtagDto);
	}

	@Override
	public List<Integer> searchBno(String key) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("searchBno", key);
	}

	@Override
	public List<String> searchTag(String key) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("searchTag", key);
	}
	
	
	
}
