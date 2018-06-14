package project.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;

@Service
public interface MemberService {
	void logout(HttpSession session);
	void exit(String id);
	ModelAndView message(String view);
	MemberDto get(String id);
	MemberDto get_by_nick(String nick);
	void edit(MemberDto memberDto);
	void editPassword();
	void range();
	void friend();
	void notice();
	String profile(MultipartHttpServletRequest mRequest, MemberDto memberDto) throws IllegalStateException, IOException;
	List<MemberDto> search_member(String name);
}
