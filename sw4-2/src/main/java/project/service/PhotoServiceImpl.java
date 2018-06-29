package project.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.PhotoDto;
import project.repository.PhotoDao;

@Service("photoService")
public class PhotoServiceImpl implements PhotoService {

	@Autowired
	private PhotoDao photoDao;

	private Logger log = LoggerFactory.getLogger(getClass());

	@Override
	public List<List<PhotoDto>> getPhoto(List<BoardDto> conList) {
		// TODO Auto-generated method stub
		List<List<PhotoDto>> photoList = new ArrayList<>();
		for (BoardDto b : conList) {
			photoList.add(photoDao.getPhoto(b.getNo()));
		}
		return photoList;
	}

	public List<PhotoDto> getPhoto(int no) {
		return photoDao.getPhoto(no);
	}

	@Override
	public boolean writePhoto(PhotoDto photoDto, MultipartHttpServletRequest mRequest)
			throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		// String path
		// ="E:\\sw4-mh\\git\\sw4-2\\sw4-2\\src\\main\\webapp\\WEB-INF\\res\\image";
		boolean flag = true;
		String path = mRequest.getServletContext().getRealPath("/board");
		if (mRequest.getFiles("file") != null) {
			List<MultipartFile> list = mRequest.getFiles("file");
			// log.debug("파일 업로드 : {}",list);
			// log.debug("파일 : {}",mRequest.getFiles("file"));
			File dir = new File(path);
			String name = "";
			String type = "";
			// long fSize = 0L;
			for (MultipartFile file : list) {
				if (file.getOriginalFilename().toLowerCase().endsWith(".jpg") || file.getOriginalFilename().toLowerCase().endsWith(".jpeg")
						|| file.getOriginalFilename().toLowerCase().endsWith(".png")
						|| file.getOriginalFilename().toLowerCase().endsWith(".gif")
						|| file.getOriginalFilename().toLowerCase().endsWith(".bmp")) {

						String origin = file.getOriginalFilename();
						origin = origin.substring(origin.length() - 4);
						name = System.currentTimeMillis() + "-" + UUID.randomUUID() + origin;
						// type = file.getOriginalFilename();
						// fSize = file.getSize();
						type = file.getContentType();
						// log.info("type = {}", type);
						File target = new File(dir, name);
	
						file.transferTo(target);
						// log.debug("저장 완료 {}, {}", new Object[] { name, type });
						photoDto.setName(name);
						photoDto.setType(type);
	
						photoDao.writePhoto(photoDto);
						flag = false;
				}
			}
		}
		return flag;
	}

	@Override
	public byte[] loadImage(String name, String path) throws IOException {
		// TODO Auto-generated method stub
		File target = new File(path, name);

		// 파일을 읽어와서 사용자에게 쏴준다
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;

	}
}
