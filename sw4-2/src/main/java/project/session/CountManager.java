package project.session;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CountManager implements HttpSessionListener {
    public static int count;
    
    private Logger log = LoggerFactory.getLogger(getClass());

    public static int getCount() {
        return count;
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
    	//세션이 만들어질 때 호출
    	
    	HttpSession session = se.getSession(); //request에서 얻는 session과 동일한 객체
    	session.setMaxInactiveInterval(60*20);

    	count++;

    	log.info(session.getId() + " 세션생성 " + ", 접속자수 : " + count);
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
    	 //세션이 소멸될 때 호출
        count--;
        if(count<0)
            count=0;

        HttpSession session = se.getSession();
        log.info(session.getId() + " 세션소멸 " + ", 접속자수 : " + count);
    }

}
