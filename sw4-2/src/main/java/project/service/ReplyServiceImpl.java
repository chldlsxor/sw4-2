package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.ReplyDto;
import project.repository.ReplyDao;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public ReplyDto replyWrite(ReplyDto replyDto) {
		// TODO Auto-generated method stub
		int no = getReplyNo();
		replyDto.setNo(no);
		replyDao.replyWrite(replyDto);
		int gno = replyDto.getGno();
		if(gno != 0) {
			ReplyDto rdto = replyDao.getReply(gno);
			System.out.println(replyDao.getReplyCnt(rdto.getNo()));
			rdto.setRecnt(replyDao.getReplyCnt(rdto.getNo()));
			replyDao.setReCnt(rdto);
		}
		return replyDao.getReply(no);
	}

	@Override
	public List<ReplyDto> replyList(int bno) {
		// TODO Auto-generated method stub
		return replyDao.replyList(bno);
	}

	@Override
	public int getReplyNo() {
		// TODO Auto-generated method stub
		return replyDao.getReplyNo();
	}

	@Override
	public List<ReplyDto> reReplyView(int gno) {
		// TODO Auto-generated method stub
		return replyDao.reReplyList(gno);
	}

	@Override
	public int getReplyCnt(int no) {
		// TODO Auto-generated method stub
		return replyDao.getReplyCnt(no);
	}

	@Override
	public void setReCnt(ReplyDto replyDto) {
		// TODO Auto-generated method stub
		replyDao.setReCnt(replyDto);
	}

}
