package project.websocket;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import project.bean.MessageDto;
import project.service.MessageService;

public class WebSocketServer extends TextWebSocketHandler{
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MessageService messageService;
	
	//다중 사용자 저장소
	//private Set<WebSocketSession> user = new HashSet<>();
	private Map<String, WebSocketSession> user = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//user.add(session);
		 String messageFrom = session.getAttributes().get("userid").toString();
		 String messageTo = session.getAttributes().get("messageto").toString();		
		 String gid = messageFrom+messageTo;
		 user.put(gid, session);
		 log.info("그룹 아이디 : {}", gid);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		;
		//user.remove(session);
		log.info("삭제 키값 {}", user.remove(session.getAttributes().get("userid").toString()+session.getAttributes().get("messageto").toString()));
		session.getAttributes().remove("messageto");
		log.info("사용자 종료 : {}", session.getRemoteAddress().getAddress());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//String ip = session.getRemoteAddress().getAddress().getHostName();
		//TextMessage text = new TextMessage("["+ip+"] "+message.getPayload());
		String messageFrom  = (String)session.getAttributes().get("userid");
		String messageTo = (String)session.getAttributes().get("messageto");
		String context = message.getPayload();
		TextMessage text = new TextMessage("["+messageFrom+"] "+ context);
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		messageDto.setContent(context);	
		messageService.sendMessage(messageDto);
		
		log.info("세션  : {}", session);
		log.info("메세지  : {}",text.toString());
		//for(WebSocketSession ws : user) {
		for(String gid : user.keySet()) {
			log.info("그룹 아이디  : {}",gid);
			log.info("	- 웹소켓  : {}",user.get(gid));
			log.info("	- 메세지  : {}",text.toString());
			if(gid.equals(messageFrom+messageTo)||gid.equals(messageTo+messageFrom)) {
				user.get(gid).sendMessage(text);
				log.info("--> 메세지 전송 완료");
			}		
		}
		
	}
}
