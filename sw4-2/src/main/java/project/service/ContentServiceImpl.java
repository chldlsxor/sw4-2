package project.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.ContentDto;
import project.bean.PhotoDto;

@Service("contentService")
public class ContentServiceImpl implements ContentService {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private PhotoService photoService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public ContentDto list(String key, String id) {
		// TODO Auto-generated method stub
		List<BoardDto> conList = boardService.list(key, id);
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		
		return contentDto;
	}
	
	@Override
	public ContentDto my_list(String id) {
		List<BoardDto> conList = boardService.my_list(id);
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		
		return contentDto;
	}
	
	@Override
	public ContentDto addList(int start, String key, String id) {
		// TODO Auto-generated method stub
		List<BoardDto> conList = boardService.addList(start,key,id);
		ContentDto contentDto = new ContentDto();
		contentDto.setListBoardDto(conList);
		contentDto.setListPhotoDto(photoService.getPhoto(conList));
		return contentDto;
	}

	@Override
	public void write(BoardDto boardDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		int no = boardService.write(boardDto);
		PhotoDto photoDto = new PhotoDto();
		photoDto.setBno(no);
		photoService.writePhoto(photoDto, mRequest);
	}

	@Override
	public List<Integer> loveCnt(List<BoardDto> boardDto) {
		// TODO Auto-generated method stub
		List<Integer> list = new ArrayList<>();
		for(BoardDto b : boardDto) {
			list.add(boardService.loveCnt(boardService.loveList(b)));
		}
		return list;
	}

	@Override
	public List<String[]> loveList(List<BoardDto> boardDto) {
		// TODO Auto-generated method stub
		List<String[]> list = new ArrayList<>();
		for(BoardDto b : boardDto) {
			list.add(boardService.loveList(b));
		}
		
		return list;
	}

}
