package project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MessageDto;
import project.repository.MessageDao;

@Service("messageService")
public class MessageServiceImpl implements MessageService{

	@Autowired
	private MessageDao messageDao;
	
	@Override
	public void sendMessage(MessageDto messageDto) {
		messageDao.send_message(messageDto);
	}

	@Override
	public ModelAndView getMessage(HttpServletRequest request,HttpSession session) {
		String messageTo = request.getParameter("messageto");
		String messageFrom = session.getAttribute("userid").toString();
		
		session.setAttribute("messageto", messageTo);
		
		ModelAndView mv = new ModelAndView();
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		
		mv.addObject("message_list",messageDao.get_message(messageDto));
		mv.setViewName("send_message");
		return mv;
	}

	
}
