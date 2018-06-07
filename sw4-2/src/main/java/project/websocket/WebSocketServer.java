package project.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
	private Map<String, WebSocketSession> user = new HashMap<>();
	private String full_signal = UUID.nameUUIDFromBytes("full".getBytes()).toString();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 String messageFrom = session.getAttributes().get("userid").toString();
		 String messageTo = session.getAttributes().get("messageto").toString();		
		 user.put(messageFrom+messageTo, session);//내 메세지창에 session저장
		 
		 int count = 0;
		 for(String gid : user.keySet()) {
			 if(gid.equals(messageFrom+messageTo)||gid.equals(messageTo+messageFrom)) {
				 count++;
			 }
		 }
		 //채팅방에 사람이 다 찼을때 --> 신호 보내서 not read제거
		 if(count==2) {
			 TextMessage text = new TextMessage(full_signal);
			 user.get(messageFrom+messageTo).sendMessage(text);//내방에 신호
			 user.get(messageTo+messageFrom).sendMessage(text);//상대방에 신호
		 }	
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		user.remove(session.getAttributes().get("userid").toString()+session.getAttributes().get("messageto").toString());
		session.getAttributes().remove("messageto");//session에서 messageto 제거
		log.info("사용자 종료 : {}", session.getRemoteAddress().getAddress());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String messageFrom  = (String)session.getAttributes().get("userid");
		String messageTo = (String)session.getAttributes().get("messageto");
		String context = message.getPayload();
		TextMessage sender = new TextMessage(messageFrom);
		TextMessage content = new TextMessage(context);
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		messageDto.setContent(context);	
			
		log.info("세션  : {}", session);
		int count = 0;
		for(String gid : user.keySet()) {
			log.info("그룹 아이디  : {}",gid);
			log.info("	- 웹소켓  : {}",user.get(gid));
			log.info("	- 보낸이  : {}",sender.toString());
			log.info("	- 보낸이  : {}",content.toString());
			
			if(gid.equals(messageFrom+messageTo)||gid.equals(messageTo+messageFrom)) {	//(나-->상대방), (상대방-->나) 창에 메세지 표시
				user.get(gid).sendMessage(sender);
				user.get(gid).sendMessage(content);
				log.info("--> 메세지 전송 완료");
				count++;
			}		
		}
		if(count==2) {
			messageDto.setRead(1);//메세지 읽음 상태로
			 TextMessage text = new TextMessage(full_signal);
			 user.get(messageFrom+messageTo).sendMessage(text);//내방에 신호
			 user.get(messageTo+messageFrom).sendMessage(text);//상대방에 신호
		 }
		messageService.sendMessage(messageDto);
		
	}
}
