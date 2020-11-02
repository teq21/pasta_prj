package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.SignBookDTO;
import poly.dto.StudyDTO;
import poly.service.impl.SignBookService;
import poly.service.impl.StudyService;

@Controller
public class SignBookController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "SignBookService")
	private SignBookService signBookService;
	
	@RequestMapping(value = "/signBook/signBookList")
	public String signBookList(ModelMap model, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + " signBookList start");
		
		List<SignBookDTO> rList = signBookService.getSignBookList();
		
		if (rList == null) {
			rList = new ArrayList<>();
		}
		
		model.addAttribute("rList", rList);

		rList = null;

		log.info("signBookList end");

		return "/signBook/signBookList";
	}

	
	@RequestMapping(value = "/signBook/signBookDetail")
	public String signBookDetail() {
		log.info(this.getClass().getName() + " signBookDetail start");

		return "/signBook/signBookDetail";
	}
	
}
