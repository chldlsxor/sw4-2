package project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.bean.MNDto;
import project.bean.NoticeDto;

@Service
public interface NoticeService {
	void send_notice(NoticeDto noticeDto);
	List<MNDto> notice_list(String id);
}
