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
	public void delete_report(HttpServletRequest request) {
		//신고하는 글의 번호, 아이디가져오기
		int no = Integer.parseInt(request.getParameter("no"));
		String id = request.getParameter("id");
		
		//해당 아이디에게 알림 보내기
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setId(id);
		noticeDto.setContent("신고로 인해 해당 게시물이 삭제되었습니다");
		noticeDao.send_notice(noticeDto);
		
		//게시글 삭제하기
		boardDao.remove_board(no);
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
