package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project.bean.ContentDto;
import project.service.ContentService;

@Controller
public class BoardController {

	@Autowired
	private ContentService contentService;
	
	@RequestMapping("/list")
	public String list(Model model) {
		ContentDto contentDto = contentService.list();
		model.addAttribute("list", contentDto.getListBoardDto());
		model.addAttribute("photoList", contentDto.getListPhotoDto());
		return "main_view";
	}
	
}
