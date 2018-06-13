package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.HashtagDto;
import project.repository.HashtagDao;

@Service("hashtagService")
public class HashtagServiceImpl implements HashtagService{

	@Autowired
	private HashtagDao hashtagDao;
	
	@Override
	public void addHashTag(String hashtag, int bno) {
		// TODO Auto-generated method stub
		String[] hash = hashtag.split(" ,");
		HashtagDto hashtagDto = new HashtagDto();
		hashtagDto.setBno(bno);
		for(String h : hash) {
			hashtagDto.setTag(h);
			hashtagDao.addHashTag(hashtagDto);
		}
	}

	@Override
	public List<Integer> searchBno(String key) {
		// TODO Auto-generated method stub
		return hashtagDao.searchBno(key);
	}

}
