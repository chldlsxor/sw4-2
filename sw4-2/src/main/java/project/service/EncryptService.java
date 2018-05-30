package project.service;

import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Service;

@Service
public interface EncryptService {
	String encrypt(String origin, String salt, int loop) 
			throws NoSuchAlgorithmException;
}
