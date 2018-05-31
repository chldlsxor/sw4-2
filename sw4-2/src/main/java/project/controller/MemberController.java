package project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import project.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		memberService.logout(request);
		return "redirect:/";
	}
	
	@RequestMapping("/message")
	public ModelAndView message(HttpServletRequest request) {
		return memberService.message();
	}
	
	@RequestMapping("/send_message")
	public String send_message(HttpServletRequest request) {
		return "send_message";
	}
}
