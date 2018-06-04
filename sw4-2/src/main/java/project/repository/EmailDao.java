package project.repository;

import org.springframework.stereotype.Repository;

import project.bean.EmailDto;

@Repository
public interface EmailDao {
	void plus(EmailDto emailDto);
	boolean check(EmailDto emailDto);
	void remove(String id);
}
