package poly.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StudyController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "/study/studyForm")
	public String studyForm() {
		log.info(this.getClass().getName() + " studyForm start");
		
		return "/study/studyForm";
	}
	
	@RequestMapping(value = "/study/studyList")
	public String studyList() {
		log.info(this.getClass().getName() + " studyList start");
		
		return "/study/studyList";
	}
	
	@RequestMapping(value = "/study/editStudyDetail")
	public String editStudyDetail() {
		log.info(this.getClass().getName() + " editStudyDetail start");
		
		return "/study/editStudyDetail";
	}
}
