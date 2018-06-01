package project.websocket;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketServer extends TextWebSocketHandler{
	private Logger log = LoggerFactory.getLogger(getClass());
	
	//다중 사용자 저장소
	//private Set<WebSocketSession> user = new HashSet<>();
	private Map<String, WebSocketSession> user = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//user.add(session);
		user.put(session.getAttributes().get("success").toString(), session);
		//log.info("사용자 접속 : {}", session.getRemoteAddress().getAddress());
		log.info("그룹 아이디 : {}", session.getAttributes().get("success"));
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		user.remove(session.getAttributes().get("success").toString());
		//user.remove(session);
		log.info("사용자 종료 : {}", session.getRemoteAddress().getAddress());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//String ip = session.getRemoteAddress().getAddress().getHostName();
		//TextMessage text = new TextMessage("["+ip+"] "+message.getPayload());
		String id  = (String)session.getAttributes().get("success");
		TextMessage text = new TextMessage("["+id+"] "+message.getPayload());
		log.info("세션  : {}", session);
		log.info("메세지  : {}",text.toString());
		//for(WebSocketSession ws : user) {
		for(String gid : user.keySet()) {
			log.info("그룹 아이디  : {}",gid);
			log.info("	- 웹소켓  : {}",user.get(gid));
			log.info("	- 메세지  : {}",text.toString());
			user.get(gid).sendMessage(text);
		}
		log.info("메세지 전체 전송 완료");
	}
}
