package project.test;

import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import project.bean.MemberDto;
import project.repository.MemberDao;
import project.service.EncryptService;

//192.168.0.170:9090/apex/f?p=4500

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:/spring/application-config.xml")
public class test {

	@Autowired MemberDao memberDao;
	
	@Autowired 
	private EncryptService sha256;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Test
	public void register() throws NoSuchAlgorithmException {
		//log.info("memberDao = {}", memberDao);
		String id = "idid";
		String name = "namename";
		String nick = "nicknick";
		String pw = "pwpw";
		
		MemberDto memberDto = new MemberDto();
		memberDto.setId(id);
		memberDto.setName(name);
		memberDto.setNick(nick);
		memberDto.setPw(pw);
		memberDto.setLoop((int)(Math.random()*9)+1);
		memberDto.setSalt(UUID.randomUUID().toString());
		String encpw = sha256.encrypt(memberDto.getPw(), memberDto.getSalt(), memberDto.getLoop());
		memberDto.setPw(encpw);
		
		memberDao.register(memberDto);
	}
}
