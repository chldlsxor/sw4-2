package project.controller;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import project.service.AdminService;
import project.service.BoardService;
import project.service.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/")
	public String admin() {
		return "admin/admin_page";
	}
	
	@RequestMapping("/member_list")
	public ModelAndView member_list() {
		return memberService.message("admin/member_list");
	}
	
	//신고글 확인하기
	@GetMapping("/report_list")
	public ModelAndView report_list() {
		log.info("신고 리스트 실행");
		return boardService.get_report_list();
	}
	
	//신고글 삭제하기 (그전에 알람 보내기)
	@PostMapping("/report_list")
	public String  delete_report(HttpServletRequest request) {
		//가능하면 삭제확인 메세지 띄우기
		log.info("삭제 요청 받음 {}", request.getParameter("id") );
		adminService.delete_report(request);
		return "redirect:report_list";
	}
	
	
	//사용자 상세보기
	@RequestMapping("/detail_user")
	public String  detail_user() {
		return "detail_user";
	}
	
	//사용자 수정하기
	@RequestMapping("/edit_user")
	public String  edit_user() {
		adminService.edit_user();
		return "edit_user";
	}
	
	//사용자 삭제하기
	@RequestMapping("/delete_user")
	public String  delete_user() {
		//가능하면 삭제 확인 메세지 띄우기
		adminService.delete_member();
		return "redirect:/";
	}
	
	@RequestMapping("/admin_count")
	public String admin_count(HttpServletRequest request) {
		return "admin/admin_count";
	}
	
	
}
