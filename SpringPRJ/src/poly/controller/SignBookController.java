package poly.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.StudyDTO;

@Controller
public class SignBookController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "/signBook/signBookList")
	public String signBookList() {
		log.info(this.getClass().getName() + " signBookList start");

		return "/signBook/signBookList";
	}
	
	@RequestMapping(value = "/signBook/listTest")
	public String listTest() {
		log.info(this.getClass().getName() + " listTest start");

		return "/signBook/listTest";
	}

	
}
