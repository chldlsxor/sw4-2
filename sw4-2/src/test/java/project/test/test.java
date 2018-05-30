package project.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import project.bean.MemberDto;
import project.repository.MemberDao;

//192.168.0.170:9090/apex/f?p=4500

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:/spring/application-config.xml")
public class test {

	@Autowired MemberDao memberDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Test
	public void register() {
		log.info("memberDao = {}", memberDao);
		String id = "idid";
		String name = "namename";
		String nick = "nicknick";
		String pw = "pwpw";
		
		MemberDto memberDto = new MemberDto();
		memberDto.setId(id);
		memberDto.setName(name);
		memberDto.setNick(nick);
		memberDto.setPw(pw);
		
		memberDao.register(memberDto);
	}
}
