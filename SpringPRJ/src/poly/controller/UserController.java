package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.UserDTO;
import poly.service.IUserService;
import poly.util.CmmUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class UserController {

	// 로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨) static 선언 방식 기반의 싱글톤패턴
	 */
	@Resource(name = "UserService")
	private IUserService userService;

	@RequestMapping(value = "user/userLogin")
	public String userLogin() {
		log.info(this.getClass().getName() + ".userLogin start");
		log.info(this.getClass().getName() + ".userLogin end");
		return "/user/userLogin";
	}

	@RequestMapping(value = "user/userLoginProc")
	public String userLoginProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".user/userLoginProc start");

		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		String password = CmmUtil.nvl(request.getParameter("password"));

		log.info("user_id : " + user_id);
		log.info("password : " + password);

		UserDTO pDTO = new UserDTO();
		pDTO.setUser_id(user_id);
		pDTO.setPassword(password);

		UserDTO rDTO = userService.getUserInfo(pDTO);
		String msg;
		String url = "/";

		if (rDTO == null) {
			msg = "로그인 실패";
		} else {
			msg = "로그인 성공";
			session.setAttribute("user_name", rDTO.getUser_name());
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info(this.getClass().getName() + ".user/userLoginProce end");
		return "/redirect";
	}

	@RequestMapping(value = "user/logOut")
	public String logOut(HttpSession session, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".user/logOut start");

		session.invalidate();

		model.addAttribute("msg", "로그아웃 성공");
		model.addAttribute("url", "/");

		log.info(this.getClass().getName() + ".user/logOut end");
		return "/redirect";
	}
}
