package project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;
import project.repository.MemberDao;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public void exit(String id) {
		memberDao.exit(id);
	}
	
	@Override
	public ModelAndView message(String view) {
		ModelAndView mv = new ModelAndView();
		//나중에 memberList가 아니라 친구 리스트로 바꿔야 됨!!!!★☆
		mv.addObject("memberList",memberDao.member_list());
		mv.setViewName(view);
		return mv;
	}

	@Override
	public void edit(MemberDto memberDto) {
		memberDao.edit(memberDto);
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

	@Override
	public MemberDto get(String id) {
		return memberDao.get(id);
	}
	
	@Override
	public MemberDto get_by_nick(String nick) {
		return memberDao.get_by_nick(nick);
	}

	@Override
	public String profile(MultipartHttpServletRequest mRequest, MemberDto memberDto) throws IllegalStateException, IOException {
		File dir = new File("E:/upload");
		MultipartFile file = mRequest.getFile("f");
		String fname = memberDto.getId()+"_"+file.getOriginalFilename();
		File target = new File(dir, fname);
		file.transferTo(target);
		return file.getOriginalFilename();
		
	}

	@Override
	public List<MemberDto> search_member(String name) {
		return memberDao.search_member(name);
	}
}
