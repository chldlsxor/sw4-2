package project.bean;

import lombok.Data;

@Data
public class PageDto {
	private int list_num, boardcount, pageNo;
	private String  pageStr;
	
	private int boardstart, boardfinish;
	
	private int blocksize = 10, blockstart, blockfinish, blockmax;
	
	private boolean searchMode;
	
	private String keyword_type, keyword, order_type, order, power = "회원";
	
	private String url;
	
	//상태 판정 메소드
	public boolean isNotFirst() {
		return getPageNo() > 1;
	}
	public boolean isNotFirstBlock() {//첫블럭이 아니냐?
		return getBlockstart() > 1;
	}
	
	public boolean isNotLast() {//마지막이 아니냐?
		return getPageNo() < getBlockmax();
	}
	
	public boolean isNotLastBlock() {
		return getBlockfinish() < getBlockmax();
	}
}
