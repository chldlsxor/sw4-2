package project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.BoardDto;
import project.repository.BoardDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private FriendService friendService;

	private Logger log = LoggerFactory.getLogger(getClass());

	public List<BoardDto> list(String key, String id) {
		List<BoardDto> boardlist = new ArrayList<>();
		if(key != null)
			boardlist = boardDao.searchList(key);
		else
			boardlist = boardDao.list(id);
		
		return boardlist;
	}

	@Override
	public List<BoardDto> addList(int start, String key, String id) {
		// TODO Auto-generated method stub
		int end = start+2;		
		if(!key.equals("")) {
			return boardDao.addSearchList(start, end, key);
		}
		else {
			return boardDao.addlist(start, end, id);
		}
	}

	@Override
	public int write(BoardDto boardDto, int no) {
		// TODO Auto-generated method stub
		boardDto.setNo(no);
		boardDao.write(boardDto);
		return no;
	}

	@Override
	public String[] loveList(BoardDto boardDto) {
		// TODO Auto-generated method stub
		if (boardDto.getGood() != null)
			return boardDao.goodList(boardDto.getNo()).split(",");
		else
			return null;
	}

	@Override
	public int loveCnt(String[] loveList) {
		// TODO Auto-generated method stub
		if (loveList != null)
			return loveList.length;
		return 0;
	}

	@Override
	public int love(int bno, String id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		int cnt = 0;
		String data = boardDao.goodList(bno);
		String back = "";
		boolean flag = false;
		if (data != null) {
			String[] loveList = data.split(",");
			for (String l : loveList) {
				if (!l.equals(id)) {
					back += l+",";
				}else {
					flag = true;
				}
			}
			if(flag) {
				map.put("no", bno);
				map.put("goodList", back);
				boardDao.good(map);
				cnt = loveCnt(back.split(","));
				if(back.equals("")) return 0;
				return cnt;
			}
		}else {
			data = "";			
		}
		data += id + ",";
		map.put("no", bno);
		map.put("goodList", data);
		boardDao.good(map);
		return loveCnt(data.split(","));
	}

	@Override
	public int listCnt() {
		// TODO Auto-generated method stub
		return boardDao.listCnt();
	}

	@Override
	public BoardDto getBoardView(int no) {
		// TODO Auto-generated method stub
		return boardDao.getBoardView(no);
	}

	@Override
	public ModelAndView get_report_list() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("reportList",boardDao.getReportList());
		mv.setViewName("admin/report_list");
		return mv;
	}

	@Override
	public void remove_board(int no) {
		boardDao.remove_board(no);
	}

	@Override
	public List<BoardDto> my_list(String id) {
		return boardDao.my_list(id);
	}

	@Override
	public BoardDto scrap_list(int no) {
		return boardDao.scrap_list(no);
	}

	@Override
	public List<Map<String, Integer>> getHeavyUploader() {
		// TODO Auto-generated method stub
		return boardDao.getHeavyUploader();
	}

	@Override
	public String get_writer(int no) {
		return boardDao.get_writer(no);
	}

	@Override
	public List<BoardDto> searchListByContent(String keyword) {
		return boardDao.searchListByContent(keyword);
	}

	@Override
	public void report_board(int no) {
		boardDao.report_board(no);
	}

	@Override
	public int getBoardNo() {
		// TODO Auto-generated method stub
		return boardDao.getNo();
	}

	@Override
	public void boardDel(int no) {
		// TODO Auto-generated method stub
		boardDao.deleteNo(no);
	}

}
