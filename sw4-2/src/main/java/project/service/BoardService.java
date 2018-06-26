package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.BoardDto;

@Service
public interface BoardService {

	public List<BoardDto> list(String key, String id);
	public List<BoardDto> addList(int start, String key, String id);
	public int write(BoardDto boardDto, int no);
	public String[] loveList(BoardDto boardDto);
	public int loveCnt(String[] loveList);
	public int love(int bno,String id);
	public int listCnt();
	public BoardDto getBoardView(int no);
	public ModelAndView get_report_list();
	public void remove_board(int no);
	public List<BoardDto> my_list(String id);
	public BoardDto scrap_list(int no);
	public List<Map<String, Integer>> getHeavyUploader();
	public String get_writer(int no);
	public List<BoardDto> searchListByContent(String keyword);
	public void report_board(int no);
	public int getBoardNo();
	public void boardDel(int no);
}
