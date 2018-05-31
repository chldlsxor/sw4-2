package project.service;

import java.io.UnsupportedEncodingException;
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
			HttpSession session, MemberDto memberDto) throws UnsupportedEncodingException {
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
		//비밀번호 규칙 정하기
		memberDto.setLoop((int)(Math.random()*9)+1);
		memberDto.setSalt(UUID.randomUUID().toString());
		String encpw = sha256.encrypt(memberDto.getPw(), memberDto.getSalt(), memberDto.getLoop());
		memberDto.setPw(encpw);
		
		//회원가입하기
		memberDao.register(memberDto);
	}

	@Override
	public void reset_pw(MemberDto memberDto, HttpServletRequest request) {	
		//비밀번호 재설정
		memberDao.reset_pw(memberDto);
	}

}
