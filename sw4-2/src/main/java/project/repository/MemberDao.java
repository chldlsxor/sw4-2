package project.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import project.bean.MemberDto;

@Repository
public interface MemberDao {
	void register(MemberDto memberDto);
	boolean login(MemberDto memberDto);
	void exit(String id);
	void reset_pw(MemberDto memberDto);
	MemberDto get(String id);
	MemberDto get_by_nick(String nick);
	String getSalt(String id);
	int getLoop(String id);
	List<MemberDto> member_list();
	boolean select_id(String id);
	void edit(MemberDto memberDto);
	boolean select_nick(String nick);
	List<MemberDto> search_member(String name);
}
