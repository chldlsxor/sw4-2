package project.repository;

import java.util.List;
import java.util.Map;
import java.util.Map;

import org.springframework.stereotype.Repository;

import project.bean.MessageDto;

@Repository
public interface MessageDao {
	void send_message(MessageDto messageDto);
	List<MessageDto> get_message(MessageDto messageDto);
	void read_list_message(MessageDto messageDto);
	int messageCnt(String id); 
	List<Map<String, String>>messageCnt_send(String id);
}
