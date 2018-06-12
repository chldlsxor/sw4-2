package project.controller;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;
import project.service.HomeService;
import project.service.MemberService;
import project.service.MessageService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private HomeService homeService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		memberService.logout(request);
		return "redirect:/";
	}
	
	@RequestMapping("/message")
	public ModelAndView message(HttpServletRequest request) {
		return memberService.message("message");
	}
	
	@RequestMapping("/send_message")
	public ModelAndView send_message(HttpServletRequest request,HttpSession session) {
		return messageService.getMessage(request, session);
	}
	
	@RequestMapping("/edit")
	public String edit(Model model, HttpSession session) {
		MemberDto memberDto = memberService.get(session.getAttribute("userid").toString());
		model.addAttribute("memberDto", memberDto);
		return "member/edit";
	}
	
	@PostMapping("/edit")
	public String edit(Model model, MemberDto memberDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		//닉네임변경이 없거나 중복검사
		if(memberService.get(memberDto.getId()).getNick().equals(memberDto.getNick()) || !homeService.select_nick(memberDto.getNick())) {
			log.info("프사={}",memberDto.getProfile());
			log.info("프사={}",mRequest.getFile("f"));
			log.info("프사={}",mRequest.getFile("f").getOriginalFilename());
			//프로필사진 변경이 없는 경우
			if(mRequest.getFile("f").getOriginalFilename()=="")
				memberDto.setProfile(memberService.get(memberDto.getId()).getProfile());
			else {
//				File dir = new File("E:/upload");
//				MultipartFile file = mRequest.getFile("f");
//				String fname = memberDto.getId()+"_"+file.getOriginalFilename();
//				File target = new File(dir, fname);
//				file.transferTo(target);
//				memberDto.setProfile(file.getOriginalFilename());
				memberDto.setProfile(memberService.profile(mRequest, memberDto));
			}
			log.info("프사={}",memberDto.getProfile());
			memberService.edit(memberDto);
			model.addAttribute("msg", "회원정보가 변경되었습니다.");
			model.addAttribute("go", "member/edit");
			return "redirect:/result";
		}else {
			model.addAttribute("msg", memberDto.getNick()+"은(는) 이미 있는 닉네임");
			model.addAttribute("go", "member/edit");
			return "redirect:/result";
		}
	}
	
	@RequestMapping("/edit_pw")
	public String edit_pw(Model model, HttpSession session) {
		MemberDto memberDto = memberService.get(session.getAttribute("userid").toString());
		model.addAttribute("memberDto", memberDto);
		return "member/edit_pw";
	}
	
	@PostMapping("/edit_pw")
	public String edit_pw(Model model, MemberDto memberDto, HttpSession session, String new_pw) throws NoSuchAlgorithmException {
		log.info("new_pw={}",new_pw);
		if(homeService.login(session, memberDto)) {
			memberDto.setPw(new_pw);
			homeService.reset_pw(memberDto);
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("go", "member/edit_pw");
			return "redirect:/result";
		}else {
			model.addAttribute("msg", "이전 비밀번호가 다릅니다.");
			model.addAttribute("go", "member/edit_pw");
			return "redirect:/result";
		}
	}
	
	@RequestMapping("/list")
	public String detail(String name) {
		return "member/list";
	}
	
	@PostMapping("/list")
	public String detail() {
		return "member/list";
	}
}
