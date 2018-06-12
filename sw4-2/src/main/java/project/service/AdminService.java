package project.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public interface AdminService {
	void delete_report(HttpServletRequest request);
	void edit_user();
	void delete_member();
}
