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

	@Override
	public int write(BoardDto boardDto) {
		// TODO Auto-generated method stub
		int no = boardDao.getNo();
		boardDto.setNo(no);
		boardDao.write(boardDto);
		return no;
	}

	@Override
	public List<String> loveList(BoardDto boardDto) {
		// TODO Auto-generated method stub
		String love = boardDto.getGood();
		
		return null;
	}
	
}
