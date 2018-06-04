package project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MessageDto;

@Service
public interface MessageService {
	void sendMessage(MessageDto messageDto);
	ModelAndView getMessage(HttpServletRequest request,HttpSession session);
}
