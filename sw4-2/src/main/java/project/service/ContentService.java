package project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.ContentDto;

@Service
public interface ContentService {
	
	public ContentDto list(String key, String id);
	public ContentDto addList(int start, String key, String id);
	public void write(BoardDto boardDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	public List<Integer> loveCnt(List<BoardDto> boardDto);
	public List<String[]> loveList(List<BoardDto> boardDto);
}
