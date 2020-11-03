package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.dto.SignBookDTO;
import poly.service.ISignBookService;
import poly.util.Pagination;

@Controller
public class SignBookController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "SignBookService")
	private ISignBookService SignBookService;
	
	@RequestMapping(value = "/signBook/signBookList")
	public String signBookList(ModelMap model, HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue = "1")int page) throws Exception {
		log.info(this.getClass().getName() + " signBookList start");
		
		//페이징 로직
		int listCnt = SignBookService.getSignBookListCnt();
		Pagination pg = new Pagination(listCnt, page);
		model.addAttribute("pg", pg);
		
		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		
		log.info(start);
		log.info(end);
		
		//리스트 불러오기 로직
		List<SignBookDTO> rList= SignBookService.getSignBookList(start, end);
		
		if (rList == null) {
			rList = new ArrayList<SignBookDTO>();
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
		
		SignBookDTO rDTO = SignBookService.getSignBookDetail(pDTO);
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
