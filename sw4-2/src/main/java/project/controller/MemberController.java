package project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MessageDto;
import project.service.MemberService;
import project.service.MessageService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessageService messageService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
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
	public ModelAndView send_message(HttpServletRequest request,HttpSession session) {
		return messageService.getMessage(request, session);
	}
	/*@PostMapping("/send_message")
	public String send_message( @ModelAttribute MessageDto messageDto) {
		//log.info("{}에게 보내는 메세지",request.getParameter("messageto"));
		//session.setAttribute("messageto", request.getParameter("messageto"));
		log.info("{}가 {} 에게", messageDto.getSend(), messageDto.getReceive());
		log.info("내용 {}", messageDto.getContent()); 
		
		messageService.sendMessage(messageDto);		
		return "send_message";
	}*/
}
