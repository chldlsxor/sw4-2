package project.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	
	private Logger log = LoggerFactory.getLogger(getClass());

	@Override
	public boolean login(HttpServletRequest request, 
			HttpServletResponse response, 
			HttpSession session, MemberDto memberDto) throws NoSuchAlgorithmException{
		//비밀번호 암호화
		String id = memberDto.getId();
		String encpw = sha256.encrypt(memberDto.getPw(), memberDao.getSalt(id), memberDao.getLoop(id));
		
		log.info("아이디 {}, 비번 {}", id, encpw);
		
		memberDto.setPw(encpw);

		//아이디화 암호화된 비번으로 로그인
		//성공하면 true 아니면 false
		if(memberDao.login(memberDto)) {									//로그인 성공
			
			//세션에 로그인 성공에 관련된 데이터를 추가
			//이름 : userid, 값 : 사용자ID
			session.setAttribute("userid", id);
			
			MemberDto mdto = memberDao.get(id);
			session.setAttribute("userno", mdto.getNo());

			//이름 : power, 값 : 사용자 권한
			/*MemberDto mdto2 = memberDao.get(memberDto.getId());
			session.setAttribute("power", memberDto.getPower());*/
			return true;
		}
		else {																	//로그인 실패
			return false;
		}
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
	public void reset_pw(MemberDto memberDto) throws NoSuchAlgorithmException {	
		//비밀번호 재설정
		memberDto.setLoop((int)(Math.random()*9)+1);
		memberDto.setSalt(UUID.randomUUID().toString());
		String encpw = sha256.encrypt(memberDto.getPw(), memberDto.getSalt(), memberDto.getLoop());
		memberDto.setPw(encpw);
		
		memberDao.reset_pw(memberDto);
	}

	@Override
	public boolean select_id(String id) {
		return memberDao.select_id(id);
	}
}
