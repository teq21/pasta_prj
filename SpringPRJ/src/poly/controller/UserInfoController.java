package poly.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.dto.UserInfoDTO;
import poly.service.impl.UserInfoService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Controller
public class UserInfoController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserInfoService")
	private UserInfoService userInfoService;

	// 회원가입 화면으로 이동

	@RequestMapping(value = "/user/login_register")
	public String login_register() {
		log.info(this.getClass().getName() + "login_register ok!");

		return "/user/login_register";
	}

	// 이메일 중복확인 체크 요청
	@PostMapping("/user/emailCheck")
	public @ResponseBody Map<String, Object> confirmEmail(@RequestBody String userEmail) throws Exception {
		// 클라이언트에 비동기 통신으로 받아줘야하니까 @ReqeustBody를 사용한다.

		// 값확인
		System.out.println("중복 확인 요청된 이메일 : " + userEmail);

		Map<String, Object> datavalue = new HashMap<>();

		// 서비스 측에 요청
		int result = userInfoService.isDuplicateEmail(userEmail);

		if (result == 0) {
			System.out.println("이메일 사용 가능!");
			datavalue.put("confirm", "OK");
		} else {
			System.out.println("이메일 중복! 사용 불가!");
			datavalue.put("confirm", "NO");
		}

		return datavalue;
	}

	// 회원가입 로직 처리
	@RequestMapping(value = "/user/register", method = RequestMethod.POST)
	public String insertUserInfo(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr)
			throws Exception {
		log.info(this.getClass().getName() + ".insertuserinfo start!");

		// 회원가입 결과에 대한 메세지를 전달할변수
		String msg = "";
		// 회원정보입력 화면에서 받는 정보를 저장할변수
		UserInfoDTO pDTO = null;

		try {
			// 휘원정보 입력화면에서 받는 정보를 string 변수에 저장시갖
			// 무조건 웹으로 받는 정보는 dto에 저장하기위해 임시로 string 변수에 저장함

			String EMAIL = CmmUtil.nvl(request.getParameter("email"));
			String USER_NAME = CmmUtil.nvl(request.getParameter("user_name"));
			String PASSWORD = CmmUtil.nvl(request.getParameter("password"));

			// 회원 정보 입력화면ㅅ에서 STRING 변수에 저장끝
			// 무조건 웹으로 받은 정보는 DTO에 저장하기위해 임시로 STRING 변수에 저장함

			// 반드시 값을 받았으면 꼭 로그를 찍어서 값이 제데로 들어가느지 파악해야함

			log.info("EMAIL" + EMAIL);
			log.info("USER_NAME" + USER_NAME);
			log.info("PASSWORD" + PASSWORD);

			// 회원정보 입력화면ㅅ에서 받는정보를 DTO에 저장하기 시작
			// 무조건 웹으로 받은 정보는 dto에 저장해야 한다고 이해하길 권함

			pDTO = new UserInfoDTO();

			// 민감 정보인 이메일은 AES128-CBC로 암호화함
			pDTO.setEmail(EMAIL);
			pDTO.setUser_name(USER_NAME);
			// 비밀번호는 절대로 복호화 되지않도록 해시 알고르지음으로 암호화함
			pDTO.setPassword(EncryptUtil.encHashSHA256(PASSWORD));

			// 회원가입

			int res = userInfoService.insertUserInfo(pDTO);

			if (res == 1) {

				msg = "회원가입 되었습니다";

				// 추후 회원가입 입력 화면에서 ajax를 활용해서 아이디중복, 이메일 중복을 체크하길 바람

			} else if (res == 2) {
				msg = "이미 가입된 이메일 주소입니다";
			} else {
				msg = "오류로 인해 회원가입이 실패하였습니다";
			}

		} catch (Exception e) {
			// 저장이 실패되면 사용자에게 보여줄 메세지
			msg = "실패하였습니다" + e.toString();
			log.info(e.toString());
			e.printStackTrace();
		} finally {
			log.info(this.getClass().getName() + ".insertUserInfo end!");

			// 회원가입 여부결과 메세지 전달하기
			rttr.addFlashAttribute("msg", msg);

			// 회원가입 여부 결과메시지 전달하기
			rttr.addFlashAttribute("pDTO", pDTO);

			pDTO = null;
		}
		return "redirect:/msg.do";
	}
	
	//로그인처리 함수
	@PostMapping(value = "/user/getUserLoginCheck")
	public @ResponseBody Map<Object, Object> getUserLoginCheck(@RequestBody UserInfoDTO userInfo,HttpSession session, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + ".getuserlogincheck start123456!");
		log.info("request userInfo >>>>>"+userInfo.toString());
		// 로그인 처리결과를 저장할변수 (로그인성공:1, 아이디, 비밀번호 불일치로인한 실패:0, 시스템에러:2)
		int res = 0;
		session = request.getSession();
		
		// 웹(회원정보 입력화면)에서 받는 정보를 저장할 변수
		UserInfoDTO pDTO = null;
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		
		try {
			// 회원정보 입력화면에서 받는 정보를 String 변수에 저장시작!
			// 무조건 웹으로 받은 정보는 DTO에 저장하기위해 임시로 STring 변수에 저장함

			String email = CmmUtil.nvl(userInfo.getEmail());// 이메일
			String password = CmmUtil.nvl(userInfo.getPassword());// 비밀번호
			
			
			pDTO = new UserInfoDTO();

			pDTO.setEmail(email);

			pDTO.setPassword(EncryptUtil.encHashSHA256(password));

			res = userInfoService.getUserLoginCheck(pDTO);

			if (res == 1) {
				session.setAttribute("ss_email", email);
			}

		} catch (Exception e) {
			res = 2;
			e.printStackTrace();
		} finally {

			resultMap.put("loginResult", res);
			pDTO = null;
		}

		return resultMap;

	}
}
