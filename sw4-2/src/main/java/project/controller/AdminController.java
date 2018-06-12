package project.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import project.bean.BoardDto;
import project.repository.BoardDao;
import project.service.BoardService;
import project.service.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminController {
/*	@Autowired
	private AdminService adminService;*/
	
	@Autowired
	private MemberService memberService;
	
	/*@Autowired
	private BoardService boardService;*/
	
	//나중에 지워
	@Autowired
	private BoardDao boardDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/")
	public ModelAndView member_list() {
		return memberService.message("admin/member_list");
	}
	
	@RequestMapping("/report_list")
	public ModelAndView report_list() {
		//service에 만들기
		ModelAndView mv = new ModelAndView();
		//나중에 memberList가 아니라 친구 리스트로 바꿔야 됨!!!!★☆
		mv.addObject("reportList",boardDao.getReportList());
		mv.setViewName("admin/report_list");
		return mv;
	}
	
}
