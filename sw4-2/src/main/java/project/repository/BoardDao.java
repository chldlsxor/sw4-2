package project.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import project.bean.BoardDto;

@Repository
public interface BoardDao {

	public List<BoardDto> list(String id);
	public List<BoardDto> searchList(String key);
	public List<BoardDto> addlist(int start, int end, String id);
	public List<BoardDto> addSearchList(int start, int end, String key);
	public void write(BoardDto boardDto);
	public int getNo();
	public String goodList(int no);
	public void good(Map map);
	public int listCnt();
	public BoardDto getBoardView(int no);
	public List<BoardDto> getReportList();
	public void remove_board(int no);
	public List<BoardDto> my_list(String id);
	public BoardDto scrap_list(int no);
	public List<Map<String, Integer>> getHeavyUploader();

}
