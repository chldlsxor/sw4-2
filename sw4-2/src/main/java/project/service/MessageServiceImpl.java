package project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.MessageDto;
import project.repository.MemberDao;
import project.repository.MessageDao;

@Service("messageService")
public class MessageServiceImpl implements MessageService{

	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private MemberDao memberDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	//메세지 보내기
	@Override
	public void sendMessage(MessageDto messageDto) {
		messageDao.send_message(messageDto);
	}

	//DB에 저장된 메세지 리스트 가져오기(리스트는 모두 읽음 처리해야)
	@Override
	public List<MessageDto> getMessage(String messageTo, String messageFrom) {
		
		MessageDto messageDto = new MessageDto();
		messageDto.setSend(messageFrom);
		messageDto.setReceive(messageTo);
		
		//리스트 모두 읽음 처리
		messageDao.read_list_message(messageDto);
		
		return messageDao.get_message(messageDto);
	}

	@Override
	public int messageCnt(String id) {
		return messageDao.messageCnt(id);
	}
	
	@Override
	public Map<String, Integer> messageCnt_send(String id) {
		log.info("id:{}", id);
		List<Map<String, String>> messageCnt_nick = messageDao.messageCnt_send(id);
		Map<String, Integer> countMsgMap = new HashMap<>();
		for(Map<String, String> map :  messageCnt_nick) {
			String a = map.get("SEND");
			Integer b = Integer.parseInt(String.valueOf(map.get("COUNT")));
			log.info("map : {}", a);
			log.info("map : {}", b);
			countMsgMap.put(a, b);
		}
		return countMsgMap;
	}

	
}
