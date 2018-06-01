package project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.BoardDto;
import project.bean.ContentDto;

@Service("contentService")
public class ContentServiceImpl implements ContentService {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private PhotoService photoService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public ContentDto list() {
		// TODO Auto-generated method stub
		List<BoardDto> conList = boardService.list();
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		
		return contentDto;
	}

	@Override
	public ContentDto addList(int start) {
		// TODO Auto-generated method stub
		List<BoardDto> conList = boardService.addList(start);
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		return contentDto;
	}

}
