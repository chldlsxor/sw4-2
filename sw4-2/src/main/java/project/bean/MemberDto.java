package project.bean;

import lombok.Data;
import oracle.sql.CLOB;

//192.168.0.170:9090/apex/f?p=4500

@Data
public class MemberDto {
	String id, name, nick, pw, power, profile, open, scrap;
	int no;
}
