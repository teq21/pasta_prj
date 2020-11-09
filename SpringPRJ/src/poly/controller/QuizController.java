package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.QuizDTO;
import poly.service.impl.QuizService;

@Controller
public class QuizController {

	@Resource(name = "QuizService")
	private QuizService QuizService;
	// 로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());
	
	
// quiz 인덱스 화면으로 이동
	@RequestMapping(value = "/quiz", method = RequestMethod.GET)
	public String Index2() {
		log.info(this.getClass());
		return "/quiz/quiz_index";
	}
	
//type 1 리스트 불러오는 컨트롤러
	@RequestMapping(value = "/quiz/type1", method = RequestMethod.GET)
	public String Index4(ModelMap model, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + " getquizList start");

		
		List<QuizDTO> rList= QuizService.getQuizList();
		
		
		if (rList == null) {
			rList = new ArrayList<>();
		}
		
		model.addAttribute("rList", rList);

		rList = null;

		log.info("QuizList end");

		return "/quiz/type1";
	}
	
	
	//type 1 (단어풀이 detail 가는 컨트롤러)
	@RequestMapping(value = "/quiz/type1detail")
	public String type1detail(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + " QuuzkDetail start");
		
		String sign_name= request.getParameter("sign_name");
		log.info(sign_name);
		
		QuizDTO pDTO = new QuizDTO();
		
		pDTO.setSign_name(sign_name);
		log.info(sign_name+"=====>sign_name pdto로 보내서 받아온값"); 
		QuizDTO rDTO = QuizService.getQuizDetail(pDTO);
		log.info(rDTO);
		
		if(rDTO==null) {
			
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			
			model.addAttribute("url", "/quiz/type1.do");
			
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);
		log.info(rDTO.getTm_path()+"===== RDTO 에서 받아온 TMPAHTS");
		log.info(rDTO.getSign_name());
		
		return "/quiz/type1detail";
	}
	
	             
	//type 2 리스트 불러오는 컨트롤러   
		@RequestMapping(value = "/quiz/type2", method = RequestMethod.GET)
		public String getType2List(ModelMap model, HttpServletRequest request) throws Exception {
			log.info(this.getClass().getName() + " getquizList start");

			
			List<QuizDTO> rList= QuizService.getQuizList2();
			
			
			if (rList == null) {
				rList = new ArrayList<>();
			}
			
			model.addAttribute("rList", rList);

			rList = null;

			log.info("QuizList end");

			return "/quiz/type2";
		}
		
		//type 2(단어풀이 detail 가는 컨트롤러)      /quiz/type2detail.do
		@RequestMapping(value = "/quiz/type2detail")
		public String type2detail(HttpServletRequest request, ModelMap model) throws Exception {
			log.info(this.getClass().getName() + " QuuzkDetail start");
			
			String sign_name= request.getParameter("sign_name");
			log.info(sign_name);
			
			QuizDTO pDTO = new QuizDTO();
			
			pDTO.setSign_name(sign_name);
			log.info(sign_name+"=====>sign_name pdto로 보내서 받아온값"); 
			QuizDTO rDTO = QuizService.getQuizDetail2(pDTO);
			log.info(rDTO);
			
			if(rDTO==null) {
				
				model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
				
				model.addAttribute("url", "/quiz/type2.do");
				
				return "/redirect";
			}
			
			model.addAttribute("rDTO", rDTO);
			log.info(rDTO.getTm_path()+"===== RDTO 에서 받아온 TMPAHTS");
			log.info(rDTO.getSign_name());
			
			return "/quiz/type2detail";
		}
		
}
