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
import project.bean.PageDto;
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
	public ModelAndView member_list(String view) {
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
	public List<MemberDto> name_search(String name) {
		return memberDao.name_search(name);
	}

	@Override
	public List<MemberDto> nick_search(String nick) {
		return memberDao.nick_search(nick);
	}
	
	@Override
	public ModelAndView member_page_list(PageDto pageDto, HttpServletRequest request) {
		// TODO Auto-generated method stub
		log.info("keywordtype : {}, keyword : {}, order_type : {}, order : {}, list_num : {}, power {}",
				pageDto.getKeyword_type(),
				pageDto.getKeyword(),
				pageDto.getOrder_type(),
				pageDto.getOrder(),
				pageDto.getList_num(),
				pageDto.getPower());
		//페이지, pageDto받아오기
		pageDto.setSearchMode(pageDto.getKeyword_type()!=null &&pageDto.getKeyword() !=null);
		if(pageDto.isSearchMode())
			pageDto.setBoardcount(memberDao.member_get_count_by_search(pageDto));
		else
			pageDto.setBoardcount(memberDao.member_get_count());
		
		if(pageDto.getList_num()==0) 
			pageDto.setList_num(10);
		pageDto.setPageStr(request.getParameter("page"));
		log.info("page :{}", pageDto.getPageStr());
		log.info("getBoardcount :{}", pageDto.getBoardcount());
		//페이지 계산
		
		try {
			pageDto.setPageNo(Integer.parseInt(pageDto.getPageStr()));
			if(pageDto.getPageNo() < 0 ) throw new Exception();
		}catch(Exception e) {
			pageDto.setPageNo(1);
		}
		
		log.info("getPageNo :{}", pageDto.getPageNo());
		
		pageDto.setBoardfinish(pageDto.getPageNo()*pageDto.getList_num());
		pageDto.setBoardstart(pageDto.getBoardfinish()-(pageDto.getList_num()-1));
		
		pageDto.setBlockstart((pageDto.getPageNo()-1)/pageDto.getBlocksize()*pageDto.getBlocksize()+1);
		pageDto.setBlockfinish(pageDto.getBlockstart()+pageDto.getBlocksize()-1);
		
		pageDto.setBlockmax((pageDto.getBoardcount()+pageDto.getList_num()-1)/pageDto.getList_num());
		if(pageDto.getBlockmax()<pageDto.getBlockfinish()) pageDto.setBlockfinish(pageDto.getBlockmax());
		
		if(pageDto.isSearchMode())
			pageDto.setUrl("&keyword_type="+pageDto.getKeyword_type()+"&keyword="+pageDto.getKeyword()
			+"&order_type="+pageDto.getOrder_type()+"&order="+pageDto.getOrder()
			+"&list_num="+pageDto.getList_num()
			+"&power="+pageDto.getPower());
		else
			pageDto.setUrl("");
		
		log.info("getUrl :{}", pageDto.getUrl());
		ModelAndView mv = new ModelAndView();
		if(pageDto.isSearchMode())
			mv.addObject("memberList", memberDao.member_page_search(pageDto));
		else
			mv.addObject("memberList", memberDao.member_page_list(pageDto));
		mv.addObject("p",pageDto);
		mv.setViewName("admin/member_list");
		return mv;
	}

	@Override
	public String scrapLoad(int no) {
		// TODO Auto-generated method stub
		return memberDao.scrapLoad(no);
	}

	@Override
	public String scrapUpdate(int no, int bno) {
		// TODO Auto-generated method stub
		String list = scrapLoad(no);
		String back = "";
		String[] scrap = null;
		boolean flag = true;
		if(list != null) {
			scrap = list.split(",");
			for(String s : scrap) {
				if(!s.equals(bno)) {
					back += s + ",";
				}else {
					flag = false;
				}
			}
		}
		
		if(flag) {
			back += bno+",";
		}
		memberDao.scrapUpdate(no, back);
		
		return scrapLoad(no);
	}
}
