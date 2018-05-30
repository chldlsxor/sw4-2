package project.repository;

import org.springframework.stereotype.Repository;

import project.bean.FriendDto;

@Repository
public interface FriendDao {
	void follow(FriendDto friendDto);
	void unfollow(FriendDto friendDto);
}
