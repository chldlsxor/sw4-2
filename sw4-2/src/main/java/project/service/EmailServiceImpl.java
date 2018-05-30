package project.service;

import java.util.Properties;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service("emailService")
public class EmailServiceImpl implements EmailService{

	@Override
	public int send_email(String id) {
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		
		sender.setHost("smtp.hanmail.com");
		sender.setPort(587);
		sender.setUsername("chldlsxor03@hanmail.net");
		sender.setPassword("tmvmfld123");
		
		Properties option = new Properties();
		option.put("mail.transport.protocol", "smtp");	//전송 방법
		option.put("mail.smtp.auth", "true");	// 인증 활성화
		option.put("mail.debug", "true");		//디버그 활성화
		option.put("mail.smtp.starttls.enable", "true");//암호화 활성화
		sender.setJavaMailProperties(option);
		
		SimpleMailMessage message = new SimpleMailMessage();
		int num = (int)(Math.random()*90000)+10000;
		message.setSubject("인증번호");
		message.setText("인증번호 : "+String.valueOf(num));
		message.setFrom("instargram");
		message.setTo(id);
		
		sender.send(message);
		
		return num;
	}

}
