package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.NoticeDto;

@Service
public interface NoticeService {
	void send_notice(NoticeDto noticeDto);
	List<NoticeDto> notice_list(String id);
	void delete(NoticeDto noticeDto);
}
