package project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.bean.ContentDto;
import project.service.ContentService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private ContentService contentService;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/list")
	public String list(Model model) {
		ContentDto contentDto = contentService.list();
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		return "main_view";
	}
	
	@RequestMapping("/addlist")
	@ResponseBody
	public ContentDto addlist(Integer start, Model model) {
		ContentDto contentDto = contentService.addList(start);
//		model.addAttribute("addList", contentDto.getListBoardDto());
//		model.addAttribute("photoList", contentDto.getListPhotoDto());
		return contentDto;
	}
	
}
