package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.FriendDto;

@Service
public interface FriendService{
	void follow(FriendDto friendDto);
	void unfollow(FriendDto friendDto);
	List<FriendDto> follow_list(String id);
	List<FriendDto> follower_list(String id);
	int follow_cnt(String id);
	int follower_cnt(String id);
	boolean search(FriendDto friendDto);
}
