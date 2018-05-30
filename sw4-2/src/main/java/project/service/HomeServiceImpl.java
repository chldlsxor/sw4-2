package project.service;

import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.bean.MemberDto;
import project.repository.MemberDao;



@Service("homeService")
public class HomeServiceImpl implements HomeService{
	
	@Autowired
	private MemberDao memberDao;
	
	//비밀번호
	@Autowired
	private EncryptService sha256;
	
	@Autowired
	private EmailService emailService;

	@Override
	public String login(HttpServletRequest request, 
			HttpServletResponse response, 
			HttpSession session, MemberDto memberDto) {
		String text, link;
		if(memberDao.login(memberDto)) {									//로그인 성공
			text = URLEncoder.encode("로그인 성공", "UTF-8");
			link = request.getContextPath()+"/index.do";
			
			//세션에 로그인 성공에 관련된 데이터를 추가
			//이름 : success, 값 : 사용자ID
			session.setAttribute("success", memberDto.getId());
			
			
			//이름 : power, 값 : 사용자 권한
			MemberDto mdto2 = memberDao.get(memberDto.getId());
			session.setAttribute("power", mdto2.getPower());
			
			//save라는 파라미터를 받아서 존재 여부에 따라 쿠키 처리를 수행
			String save = request.getParameter("save");
			if(save == null) {			//체크 안한 경우 ---> 쿠키 삭제(remove.jsp)
				Cookie c = new Cookie("save", memberDto.getId());
				c.setPath(request.getContextPath());
				c.setMaxAge(0);
				response.addCookie(c);
			}else {							//체크 한 경우 -----> 쿠키 생성(create.jsp)
				Cookie c = new Cookie("save", memberDto.getId());
				c.setPath(request.getContextPath());	//프로젝트 전체에서 사용하도록 설정
				c.setMaxAge(4 * 7 * 24 * 60 * 60);//4주뒤에 뵙겠습니다
				response.addCookie(c);
			}
		}
		else {																	//로그인 실패
			text = URLEncoder.encode("로그인 정보가 일치하지 않습니다", "UTF-8");
			link = request.getContextPath()+"/login.do";
		}
		String param = "text="+text+"&link="+link;
		return param;

	}

	@Override
	public void register(MemberDto memberDto) throws NoSuchAlgorithmException {
		//비밀번호 규칙 정하기!!
		memberDto.setLoop((int)(Math.random()*9)+1);
		memberDto.setSalt(UUID.randomUUID().toString());
		String encpw = sha256.encrypt(memberDto.getPw(), memberDto.getSalt(), memberDto.getLoop());
		memberDto.setPw(encpw);
		
		//회원가입하기
		memberDao.register(memberDto);
	}

	@Override
	public String reset_pw(MemberDto memberDto, 
			HttpServletRequest request) {
		String pw = memberDao.reset_pw(memberDto);
		
		//[3] 결과 전송
		String text, link;
		if(pw == null) {
			text = URLEncoder.encode("찾으시는 정보가 존재하지 않습니다", "UTF-8");
			link = request.getContextPath()+"/jsp/member/find_pw.jsp";
		}else {
			//pw 모자이크 처리
			StringBuffer buf = new StringBuffer();
			for(int i=0; i < pw.length(); i++) {
				char c = pw.charAt(i);
				if(i < 2) {
					buf.append(c);
				}else {
					buf.append("*");
				}
			}
			pw = buf.toString();
			//pw 모자이크 처리
			
			text = URLEncoder.encode("찾으시는 비밀번호는 "+pw+" 입니다", "UTF-8");
			link = request.getContextPath()+"/login.do";
		}
		
		String param = "text="+text+"&link="+link;
		return param;
	}

}
