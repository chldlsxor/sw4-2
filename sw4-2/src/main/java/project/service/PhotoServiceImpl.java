package project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.BoardDto;
import project.bean.PhotoDto;
import project.repository.PhotoDao;

@Service("photoService")
public class PhotoServiceImpl implements PhotoService{

	@Autowired
	private PhotoDao photoDao;

	@Override
	public List<List<PhotoDto>> getPhoto(List<BoardDto> conList) {
		// TODO Auto-generated method stub
		List<List<PhotoDto>> photoList = new ArrayList<>();
		for(BoardDto b : conList) {
			photoList.add(photoDao.getPhoto(b.getNo()));
		}
		return photoList;
	}
	
}
