package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.service.impl.VideoService;
@Controller
public class TmController {
	@Resource(name = "VideoService")
	private VideoService videoservice;
	private Logger log = Logger.getLogger(this.getClass());
	
	


	//비디오가져오는 로직시작
	@RequestMapping(value = "/model")
	public String getvideoes(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
	
		log.info(this.getClass().getName() + "model.do ok!");
	
		
		
		String result= videoservice.getvideo();
		log.info("result >>> "+result) ;
		model.addAttribute("result", result);
		 
		/*
		 * if(result!=null) { log.info("객체담기실패"); }
		 */
		return "/index";
		
		}
		
		
	

}