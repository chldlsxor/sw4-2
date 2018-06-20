package project.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import project.bean.HashtagDto;

@Repository
public interface HashtagDao {
	public void addHashTag(HashtagDto hashtagDto);
	public List<Integer> searchBno(String key);
	public List<String> searchTag(String key);
	public List<Map<String, Integer>> countTag();
}
