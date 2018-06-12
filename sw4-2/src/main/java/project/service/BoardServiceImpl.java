package project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.BoardDto;
import project.repository.BoardDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	private Logger log = LoggerFactory.getLogger(getClass());

	public List<BoardDto> list() {
		return boardDao.list();
	}

	@Override
	public List<BoardDto> addList(int start) {
		// TODO Auto-generated method stub
		int end = start+1;
		return boardDao.addlist(start, end);
	}

	@Override
	public int write(BoardDto boardDto) {
		// TODO Auto-generated method stub
		int no = boardDao.getNo();
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

}
