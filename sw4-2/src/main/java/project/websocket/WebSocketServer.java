package project.websocket;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import project.bean.FriendDto;
import project.bean.MessageDto;
import project.bean.NoticeDto;
import project.service.FriendService;
import project.service.MemberService;
import project.service.MessageService;
import project.service.NoticeService;

public class WebSocketServer extends TextWebSocketHandler{
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MemberService memberService;
	
	//다중 사용자 저장소
	private Map<String, WebSocketSession> user = new HashMap<>();
	private String full_signal = UUID.nameUUIDFromBytes("full".getBytes()).toString();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("웹소켓 연결><");
		//메신져는 사용자가 관리자가 아닌 회원일때 사용
		if(session.getAttributes().get("userpwr").toString().equals("회원")) {
			String messageFrom = (String)session.getAttributes().get("userid");
			String messageTo = (String)session.getAttributes().get("messageTo");	
			if(messageTo==null) {
				//로그인
				log.info("{}가 로그인 성공", messageFrom);
				user.put(messageFrom, session);
			}else {
				//메신저 창
				log.info("{}가{}에게 메세지", messageFrom, messageTo);
				user.put(messageFrom+messageTo, session);
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
		}
		log.info("지금 까지 로그인한 유저");
		for(String gid : user.keySet()) {
			 log.info("방 :{}",gid);
			 log.info("방의 session : {}",user.get(gid));
			 log.info("방의 session : {}",user.get(gid).getId());
			 log.info("-----------------------------------------------");
		 }
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		/*log.info("종료 하려고 한애  : {}",session.getAttributes().get("userid"));
		log.info("종료 하려고 한애  : {}",session.getAttributes().get("userweb"));*/
		String messageFrom = (String)session.getAttributes().get("userid");
		String messageTo = (String)session.getAttributes().get("messageTo");
		if(messageTo==null) {
			//로그인
			log.info("냠종료");
			user.remove(messageFrom);
		}else {
			//메신저 창
			log.info("종료");		
			user.remove(messageFrom+messageTo);
			session.getAttributes().remove("messageTo");
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String messageFrom  = (String)session.getAttributes().get("userid");
		String messageTo = (String)session.getAttributes().get("messageTo");
		String now = new SimpleDateFormat("HH:mm").format(new Date());
		String context = message.getPayload();
		TextMessage sender = new TextMessage(messageFrom);
		TextMessage content = new TextMessage(context);
		TextMessage time = new TextMessage(now);
		TextMessage alarm = new TextMessage(memberService.get(messageFrom).getNick());
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		messageDto.setContent(context);	
			
		FriendDto friendDto = new FriendDto();
		friendDto.setFollower(messageTo);
		friendDto.setFollow(messageFrom);
		boolean follow_check = friendService.search(friendDto);
		
		log.info("세션  : {}", session);
		int count = 0;
		for(String gid : user.keySet()) {
			log.info("그룹 아이디  : {}",gid);
			log.info("	- 웹소켓  : {}",user.get(gid));
			log.info("	- 보낸이  : {}",sender.toString());
			log.info("	- 보낸이  : {}",content.toString());
			
			if(gid.equals(messageFrom+messageTo)) {//(나-->상대방)
				user.get(gid).sendMessage(sender);
				user.get(gid).sendMessage(content);
				user.get(gid).sendMessage(time);
				count++;
				log.info("--> 메세지 전송 완료");
			}else if(gid.equals(messageTo+messageFrom)) {
				user.get(gid).sendMessage(sender);
				user.get(gid).sendMessage(content);
				user.get(gid).sendMessage(time);
				count++;
				log.info("--> 메세지 전송 완료");
			}else if(gid.equals(messageTo)) {
				if(follow_check) {
					user.get(gid).sendMessage(alarm);
					log.info("--> 알람 전송 완료");
				}
			}
		}
		if(count==2) {
			messageDto.setRead(1);//메세지 읽음 상태로
			 TextMessage text = new TextMessage(full_signal);
			 user.get(messageFrom+messageTo).sendMessage(text);//내방에 신호
			 user.get(messageTo+messageFrom).sendMessage(text);//상대방에 신호
		 }
		messageService.sendMessage(messageDto);
		
		if(!follow_check) {
			//알림 메세지
			log.info("맞팔 아님");
			NoticeDto noticeDto = new NoticeDto();
			noticeDto.setReceiver(messageTo);
			noticeDto.setSender(messageFrom);
			noticeDto.setType(4);
			noticeService.delete(noticeDto);
			noticeService.send_notice(noticeDto);
		}
	}
}
