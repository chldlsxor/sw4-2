package project.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.bean.BoardDto;
import project.bean.ContentDto;
import project.bean.FriendDto;
import project.bean.MemberDto;
import project.bean.NoticeDto;
import project.service.BoardService;
import project.service.ContentService;
import project.service.FriendService;
import project.service.HomeService;
import project.service.MemberService;
import project.service.MessageService;
import project.service.NoticeService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private HomeService homeService;
	
	@Autowired FriendService friendService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ContentService contentService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		memberService.logout(session);
		return "redirect:/";
	}
	
	@RequestMapping("/exit")
	public String exit(HttpSession session) {
		memberService.exit(session.getAttribute("userid").toString());
		memberService.logout(session);
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
	public String edit_pw(Model model, MemberDto memberDto, String new_pw) throws NoSuchAlgorithmException {
		log.info("new_pw={}",new_pw);
		if(homeService.pw_check(memberDto)) {
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
	public String list(Model model, String name) {
		List<MemberDto> list = null;
		
		if(name != null) {
			list = memberService.search_member(name);
		}
		
		model.addAttribute("list",list);
		model.addAttribute("name",name);
		
		return "member/list";
	}
	
	@RequestMapping("/detail")
	public String detail(FriendDto friendDto, Model model, String nick, HttpSession session) {
		log.info("nick={}",nick);
		MemberDto memberDto = memberService.get_by_nick(nick);
		model.addAttribute("memberDto", memberDto);
		
		int follow_cnt = friendService.follow_cnt(memberDto.getId());
		int follower_cnt = friendService.follower_cnt(memberDto.getId());
		model.addAttribute("follow_cnt",follow_cnt);
		model.addAttribute("follower_cnt",follower_cnt);
		
		friendDto.setFollower(session.getAttribute("userid").toString());
		log.info(friendDto.getFollower());
		friendDto.setFollow(memberDto.getId());
		log.info(friendDto.getFollow());
		boolean follow_check = friendService.search(friendDto);
		model.addAttribute("follow_check",follow_check);
		
//		List<BoardDto> my_list = boardService.my_list(memberDto.getId());
//		model.addAttribute("my_list",my_list);
		
		ContentDto contentDto = contentService.my_list(memberDto.getId());
		model.addAttribute("my_list",contentDto.getListBoardDto());
		model.addAttribute("photo_list",contentDto.getListPhotoDto());
		model.addAttribute("board_cnt",contentDto.getListBoardDto().size());
		
		return "member/detail";
	}
	
	@RequestMapping("/scrap")
	public String scrap(Model model, HttpSession session) {
		MemberDto memberDto = memberService.get_by_nick(session.getAttribute("usernick").toString());
		model.addAttribute("memberDto", memberDto);
		
		int follow_cnt = friendService.follow_cnt(memberDto.getId());
		int follower_cnt = friendService.follower_cnt(memberDto.getId());
		model.addAttribute("follow_cnt",follow_cnt);
		model.addAttribute("follower_cnt",follower_cnt);

		return "member/scrap";
	}
	
	@PostMapping("follow")
	public String follow(NoticeDto noticeDto, FriendDto friendDto, Model model) {
		friendService.follow(friendDto);
		MemberDto memberDto = memberService.get(friendDto.getFollow());
		model.addAttribute("nick",memberDto.getNick());
		
		noticeDto.setReceiver(friendDto.getFollow());
		noticeDto.setSender(friendDto.getFollower());
		noticeDto.setType(0);
		noticeService.send_notice(noticeDto);
		return "redirect:detail";
	}
	
	@PostMapping("unfollow")
	public String unfollow(FriendDto friendDto, Model model) {
		friendService.unfollow(friendDto);
		MemberDto memberDto = memberService.get(friendDto.getFollow());
		model.addAttribute("nick",memberDto.getNick());
		return "redirect:detail";
	}
	
	@RequestMapping("/follow_list")
	public String follow_list(Model model, String name, String nick) {
		//닉네임을 받아와서 회원정보를 뽑음
		MemberDto memberDto = memberService.get_by_nick(nick);
		
		List<String> follow_list = new ArrayList<>();
		//그 회원의 팔로우 리스트를 뽑음
		if(name != null) {
			//검색어있을 경우
			follow_list=friendService.follow_list_search(memberDto.getId(), name);
		}else {
			follow_list=friendService.follow_list(memberDto.getId());
		}
		
		List<MemberDto> list = new ArrayList<>();
		
		for(String id : follow_list) {
			log.info("id={}",id);
			list.add(memberService.get(id));
		}
		
		model.addAttribute("nick",nick);
		model.addAttribute("list",list);
		model.addAttribute("name",name);
		int follow_cnt = friendService.follow_cnt(memberDto.getId());
		model.addAttribute("follow_cnt",follow_cnt);
		
		return "member/follow_list";
	}
	
	@RequestMapping("/follower_list")
	public String follower_list(Model model, String name, String nick) {
		//닉네임을 받아와서 회원정보를 뽑음
		MemberDto memberDto = memberService.get_by_nick(nick);
		
		List<String> follower_list = new ArrayList<>();
		//그 회원의 팔로우 리스트를 뽑음
		if(name != null) {
			//검색어있을 경우
			follower_list=friendService.follower_list_search(memberDto.getId(), name);
		}else {
			follower_list=friendService.follower_list(memberDto.getId());
		}
		
		List<MemberDto> list = new ArrayList<>();
		
		for(String id : follower_list) {
			log.info("id={}",id);
			list.add(memberService.get(id));
		}
		
		model.addAttribute("nick",nick);
		model.addAttribute("list",list);
		model.addAttribute("name",name);
		int follower_cnt = friendService.follower_cnt(memberDto.getId());
		model.addAttribute("follower_cnt",follower_cnt);
		
		return "member/follower_list";
	}
	
	@RequestMapping("/notice")
	public String notice(Model model, HttpSession session) {
		List<NoticeDto> list = noticeService.notice_list(session.getAttribute("userid").toString());
		
		model.addAttribute("list",list);
		
		return "member/notice";
	}
}
