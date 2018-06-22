package project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.bean.NoticeDto;
import project.bean.ReplyDto;
import project.service.BoardService;
import project.service.NoticeService;
import project.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/list")
	@ResponseBody
	public List<ReplyDto> replyList(int bno) {
		return replyService.replyList(bno);
	}
	
	@RequestMapping("/write")
	public String replyWrite(NoticeDto noticeDto, ReplyDto replyDto, Model model, HttpSession session) {
		model.addAttribute("replyList", replyService.replyWrite(replyDto));
		noticeDto.setReceiver(boardService.get_writer(replyDto.getBno()));
		noticeDto.setSender(session.getAttribute("userid").toString());
		noticeDto.setType(3);
		noticeDto.setBno(replyDto.getBno());
		noticeService.send_notice(noticeDto);
		return "board/addreply";
	}
	
	@RequestMapping("/getreply")
	public String getReply(int bno, Model model) {
		model.addAttribute("replyList", replyService.replyList(bno));
		return "board/addreply";
	}
	
	@RequestMapping("/re-reply-view")
	public String reReplyView(int gno, Model model) { 
		model.addAttribute("replyList", replyService.reReplyView(gno));
		return "board/addreply";
	}
	
	@RequestMapping("/replylove")
	public String replyLove(int no, Model model, String userno) {
		model.addAttribute("replyList", replyService.replyGood(no, userno));
		return "board/addreply";
	}
	
}
