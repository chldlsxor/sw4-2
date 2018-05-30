package project.repository;

import org.springframework.stereotype.Repository;

import project.bean.MemberDto;

@Repository
public interface MemberDao {
	void register(MemberDto memberDto);
	boolean login(MemberDto memberDto);
	void reset_pw(MemberDto memberDto);
}
