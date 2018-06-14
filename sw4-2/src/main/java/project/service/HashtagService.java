package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface HashtagService {
	public void addHashTag(String hashtag, int bno);
	public List<Integer> searchBno(String key);
}
