package project.bean;

import lombok.Data;

@Data
public class NoticeDto {
	String receiver,sender,reg;
	int type,read,bno;
}
