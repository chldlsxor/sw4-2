package project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MessageDto;
import project.repository.MemberDao;
import project.repository.MessageDao;

@Service("messageService")
public class MessageServiceImpl implements MessageService{

	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//메세지 보내기
	@Override
	public void sendMessage(MessageDto messageDto) {
		messageDao.send_message(messageDto);
	}

	//DB에 저장된 메세지 리스트 가져오기(리스트는 모두 읽음 처리해야)
	@Override
	public ModelAndView getMessage(HttpServletRequest request,HttpSession session) {
		String messageTo = request.getParameter("messageto");
		String messageFrom = session.getAttribute("userid").toString();
		
		//세션에 받는 사람 추가(연결 끊기면 삭제)
		session.setAttribute("messageto", messageTo);
		
		ModelAndView mv = new ModelAndView();
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		
		//리스트 모두 읽음 처리
		messageDao.read_list_message(messageDto);
		
		//리스트 가져오기
		mv.addObject("message_list",messageDao.get_message(messageDto));
		//받는 사람 정보 가져오기
		mv.addObject("receive_info",memberDao.get(messageTo));
		mv.setViewName("send_message");
		return mv;
	}

	
}
