package project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.BoardDto;

@Repository("BoardDao")
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;

	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public List<BoardDto> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardList");
	}

	@Override
	public List<BoardDto> addlist(int start, int end) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("addList", map);
	}

	@Override
	public void write(BoardDto boardDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("write",boardDto);
	}

	@Override
	public int getNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getNo");
	}

	@Override
	public String goodList(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("goodList", no);
	}

	@Override
	public void good(Map map) {
		// TODO Auto-generated method stub
		sqlSession.update("good", map);
	}
	
	
	
}
