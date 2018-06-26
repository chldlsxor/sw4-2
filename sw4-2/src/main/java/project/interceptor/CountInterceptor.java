package project.interceptor;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.ProcessHandle.Info;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CountInterceptor extends HandlerInterceptorAdapter{
	private Logger log = LoggerFactory.getLogger(getClass());
	
	//누적 관리하기 위한 저장소
	private Map<String, Integer> sessionCountMap = new TreeMap<>(String.CASE_INSENSITIVE_ORDER);
	
	//경로
	private String dir = "E:\\sw4-2\\session\\";
			
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		log.info("카운트 인터셉터 초기화");
		loadCount(dir);
		
		//application 저장소
		request.getServletContext().setAttribute("scMap", sessionCountMap);
		log.info("scMap", sessionCountMap);
		//dir : E:\soyeon\6.spring\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sw4-2\
		
		log.info("preHandle : {}", handler);//필터 비스므리
		HttpSession session = request.getSession();
		
		//방문자 확인용
		log.info("session : {}", session.getAttribute("instory"));
		if(session.getAttribute("instory")==null) {
			session.setAttribute("instory", "instory");
			//세션 증가 함수
			increaseSessionCount();			
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
		ModelAndView modelAndView) throws Exception {
		saveCount(dir);
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
	//오늘 날짜 반환
	private String getToday() {
		Date d = new Date();
		Format f = new SimpleDateFormat("yyyy-MM-dd");
		return f.format(d);
	}
	//파일 저장
	private void saveCount(String dir) {
		String fname = getToday().substring(0, 7);
		File target = new File(dir, fname+".db");
		try(ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(target));){
			out.writeObject(sessionCountMap);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	private void loadCount(String dir) {
		String fname = getToday().substring(0, 7);
		File target = new File(dir, fname+".db");
		try(ObjectInputStream in = new ObjectInputStream(new FileInputStream(target));){
			sessionCountMap = (Map<String, Integer>) in.readObject();
		}catch(Exception e) {
			sessionCountMap = new TreeMap<>(String.CASE_INSENSITIVE_ORDER);
		}
	}
}
