package project.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;
import project.repository.MemberDao;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}

	@Override
	public ModelAndView message() {
		ModelAndView mv = new ModelAndView();
		//나중에 memberList가 아니라 친구 리스트로 바꿔야 됨!!!!★☆
		mv.addObject("memberList",memberDao.member_list());
		mv.setViewName("message");
		return mv;
	}

	@Override
	public void edit() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void editPassword() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void range() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void notice() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void friend() {
		// TODO Auto-generated method stub
		
	}

}
