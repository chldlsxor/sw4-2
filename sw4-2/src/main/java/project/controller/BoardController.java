package project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.bean.BoardDto;
import project.bean.ContentDto;
import project.bean.NoticeDto;
import project.service.BoardService;
import project.service.ContentService;
import project.service.FriendService;
import project.service.HashtagService;
import project.service.MemberService;
import project.service.MessageService;
import project.service.NoticeService;
import project.service.PhotoService;
import project.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private ContentService contentService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private PhotoService photoService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private HashtagService hashtagService;
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MessageService messageService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/list")
	public String list(Model model, String key, HttpSession session) {
		String id = (String)session.getAttribute("userid");
		int no = (int)session.getAttribute("userno");
		ContentDto contentDto = contentService.list(key, id);
		model.addAttribute("memberDto", memberService.get(id));
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		model.addAttribute("loveCnt", contentService.loveCnt(contentDto.getListBoardDto()));
		model.addAttribute("loveList", contentService.loveList(contentDto.getListBoardDto()));
		model.addAttribute("listCnt", boardService.listCnt());
		model.addAttribute("scrapList", memberService.scrapLoad(no));
		model.addAttribute("messageCnt", messageService.messageCnt(id));
		return "board/main_view";
	}
	
	@RequestMapping("/addlist")
	public String addlist(int start, Model model, String key, HttpSession session) {
		String id = (String)session.getAttribute("userid");
		ContentDto contentDto = contentService.addList(start, key, id);
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		model.addAttribute("loveCnt", contentService.loveCnt(contentDto.getListBoardDto()));
		model.addAttribute("loveList", contentService.loveList(contentDto.getListBoardDto()));
		return "board/addrow";
	}
	
	@RequestMapping("/write")
	public String write() {
		return "board/write";
	}
	
	@PostMapping("/write")
	public String postWrite(@ModelAttribute BoardDto boardDto, MultipartHttpServletRequest mRequest, String hashtag) throws IllegalStateException, IOException {
		contentService.write(boardDto, mRequest);
		if(hashtag != null)
			hashtagService.addHashTag(hashtag, boardDto.getNo());
		return "redirect:/board/list";
	}
	
	@RequestMapping("/image")
	@ResponseBody
	public byte[] image(String name) throws IOException {
		return photoService.loadImage(name);
	}
	
	@RequestMapping("/good")
	@ResponseBody
	public int good(NoticeDto noticeDto, int bno, String id, HttpSession session) {
		noticeDto.setReceiver(boardService.get_writer(bno));
		noticeDto.setSender(session.getAttribute("userid").toString());
		noticeDto.setType(2);
		noticeDto.setBno(bno);
		noticeService.send_notice(noticeDto);
		return boardService.love(bno, id);
	}
	
	@RequestMapping("/content_view")
	public String contentView(int no, Model model) {
		model.addAttribute("boardDto", boardService.getBoardView(no));
		model.addAttribute("photoList", photoService.getPhoto(no));
		model.addAttribute("replyList", replyService.replyList(no));
		return "board/content_view";
	}
	
	@RequestMapping("/search-tag")
	@ResponseBody
	public List<String> searchTag(String key){
		return hashtagService.searchTag(key);
	}
	
	@RequestMapping("/searchlist")
	public String searchlist(Model model, String key, HttpSession session) {
		String id = (String)session.getAttribute("userid");
		ContentDto contentDto = contentService.list(key, id);
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		model.addAttribute("loveCnt", contentService.loveCnt(contentDto.getListBoardDto()));
		model.addAttribute("loveList", contentService.loveList(contentDto.getListBoardDto()));
		model.addAttribute("listCnt", boardService.listCnt());
		return "board/search";
	}
	
	/*@RequestMapping("/report_board")
	public String report_board(String no) {
		int boardno = Integer.parseInt(no);
		log.info("no :{}",Integer.parseInt(no));
		boardService.report_board(boardno);
		return "redirect:list";
	}*/
	
	@RequestMapping("report_board")
	@ResponseBody
	public String scrapUp(String bno) {
		int no = Integer.parseInt(bno);
		boardService.report_board(no);
		return "해당 게시물을 신고하였습니다";
	}
	
	@RequestMapping("/delete")
	public String boardDel(int no) {
		boardService.boardDel(no);
		return "redirect:/board/list";
	}
	
}
