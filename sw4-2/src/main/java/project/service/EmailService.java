package project.service;

import org.springframework.stereotype.Service;

import project.bean.EmailDto;

@Service
public interface EmailService {
	int send_email(String id);
	void register(EmailDto emailDto);
	boolean check(EmailDto emailDto);
	void check_ok(EmailDto emailDto);
	void delete(EmailDto emailDto);
}
