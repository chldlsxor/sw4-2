package project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.bean.MNDto;
import project.bean.NoticeDto;

@Repository("NoticeDao")
public class NoticeDaoImpl implements NoticeDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void send_notice(NoticeDto noticeDto) {
		sqlSession.insert("send_notice", noticeDto);
	}

	@Override
	public List<MNDto> notice_list(String id) {
		return sqlSession.selectList("notice_list", id);
	}
	
}
