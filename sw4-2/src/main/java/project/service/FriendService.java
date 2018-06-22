package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import project.bean.FriendDto;
import project.bean.MemberDto;

@Service
public interface FriendService{
	void follow(FriendDto friendDto);
	void unfollow(FriendDto friendDto);
	List<String> follow_list(String id);
	List<String> follower_list(String id);
	int follow_cnt(String id);
	int follower_cnt(String id);
	boolean search(FriendDto friendDto);
	List<String> follow_list_search(String follower, String type, String keyword);
	List<String> follower_list_search(String follow, String type, String keyword);
	List<Map<String, Integer>> get_follow_top_list();
}
