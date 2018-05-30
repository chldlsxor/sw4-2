package project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import project.bean.MemberDto;

//
@Service
public interface HomeService {
	String login(HttpServletRequest request, 
			HttpServletResponse response, 
			HttpSession session, MemberDto memberDto);
	void register(MemberDto memberDto);
	String find_id(MemberDto memberDto,HttpServletRequest request);
	String find_pw(MemberDto memberDto,HttpServletRequest request);
}
