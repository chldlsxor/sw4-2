package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.BoardDto;

@Repository("BoardDao")
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardDto> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardList");
	}
	
}
