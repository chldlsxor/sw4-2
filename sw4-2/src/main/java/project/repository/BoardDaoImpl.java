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
	public List<BoardDto> list(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardList",id);
	}

	@Override
	public List<BoardDto> addlist(int start, int end, String id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("id", id);
		log.info("start = {}",start);
		log.info("end = {}",end);
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

	@Override
	public int listCnt() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("listCnt");
	}

	@Override
	public BoardDto getBoardView(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getBoardView", no);
	}

	@Override
	public List<BoardDto> getReportList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("reportList");
	}

	@Override
	public void remove_board(int no) {
		sqlSession.delete("remove_board", no);
	}

	@Override
	public List<BoardDto> searchList(String key) {
		// TODO Auto-generated method stub
		log.info("boardDao searList key = {}",key);
		return sqlSession.selectList("searchList", key);
	}

	@Override
	public List<BoardDto> addSearchList(int start, int end, String key) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("key", key);
		return sqlSession.selectList("addSearchList", map);
	}

	@Override
	public List<BoardDto> my_list(String id) {
		return sqlSession.selectList("my_list",id);
	}

	@Override
	public BoardDto scrap_list(int no) {
		return sqlSession.selectOne("scrap_list",no);
	}

	@Override
	public List<Map<String, Integer>> getHeavyUploader() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getHeavyUploader");
	}

	@Override
	public String get_writer(int no) {
		return sqlSession.selectOne("get_writer",no);
	}

	@Override
	public List<BoardDto> searchListByContent(String keyword) {
		return sqlSession.selectList("searchListByContent", keyword);
	}

	@Override
	public void report_board(int no) {
		sqlSession.update("report_board", no);
	}

	@Override
	public void deleteNo(int no) {
		// TODO Auto-generated method stub
		sqlSession.delete("boardDel", no);
	}
	
}
