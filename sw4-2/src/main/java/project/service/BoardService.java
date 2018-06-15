package project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.BoardDto;

@Service
public interface BoardService {

	public List<BoardDto> list(String key, String id);
	public List<BoardDto> addList(int start, String key, String id);
	public int write(BoardDto boardDto);
	public String[] loveList(BoardDto boardDto);
	public int loveCnt(String[] loveList);
	public int love(int bno,String id);
	public int listCnt();
	public BoardDto getBoardView(int no);
	public ModelAndView get_report_list();
	public void remove_board(int no);
}
