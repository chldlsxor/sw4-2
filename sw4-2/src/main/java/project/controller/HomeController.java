package project.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.bean.MemberDto;
import project.service.HomeService;

@Controller
public class HomeController {

	@Autowired
	private HomeService homeService;
	
	//홈
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	//로그인(get)
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	//로그인(post)
	@PostMapping("/login")
	public String login(HttpServletRequest request, 
			HttpServletResponse response, 
			HttpSession session, @ModelAttribute MemberDto memberDto){		
		String param = homeService.login(request, response, session, memberDto);
		return "redirect:/result?"+param;
	}
	
	//회원가입
	@RequestMapping("/register")
	public String register() {
		return "register";
	}
	
	//회원가입(post)
	@PostMapping("/register")
	public String register(@ModelAttribute MemberDto memberDto) {
		homeService.register(memberDto);
		return "redirect:/register";
	}
	
	//아이디 찾기
	@RequestMapping("/find_id")
	public String find_id() {
		return "find_id";
	}
	
	//아이디 찾기(post)
	@PostMapping("/find_id")
	public String find_id(@ModelAttribute MemberDto memberDto, 
			HttpServletRequest request) {	
		String param = homeService.find_id(memberDto, request);
		return "redirect:/result?"+param;
	}
	
	//비번 찾기
	@RequestMapping("/find_pw")
	public String find_pw() {
		return "find_pw";
	}
	
	//비번 찾기(post)
	@PostMapping("/find_pw")
	public String find_pw(@ModelAttribute MemberDto memberDto, 
			HttpServletRequest request) {
		String param =homeService.find_pw(memberDto, request);		
		return "redirect:result.do?"+param;
	}
}
