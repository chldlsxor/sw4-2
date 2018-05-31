package project.service;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

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
			HttpSession session, MemberDto memberDto) throws UnsupportedEncodingException;
	void register(MemberDto memberDto) throws NoSuchAlgorithmException;
	void reset_pw(MemberDto memberDto,HttpServletRequest request);
}
