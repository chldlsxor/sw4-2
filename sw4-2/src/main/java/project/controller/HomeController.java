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
		return "register";
	}
	
	//로그인(get)
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	//로그인(post)
	@PostMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session, MemberDto memberDto, String save) throws NoSuchAlgorithmException{
		if(homeService.select_id(memberDto.getId())) {
			boolean login = homeService.login(session, memberDto, request, response, save);
			if(login) {
				if(session.getAttribute("userpwr").equals("회원")) {//회원 일 때
					return "redirect:board/list";
				}
				else {//관리자 일때
					return "redirect:admin/admin";
				}	
			}
			else {
				model.addAttribute("msg", "비밀번호가 틀렸습니다.");
				model.addAttribute("go", "login");
				return "redirect:/result";
			}
		}else {
			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
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
	
	//회원가입
	@RequestMapping("/register")
	public String register() {
		return "register";
	}
	
	//회원가입(post)
	@PostMapping("/register")
	public String register(HttpSession session, MemberDto memberDto,Model model) throws NoSuchAlgorithmException {
		if(homeService.select_nick(memberDto.getNick())) {
			model.addAttribute("msg", memberDto.getNick()+"은(는) 이미 존재하는 닉네임입니다.");
			model.addAttribute("go", "register");
			return "redirect:/result";
		}else {
			homeService.register(memberDto);
			session.removeAttribute("email_check");
			model.addAttribute("msg", "회원가입이 완료되었습니다.");
			model.addAttribute("go", "login");
			return "redirect:/result";
		}
	}
	
	@RequestMapping("/email")
	public String email(Model model, String type) {
		log.info("param={}",type);
		model.addAttribute("type", type);
		return "email";
	}
	
	@PostMapping("/email")
	public String email_send(Model model, EmailDto emailDto, String type) {
		log.info("id={}",emailDto.getId());
		log.info("param={}",type);
		if(type.equals("register")) {
			if(homeService.select_id(emailDto.getId())) {//이미있는아이디
				//이미있는 아이디임
				model.addAttribute("msg", emailDto.getId()+"은(는) 이미 존재하는 아이디입니다.");
				model.addAttribute("go", "email?type="+type);
				return "redirect:/result";
			}else {//없는아이디, 회원가입 가능
				emailService.remove(emailDto.getId());
				emailDto.setNum(emailService.send_email(emailDto.getId()));
				log.info("num={}",emailDto.getNum());
				emailService.plus(emailDto);
				model.addAttribute("id",emailDto.getId());
				return "redirect:/email_check?type="+type;
			}
		}else {
			if(homeService.select_id(emailDto.getId())) {
				emailService.remove(emailDto.getId());
				emailDto.setNum(emailService.send_email(emailDto.getId()));
				log.info("num={}",emailDto.getNum());
				emailService.plus(emailDto);
				model.addAttribute("id",emailDto.getId());
				return "redirect:/email_check?type="+type;
			}else {
				//없는아이디임
				model.addAttribute("msg", emailDto.getId()+"은(는) 존재하지 않는 아이디입니다.");
				model.addAttribute("go", "email?type="+type);
				return "redirect:/result";
			}
		}
	}
	
	@RequestMapping("/email_check")
	public String email_check(Model model, String type, String id) {
		model.addAttribute("type", type);
		model.addAttribute("id", id);
		
		return "email_check";
	}
	
	@PostMapping("/email_check")
	public String email_check(HttpSession session, EmailDto emailDto, Model model, String type) {
		log.info("id={}",emailDto.getId());
		log.info("num={}",emailDto.getNum());
		if(emailService.check(emailDto)) {
//			emailService.check_ok(emailDto);
			session.setAttribute("email_check", emailDto.getId());
			return "redirect:/"+type;
		}
		else {
			model.addAttribute("msg", "인증번호가 틀렸습니다.");
			model.addAttribute("go", "email?type="+type);
			return "redirect:/result";
		}
	}
	
	//비번 재설정
	@RequestMapping("/reset_pw")
	public String reset_pw() {
		return "reset_pw";
	}
	
	//비번 재설정(post)
	@PostMapping("/reset_pw")
	public String reset_pw(HttpSession session, MemberDto memberDto, Model model) throws NoSuchAlgorithmException {
		homeService.reset_pw(memberDto);
		session.removeAttribute("email_check");
		model.addAttribute("msg", "비밀번호가 재설정 되었습니다.");
		model.addAttribute("go", "login");
		return "redirect:/result";
	}
}
