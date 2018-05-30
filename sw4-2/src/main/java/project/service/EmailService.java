package project.service;

import org.springframework.stereotype.Service;

@Service
public interface EmailService {
	int send_email(String id);
}
