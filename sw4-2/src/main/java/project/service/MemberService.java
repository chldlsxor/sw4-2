package project.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public interface MemberService {
	void logout(HttpServletRequest request);
	ModelAndView message();
	void edit();
	void editPassword();
	void range();
	void notice();
	void friend();
}
