package spring.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice(basePackages= {"project.controller"})
public class ExceptionController {
	Logger log = LoggerFactory.getLogger(getClass());
	
	//예외를 처리하는 컨트롤러 추가
	@ExceptionHandler(Exception.class)
	public String ex3(Model model, Exception e) {
		log.info("예외 발생!");
		log.error("오류 발생", e);
		model.addAttribute("msg", "잘못된 요청입니다.");
		model.addAttribute("go", "login");
		return "redirect:/result";
	}
}
