package project.bean;

import lombok.Data;

@Data
public class BoardDto {
	int no, report;
	String writer,content,reg,good,nick,open, scrap;
}
