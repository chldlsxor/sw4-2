package project.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.bean.MemberDto;
import project.bean.PageDto;

@Service
public interface MemberService {
	void logout(HttpSession session);
	void exit(String id);
	MemberDto get(String id);
	MemberDto get_by_nick(String nick);
	void edit(MemberDto memberDto);
	String profile(MultipartHttpServletRequest mRequest, MemberDto memberDto) throws IllegalStateException, IOException;
	List<MemberDto> name_search(String name);
	List<MemberDto> nick_search(String nick);
	ModelAndView member_page_list(PageDto pageDto, HttpServletRequest request);
	String scrapLoad(int no);
	String scrapUpdate(int no, int bno);
}
