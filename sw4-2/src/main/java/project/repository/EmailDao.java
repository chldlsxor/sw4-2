package project.repository;

import org.springframework.stereotype.Repository;

import project.bean.EmailDto;

@Repository
public interface EmailDao {
	void register(EmailDto emailDto);
	boolean check(EmailDto emailDto);
	void check_ok(EmailDto emailDto);
	void delete(EmailDto emailDto);
}
