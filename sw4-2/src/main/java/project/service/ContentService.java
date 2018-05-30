package project.service;

import org.springframework.stereotype.Service;

import project.bean.ContentDto;

@Service
public interface ContentService {
	
	public ContentDto list();
	
}
