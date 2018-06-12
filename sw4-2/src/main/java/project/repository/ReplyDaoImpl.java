package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.ReplyDto;

@Repository("ReplyDao")
public class ReplyDaoImpl implements ReplyDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void replyWrite(ReplyDto replyDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("replyWrite", replyDto);
	}

	@Override
	public List<ReplyDto> replyList(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("replyList", bno);
	}

	@Override
	public int getReplyNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getReplyNo");
	}

	@Override
	public ReplyDto getReply(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getReply", no);
	}

	@Override
	public List<ReplyDto> reReplyList(int gno) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("reReplyView", gno);
	}

	@Override
	public int getReplyCnt(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getReplyCnt", no);
	}

	@Override
	public void setReCnt(ReplyDto replyDto) {
		// TODO Auto-generated method stub
		sqlSession.update("setReCnt", replyDto);
	}
	
}
