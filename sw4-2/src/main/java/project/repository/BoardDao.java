package project.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import project.bean.BoardDto;

@Repository
public interface BoardDao {

	public List<BoardDto> list();
	public List<BoardDto> addlist(int start, int end);
	public void write(BoardDto boardDto);
	public int getNo();
	public String goodList(int no);
	public void good(Map map);
	public int listCnt();
	public BoardDto getBoardView(int no);
	public List<BoardDto> getReportList();
}
