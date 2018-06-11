package project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.bean.ReplyDto;
import project.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/list")
	@ResponseBody
	public List<ReplyDto> replyList(int bno) {
		return replyService.replyList(bno);
	}
	
	@RequestMapping("/write")
	@ResponseBody
	public ReplyDto replyWrite(ReplyDto replyDto) {
		return replyService.replyWrite(replyDto);
	}
	
	@RequestMapping("/getreply")
	public String getReply(int bno, Model model) {
		model.addAttribute("replyList", replyService.replyList(bno));
		return "board/addreply";
	}
	
	@RequestMapping("re-reply-view")
	public String reReplyView(int gno, Model model) { 
		model.addAttribute("replyList", replyService.reReplyView(gno));
		return "board/addreply";
	}
	
}
