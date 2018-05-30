package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.BoardDto;
import project.bean.PhotoDto;

@Service
public interface PhotoService {

	public List<List<PhotoDto>> getPhoto(List<BoardDto> conList);
	
}
