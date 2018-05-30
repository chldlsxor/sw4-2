package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.BoardDto;

@Service
public interface BoardService {

	public List<BoardDto> list();
	
}
