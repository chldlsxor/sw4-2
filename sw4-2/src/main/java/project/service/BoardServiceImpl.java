package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.BoardDto;
import project.repository.BoardDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public List<BoardDto> list(){
		return boardDao.list();
	}

	@Override
	public List<BoardDto> addList(int start) {
		// TODO Auto-generated method stub
		int end = start + 1;
		return boardDao.addlist(start, end);
	}
	
}
