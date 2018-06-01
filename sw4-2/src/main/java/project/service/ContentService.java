package project.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.ContentDto;
import project.bean.PhotoDto;

@Service
public interface ContentService {
	
	public ContentDto list();
	public ContentDto addList(int start);
	public void write(BoardDto boardDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
}
