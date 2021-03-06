package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.ReplyDto;

@Service
public interface ReplyService {
	public List<ReplyDto> replyWrite(ReplyDto replyDto);
	public List<ReplyDto> replyList(int bno);
	public int getReplyNo();
	public List<ReplyDto> reReplyView(int gno);
	public int getReplyCnt(int no);
	public void setReCnt(ReplyDto replyDto);
	public List<ReplyDto> replyGood(int no, String userno);
}
