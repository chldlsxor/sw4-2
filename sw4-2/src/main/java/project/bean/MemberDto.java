package project.bean;

import lombok.Data;

@Data
public class MemberDto {
	String id,name,nick,pw,power,profile,open,scrap, salt;
	int no, loop;

}
