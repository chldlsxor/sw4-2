package project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Override
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}

	@Override
	public void message() {
		// TODO Auto-generated method stub
		
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
