package project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.ReplyDto;
import project.repository.ReplyDao;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDao replyDao;

	private Logger log = LoggerFactory.getLogger(getClass());

	@Override
	public List<ReplyDto> replyWrite(ReplyDto replyDto) {
		// TODO Auto-generated method stub
		int no = getReplyNo();
		replyDto.setNo(no);
		log.info("replyser bno = {}", replyDto.getBno());
		replyDao.replyWrite(replyDto);
		int gno = replyDto.getGno();
		if (gno != 0) {
			ReplyDto rdto = replyDao.getReply(gno);
			System.out.println(replyDao.getReplyCnt(rdto.getNo()));
			rdto.setRecnt(replyDao.getReplyCnt(rdto.getNo()));
			replyDao.setReCnt(rdto);
		}
		return replyList(replyDto.getBno());
	}

	@Override
	public List<ReplyDto> replyList(int bno) {
		// TODO Auto-generated method stub
		List<ReplyDto> replyList = replyDao.replyList(bno);
		for (int i = 0; i < replyList.size(); i++) {
			String love = replyList.get(i).getGood();
			if (love != null) {
				String[] loveList = love.split(",");
				replyList.get(i).setLoveList(loveList);
				replyList.get(i).setLoveSize(loveList.length);
			}
		}
		return replyList;
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

	@Override
	public List<ReplyDto> replyGood(int no, String userno) {
		// TODO Auto-generated method stub
		ReplyDto rd = replyDao.getReply(no);
		boolean flag = true;
		String good = "";
		String back = rd.getGood();
		String[] loveList = null;
		if (back != null) {
			loveList = back.split(",");
			for (String l : loveList) {
				if (!l.equals(userno)) {
					good += l + ",";
				} else {
					flag = false;
				}
			}
		}

		if (flag) {
			good += userno + ",";
		}
		if(loveList != null) rd.setLoveSize(loveList.length);
		replyDao.replyGood(good, no);
		return replyList(rd.getBno());
	}

}
