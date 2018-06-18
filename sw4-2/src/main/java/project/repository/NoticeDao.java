package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.NoticeDto;

@Repository
public interface NoticeDao {
	void send_notice(NoticeDto noticeDto);
	List<NoticeDto> notice_list(String id);
}
