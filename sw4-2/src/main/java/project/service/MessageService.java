package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.MessageDto;

@Service
public interface MessageService {
	void sendMessage(MessageDto messageDto);
	List<MessageDto> getMessage(String messageTo, String messageFrom);
}
