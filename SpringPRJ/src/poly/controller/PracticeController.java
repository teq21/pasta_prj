package poly.controller;

import javax.servlet.http.HttpServletRequest;
import static poly.util.CmmUtil.nvl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class PracticeController {

	@RequestMapping(value="practice")
	public String practice() {
		return "/practice";
	}
	
	@RequestMapping(value="table")
	public String table() {
		return "/table";
	}
	
	@RequestMapping(value="get")
	public String get(HttpServletRequest request, ModelMap model) 
			throws Exception{
		String name = nvl(request.getParameter("name"));
		
		model.addAttribute("name", name);
		return "/get";
	}
	
	@RequestMapping(value="post")
	public String post() {
		return "/postForm";
	}
	
	@RequestMapping(value="doPost", method = RequestMethod.POST)
	public String doPost(HttpServletRequest request, ModelMap model) 
			throws Exception{
		String name = nvl(request.getParameter("name"));
		
		model.addAttribute("name", name);
		return "/get";
	}
	
	
}


