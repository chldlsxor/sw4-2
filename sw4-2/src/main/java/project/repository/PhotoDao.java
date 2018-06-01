package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.PhotoDto;

@Repository
public interface PhotoDao {

	public List<PhotoDto> getPhoto(int no);
	public void writePhoto(PhotoDto photoDto);
	
}
