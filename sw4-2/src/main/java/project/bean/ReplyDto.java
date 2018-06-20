package project.bean;
import lombok.Data;

@Data
public class ReplyDto {
	int no,bno,gno, recnt;
	String id,content,good,reg,nick;
	String[] loveList;
	int loveSize;
}
