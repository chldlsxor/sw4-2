package project.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.NoticeDto;
import project.repository.BoardDao;
import project.repository.MemberDao;
import project.repository.NoticeDao;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
	
	@Override
	public void delete_report(int bno) {
		//게시글 삭제하기
		boardDao.remove_board(bno);
	}


	@Override
	public void edit_user() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void delete_member() {
		//memberDao.remove(no);
	}

}
