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
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String login(Model model, HttpSession session, @ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException{
		boolean login = homeService.login(session, memberDto);
		if(login)
			return "redirect:/";
		else {
			model.addAttribute("msg", "비번 틀렸씀");
			model.addAttribute("go", "login");
			return "redirect:/result";
		}
	}
	
	@RequestMapping("/result")
	public String result(String msg, String go, Model model) {
		model.addAttribute("msg", msg);
		model.addAttribute("go", go);
		return "result";
	}
	
//	@PostMapping("/login")
//	@ResponseBody
//	public boolean login(HttpSession session, @ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException{
//		return homeService.login(session, memberDto);
//	}
	
	//회원가입
	@RequestMapping("/register")
	public String register(String id, Model model) {
		model.addAttribute("id", id);
		return "register";
	}
	
	//회원가입(post)
	@PostMapping("/register")
	public String register(@ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException {
		homeService.register(memberDto);
		return "redirect:/login";
	}
	
	@RequestMapping("/email")
	public String email(Model model, @RequestParam String type) {
		log.info("param={}",type);
		model.addAttribute("type", type);
		return "email";
	}
	
	@RequestMapping("/email_send")
	public void email_send(@ModelAttribute EmailDto emailDto) {
		log.info("id={}",emailDto.getId());
		log.info("param={}",emailDto.getType());
		if(emailDto.getType().equals("register")) {
			if(homeService.select_id(emailDto.getId())) {//이미있는아이디
				//이미있는 아이디임
			}else {//없는아이디, 회원가입 가능
				emailService.remove(emailDto.getId());
				emailDto.setNum(emailService.send_email(emailDto.getId()));
				log.info("num={}",emailDto.getNum());
				emailService.plus(emailDto);
				log.info("된다");
			}
		}else {
			if(homeService.select_id(emailDto.getId())) {
				emailService.remove(emailDto.getId());
				emailDto.setNum(emailService.send_email(emailDto.getId()));
				log.info("num={}",emailDto.getNum());
				emailService.plus(emailDto);
			}else {
				//없는아이디임
			}
		}
	}
	
	@PostMapping("/email_check")
	public String email_check(@ModelAttribute EmailDto emailDto, Model model) {
		log.info("id={}",emailDto.getId());
		log.info("num={}",emailDto.getNum());
		if(emailService.check(emailDto)) {
//			emailService.check_ok(emailDto);
			model.addAttribute("id", emailDto.getId());
			return "redirect:/"+emailDto.getType();
		}
		else {
			model.addAttribute("msg", "인증번호 틀렸씀");
			model.addAttribute("go", "email?type="+emailDto.getType());
			return "redirect:/result";
		}
	}
	
	//비번 찾기
	@RequestMapping("/reset_pw")
	public String reset_pw(String id, Model model) {
		model.addAttribute("id", id);
		return "reset_pw";
	}
	
	//비번 찾기(post)
	@PostMapping("/reset_pw")
	public String reset_pw(@ModelAttribute MemberDto memberDto) throws NoSuchAlgorithmException {
		homeService.reset_pw(memberDto);		
		return "redirect:/login";
	}
}
