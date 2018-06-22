package project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import project.bean.FriendDto;
import project.bean.MemberDto;
import project.bean.NoticeDto;
import project.bean.PageDto;
import project.repository.HashtagDao;
import project.repository.MemberDao;
import project.service.AdminService;
import project.service.BoardService;
import project.service.FriendService;
import project.service.HashtagService;
import project.service.MemberService;
import project.service.NoticeService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private HashtagService hashtagService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/admin")
	public String admin() {
		
		return "admin/admin_page";
	}
	
	/*@GetMapping("/member_list")
	public ModelAndView member_list() {
		return memberService.member_list("admin/member_list");
	}*/
	
	@RequestMapping("/member_list")
	public ModelAndView member_list(PageDto pageDto, HttpServletRequest request) {
		return memberService.member_page_list(pageDto, request);
	}
	
	//신고글 확인하기
	@GetMapping("/report_list")
	public ModelAndView report_list() {
		log.info("신고 리스트 실행");
		return boardService.get_report_list();
	}
	
	//신고글 삭제하기 (그전에 알람 보내기)
	@PostMapping("/report_list")
	public String  delete_report(NoticeDto noticeDto, String id, int bno) {
		//가능하면 삭제확인 메세지 띄우기
		log.info("삭제 요청 받음 {}", id);
		adminService.delete_report(bno);
		noticeDto.setReceiver(id);
		noticeDto.setSender("id");
		noticeDto.setType(5);
		noticeService.send_notice(noticeDto);
		return "redirect:report_list";
	}
	
	
	//사용자 상세보기
	@RequestMapping("/detail_user")
	public String  detail_user(FriendDto friendDto, Model model, String nick, HttpSession session) {
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
		return "admin/detail_user";
	}
	
	//사용자 수정하기
	/*@RequestMapping("/edit_user")
	public String  edit_user() {
		adminService.edit_user();
		return "edit_user";
	}*/
	
	//사용자 삭제하기
	@RequestMapping("/delete_user")
	public String  delete_user(String id) {
		//가능하면 삭제 확인 메세지 띄우기
		memberService.exit(id);
		return "redirect:member_list";
	}
	
	@RequestMapping("/admin_session")
	public String admin_session() {
		return "admin/admin_session";
	}
	
	@RequestMapping("/admin_upload")
	public String admin_upload() {
		return "admin/admin_upload";
	}
	
	@RequestMapping("/admin_hashtag")
	public String admin_hashtag() {
		return "admin/admin_hashtag";
	}
	
	@RequestMapping("/admin_board")
	public String admin_board() {
		return "admin/admin_board";
	}
	
	@RequestMapping("/admin_star")
	public String admin_star() {
		return "admin/admin_star";
	}
	
	//월별 접속자
	@SuppressWarnings("unchecked")
	@RequestMapping("/getDailyVisitor")
	@ResponseBody
	public  String daily_visiter(HttpServletRequest request, String month) {
		TreeMap<String,Integer> scmap = (TreeMap<String, Integer>) request.getServletContext().getAttribute("scMap");
        Gson gson = new Gson();
        log.info("month : {}",month);
        List<HashMap<String, String>> list = new ArrayList<>();
        for(String day :scmap.keySet()) {
        	log.info("day.substring(0, 6) : {}" ,day.substring(0, 7));
        	if(month.equals(day.substring(0, 7))) {
        		
        		HashMap<String,String> map = new HashMap<String,String>();
                map.put("month", day);
                map.put("count", scmap.get(day).toString());
                list.add(map);
        	}  	
        }
        log.info("gson : {}",gson.toJson(list));

		return gson.toJson(list);
	}
	
	//인기 해시 태그
	@RequestMapping(value = "/getHashtagCount", produces = "text/json; charset=UTF-8")
	@ResponseBody
	public  String hashtag_count() {
        Gson gson = new Gson();
        List<Map<String, Integer>> list = hashtagService.countTag();
		return gson.toJson(list);
	}
	
	//인기 팔로워
	@RequestMapping(value = "/getFollowTopList", produces = "text/json; charset=UTF-8")
	@ResponseBody
	public  String get_follow_top_list() {
        Gson gson = new Gson();
        List<Map<String, Integer>> list = friendService.get_follow_top_list();
		return gson.toJson(list);
	}
	
	//헤비 업로더(필요 없는 듯..)
	@RequestMapping(value = "/getUploadTopList", produces = "text/json; charset=UTF-8")
	@ResponseBody
	public  String get_upload_top_list() {
        Gson gson = new Gson();
        List<Map<String, Integer>> list = boardService.getHeavyUploader();
		return gson.toJson(list);
	}
	
	//월별 업로드
	//인기 게시물(좋아요로)??
	
}
