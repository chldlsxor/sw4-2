package project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.MemberDto;
import project.bean.MessageDto;

@Repository("MessageDao")
public class MessageDaoImpl implements MessageDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void send_message(MessageDto messageDto) {
		sqlSession.insert("send_message", messageDto);
	}

	@Override
	public List<MessageDto> get_message(MessageDto messageDto) {
		return sqlSession.selectList("get_message", messageDto);
	}

	@Override
	public void read_list_message(MessageDto messageDto) {
		sqlSession.update("read_list_message", messageDto);
	}

	@Override
	public int messageCnt(String id) {
		return sqlSession.selectOne("messageCnt", id);
	}

	@Override
	public List<Map<String, String>> messageCnt_send(String id) {
		return sqlSession.selectList("messageCnt_send", id);
	}
	
}
