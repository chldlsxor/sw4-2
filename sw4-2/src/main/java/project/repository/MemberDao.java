package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.MemberDto;

@Repository
public interface MemberDao {
	void register(MemberDto memberDto);
	boolean login(MemberDto memberDto);
	void reset_pw(MemberDto memberDto);
	MemberDto get(String id);
	String getSalt(String id);
	int getLoop(String id);
	List<MemberDto> member_list();
	boolean select_id(String id);
	void edit(MemberDto memberDto);
	boolean select_nick(String nick);
	List<MemberDto> select_member(String name);
}
