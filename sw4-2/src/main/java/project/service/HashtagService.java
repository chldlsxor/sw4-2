package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface HashtagService {
	public void addHashTag(String hashtag, int bno);
	public List<Integer> searchBno(String key);
	public List<String> searchTag(String key);
	public List<Map<String, Integer>> countTag();
}
