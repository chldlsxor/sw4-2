package project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.PhotoDto;

@Service
public interface PhotoService {

	public List<List<PhotoDto>> getPhoto(List<BoardDto> conList);
	public void writePhoto(PhotoDto photoDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	public byte[] loadImage(String name) throws IOException;
}
