package project.service;

import java.util.List;

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
	
	@Override
	public ContentDto list() {
		// TODO Auto-generated method stub
		System.out.println("contentService 들어옴");
		List<BoardDto> conList = boardService.list();
		for(BoardDto b : conList) {
			System.out.println(b);
		}
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		
		return contentDto;
	}

}
