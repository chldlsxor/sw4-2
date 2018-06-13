package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.HashtagDto;

@Repository
public interface HashtagDao {
	public void addHashTag(HashtagDto hashtagDto);
	public List<Integer> searchBno(String key);
}
