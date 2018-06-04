package project.service;

import org.springframework.stereotype.Service;

import project.bean.EmailDto;

@Service
public interface EmailService {
	int send_email(String id);
	void plus(EmailDto emailDto);
	boolean check(EmailDto emailDto);
	void remove(String id);
}
