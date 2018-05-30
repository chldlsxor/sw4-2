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
		System.out.println("boardService 들어옴");
		List<BoardDto> conList =	 boardDao.list();
		for(BoardDto b : conList) {
			System.out.println(b);
		}
		return conList;
	}
	
}
