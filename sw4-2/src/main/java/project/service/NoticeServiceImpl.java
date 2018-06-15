package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.NoticeDto;
import project.repository.NoticeDao;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public List<NoticeDto> notice_list(String id) {
		return noticeDao.notice_list(id);
	}

	@Override
	public void send_notice(NoticeDto noticeDto) {
		noticeDao.send_notice(noticeDto);
	}

}
