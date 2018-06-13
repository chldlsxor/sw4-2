package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.FriendDto;
import project.repository.FriendDao;

@Service("friendService")
public class FriendServiceImpl implements FriendService{

	@Autowired
	private FriendDao friendDao;
	
	@Override
	public void follow(FriendDto friendDto) {
		friendDao.follow(friendDto);
	}

	@Override
	public void unfollow(FriendDto friendDto) {
		friendDao.unfollow(friendDto);
	}

	@Override
	public List<String> follow_list(String id) {
		return friendDao.follow_list(id);
	}

	@Override
	public List<String> follower_list(String id) {
		return friendDao.follower_list(id);
	}

	@Override
	public int follow_cnt(String id) {
		return friendDao.follow_cnt(id);
	}

	@Override
	public int follower_cnt(String id) {
		return friendDao.follower_cnt(id);
	}

	@Override
	public boolean search(FriendDto friendDto) {
		return friendDao.search(friendDto);
	}

	@Override
	public List<String> follow_list_search(String follower, String name) {
		return friendDao.follow_list_search(follower, name);
	}
	
	@Override
	public List<String> follower_list_search(String follow, String name) {
		return friendDao.follower_list_search(follow, name);
	}

}
