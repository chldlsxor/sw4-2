package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.ReplyDto;

@Repository
public interface ReplyDao {
	public void replyWrite(ReplyDto replyDto);
	public List<ReplyDto> replyList(int bno);
	public int getReplyNo();
	public ReplyDto getReply(int no);
	public List<ReplyDto> reReplyList(int gno);
}
