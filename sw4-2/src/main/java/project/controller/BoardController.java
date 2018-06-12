package project.controller;

import java.io.IOException;

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
import project.service.BoardService;
import project.service.ContentService;
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
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/list")
	public String list(Model model) {
		ContentDto contentDto = contentService.list();
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		model.addAttribute("loveCnt", contentService.loveCnt(contentDto.getListBoardDto()));
		model.addAttribute("loveList", contentService.loveList(contentDto.getListBoardDto()));
		model.addAttribute("listCnt", boardService.listCnt());
		return "board/main_view";
	}
	
	@RequestMapping("/addlist")
	public String addlist(int start, Model model) {
		ContentDto contentDto = contentService.addList(start);
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
	public String postWrite(@ModelAttribute BoardDto boardDto, MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		contentService.write(boardDto, mRequest);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/image")
	@ResponseBody
	public byte[] image(String name) throws IOException {
		return photoService.loadImage(name);
	}
	
	@RequestMapping("/good")
	@ResponseBody
	public int good(int bno, String id) {
		return boardService.love(bno, id);
	}
	
	@RequestMapping("/content_view")
	public String contentView(int no, Model model) {
		model.addAttribute("boardDto", boardService.getBoardView(no));
		model.addAttribute("photoList", photoService.getPhoto(no));
		model.addAttribute("replyList", replyService.replyList(no));
		return "board/content_view";
	}
	
}
