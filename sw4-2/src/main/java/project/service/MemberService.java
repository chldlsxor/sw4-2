package project.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public interface MemberService {
	void logout(HttpServletRequest request);
	void message();
	void edit();
	void editPassword();
	void range();
	void notice();
	void friend();
}
