package project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter{
private Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("관리자 인터셉터 실행{}",request.getSession().getAttribute("userpwr"));
		if(request.getSession().getAttribute("userpwr").equals("회원")) {
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		else
			return true;
		
	}
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.info("관리자 인터셉터 종료");
		super.postHandle(request, response, handler, modelAndView);
	}
}
