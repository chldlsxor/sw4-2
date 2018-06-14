package project.filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Component
public class CountFilter implements Filter{
	
	//누적 관리하기 위한 저장소
	private Map<String, Integer> sessionCountMap = new TreeMap<>(Collections.reverseOrder());
	private Map<String, Integer> requestCountMap = new TreeMap<>(Collections.reverseOrder());
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	private String dir;
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpSession session = request.getSession();
		if(session.isNew()) {
			//세션 증가 함수
			increaseSessionCount();
		}
		//요청 증가 함수
		increaseRequestCount();
		
		//통과 하여 실행
		arg2.doFilter(arg0, arg1);
		
	}
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		//필터 초기화 될때 --> 데이터 초기화 , 불러오기 수행
		log.info("필터 초기화");
		this.dir = filterConfig.getServletContext().getRealPath("");
		log.info("현재 경로 :{}", dir);
		//loadCount(dir);
		
		//모든 사용자의 요청에서 접근할 수 있도록 application에 저장소 설정
		filterConfig.getServletContext().setAttribute("scMap", sessionCountMap);
		filterConfig.getServletContext().setAttribute("rcMap", requestCountMap);
	}
	
	@Override
	public void destroy() {
		//필터 종료 --> 데이터 저장
		log.info("필터 종료");
		//saveCount(dir);
	}
	
	//세션 증가
	private void increaseSessionCount(){
		String today = getToday();
		Integer sessionCount = sessionCountMap.get(today);
		if(sessionCount == null) sessionCount = 0;
		sessionCount++;
		sessionCountMap.put(today, sessionCount);
		log.info("[{}]신규 세션 발생 : {}", today, sessionCount);
	}
	//요청 증가
	private void increaseRequestCount() {
		String today = getToday();
		Integer requestCount = requestCountMap.get(today);
		if(requestCount == null) requestCount = 0;
		requestCount++;
		requestCountMap.put(today, requestCount);
		log.info("[{}]신규 리퀘스트 발생 : {}", today, requestCount);
	}
	//오늘 날짜 반환
	private String getToday() {
		Date d = new Date();
		Format f = new SimpleDateFormat("yyyy-MM-dd");
		return f.format(d);
	}
	//파일 저장
	private void saveCount(String dir) {
		File target = new File(dir, "count.db");
		try(ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(target));){
			out.writeObject(requestCountMap);
			out.writeObject(sessionCountMap);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	private void loadCount(String dir) {
		File target = new File(dir, "count.db");
		try(ObjectInputStream in = new ObjectInputStream(new FileInputStream(target));){
			requestCountMap = (Map<String, Integer>) in.readObject();
			sessionCountMap = (Map<String, Integer>) in.readObject();
		}catch(Exception e) {
			requestCountMap = new TreeMap<>(Collections.reverseOrder());
			sessionCountMap = new TreeMap<>(Collections.reverseOrder());
		}
	}
}
