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
import poly.service.impl.SignBookService;

@Controller
public class SignBookController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "SignBookService")
	private SignBookService signBookService;
	
	@RequestMapping(value = "/signBook/signBookList")
	public String signBookList(ModelMap model, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + " signBookList start");
		
		List<SignBookDTO> rList= signBookService.getSignBookList();
		
		if (rList == null) {
			rList = new ArrayList<>();
		}
		
		model.addAttribute("rList", rList);

		rList = null;

		log.info("signBookList end");

		return "/signBook/signBookList";
	}

	
	@RequestMapping(value = "/signBook/signBookDetail")
	public String signBookDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " signBookDetail start");
		
		String post_no = request.getParameter("no");
		log.info(post_no);
		SignBookDTO pDTO = new SignBookDTO();
		pDTO.setPost_no(post_no);
		
		SignBookDTO rDTO = signBookService.getSignBookDetail(pDTO);
		log.info(rDTO);
		if(rDTO==null) {
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/signBook/signBookList.do");
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);

		return "/signBook/signBookDetail";
	}
	
}
