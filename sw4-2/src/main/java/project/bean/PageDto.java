package project.bean;

import lombok.Data;

@Data
public class PageDto {
	private int list_num, boardcount, pageNo;
	private String  pageStr;
	
	private int boardstart, boardfinish;
	
	private int blocksize = 10, blockstart, blockfinish, blockmax;
	
	private boolean searchMode;
	
	private String keyword_type, keyword, order_type, order, power;
	
	private String url;
	
	//생성자에서 필요한 정보를 받아 모든 내용을 계산
	/*private BoardDao bdao = new BoardDao();
	public PagingUtil(HttpServletRequest request) {
		this.type = request.getParameter("type");
		this.keyword = request.getParameter("keyword");
		
		this.searchMode = this.type != null && this.keyword != null;
		
		try {
			if(searchMode)
				boardcount = bdao.getCount(type, keyword);
			else
				boardcount = bdao.getCount();
		}catch(Exception e) {}
		
		this.pageStr = request.getParameter("page");
		pageCalculate();
		navigationCalculate();
	}
	
	private void navigationCalculate() {
		blockstart = (pageNo - 1) / blocksize * blocksize + 1;
		blockfinish = blockstart + blocksize - 1;
		
		//블럭번호는 페이지 개수를 넘어갈 수 없다
		blockmax = (boardcount + boardsize - 1) / boardsize;
		if(blockmax < blockfinish) blockfinish = blockmax;
		
		//네비게이터 계산 종료
		
		//검색어를 주소에 첨부하기 위한 변수 생성
		url = "";
		if(searchMode)
			url = "&type="+type+"&keyword="+keyword;
		url = url.replace("+", "%2B");
	}

	//페이징 관련 변수 계산 메소드
	private void pageCalculate() {
		try {
			this.pageNo = Integer.parseInt(pageStr);
			if(this.pageNo < 0) throw new Exception();
		}catch(Exception e) {
			this.pageNo = 1;
		}
		
		this.boardcount = boardcount;
		
		this.boardfinish = pageNo * boardsize;
		this.boardstart = boardfinish - (boardsize - 1);
	}*/
	
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
