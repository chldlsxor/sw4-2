package project.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;

@Service
public interface MemberService {
	void logout(HttpServletRequest request);
	ModelAndView message();
	MemberDto get(String id);
	void edit(MemberDto memberDto);
	void editPassword();
	void range();
	void notice();
	void friend();
}
