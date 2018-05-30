package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.BoardDto;

@Repository
public interface BoardDao {

	public List<BoardDto> list();
	
}
