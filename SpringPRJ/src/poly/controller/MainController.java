package poly.controller;

import org.apache.log4j.Logger;
//import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class MainController {
	
	// 로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());


//	@RequestMapping(value="index")
//	public String Index() {
//		log.info(this.getClass());
//		
//		return "/index";
//	}

	
	

	
	
	/*
	 * @RequestMapping(value = "/model", method = RequestMethod.GET) public String
	 * Index() { log.info(this.getClass().getName() + "model.do ok!"); return
	 * "/index"; }
	 * 
	 */
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String Index2() {
		log.info(this.getClass());
		return "/index";
	}

	@RequestMapping(value = "mai", method = RequestMethod.GET)
	public String Index1() {
		log.info(this.getClass());
		return "/aa";
	}
	
}

