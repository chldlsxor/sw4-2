package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.MessageDto;

@Repository
public interface MessageDao {
	void send_message(MessageDto messageDto);
	List<MessageDto> get_message(MessageDto messageDto);
}
