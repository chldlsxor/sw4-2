package project.controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.bean.EmailDto;
import project.bean.MemberDto;
import project.service.EmailService;
import project.service.HomeService;

@Controller
public class HomeController {

	@Autowired
	private HomeService homeService;
	
	@Autowired
	private EmailService emailService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
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
			HttpSession session, @ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException{
		boolean login = homeService.login(request, response, session, memberDto);
		if(login) return "redirect:/";
		else return "redirect:/login";
	}
	
	//회원가입
	@RequestMapping("/register")
	public String register() {
		return "register";
	}
	
	//회원가입(post)
	@PostMapping("/register")
	public String register(@ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException {
		homeService.register(memberDto);
		return "redirect:/login";
	}
	
	@RequestMapping("/email")
	public String email() {
		return "email";
	}
	
	@RequestMapping("/email_send")
	public void email_send(@ModelAttribute EmailDto emailDto) {
		log.info("id={}",emailDto.getId());
		emailDto.setNum(emailService.send_email(emailDto.getId()));
		log.info("num={}",emailDto.getNum());
		emailService.register(emailDto);
	}
	
	@PostMapping("/email_check")
	public String email_check(@ModelAttribute EmailDto emailDto) {
		log.info("id={}",emailDto.getId());
		log.info("num={}",emailDto.getNum());
		if(emailService.check(emailDto)) {
			emailService.check_ok(emailDto);
			return "redirect:/register";
		}
		else
			return "redirect:/email";
	}
	
	//비번 찾기
	@RequestMapping("/reset_pw")
	public String reset_pw() {
		return "reset_pw";
	}
	
	//비번 찾기(post)
	@PostMapping("/reset_pw")
	public String reset_pw(@ModelAttribute MemberDto memberDto, 
			HttpServletRequest request) throws UnsupportedEncodingException {
		homeService.reset_pw(memberDto, request);		
		return "redirect:/login";
	}
}
