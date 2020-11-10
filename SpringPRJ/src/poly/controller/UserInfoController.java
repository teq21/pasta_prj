package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.dto.MailDTO;
import poly.dto.UserInfoDTO;
import poly.service.impl.MailService;
import poly.service.impl.UserInfoService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Controller
public class UserInfoController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserInfoService")
	private UserInfoService userInfoService;
	
	@Resource(name = "MailService")
	private MailService mailService;

	// 회원가입 화면으로 이동

	@RequestMapping(value = "/user/login_register")
	public String login_register() {
		log.info(this.getClass().getName() + "login_register ok!");

		return "/user/login_register";
	}

	// 이메일 중복확인 체크 요청
	@PostMapping("/user/emailCheck")
	public @ResponseBody Map<String, Object> confirmEmail(@RequestBody String email) throws Exception {
		// 클라이언트에 비동기 통신으로 받아줘야하니까 @ReqeustBody를 사용한다.

		// 값확인
		System.out.println("중복 확인 요청된 이메일 : " + email);

		Map<String, Object> datavalue = new HashMap<>();

		// 서비스 측에 요청
		int result = userInfoService.isDuplicateEmail(email);

		if (result == 0) {
			System.out.println("이메일 사용 가능!");
			datavalue.put("confirm", "OK");
		} else {
			System.out.println("이메일 중복! 사용 불가!");
			datavalue.put("confirm", "NO");
		}

		return datavalue;
	}
	
	@RequestMapping(value = "/msg")
	public String msg() {
		log.info(this.getClass().getName() + "login_register ok!");

		return "/msg";
	}

	// 회원가입 로직 처리
	@RequestMapping(value = "/user/register", method = RequestMethod.POST)
	public String insertUserInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model, @ModelAttribute UserInfoDTO uDTO)
			throws Exception {
		log.info(this.getClass().getName() + "register start!");

		// 회원가입 결과에 대한 메세지를 전달할변수
		// 회원정보입력 화면에서 받는 정보를 저장할변수
		UserInfoDTO pDTO = new UserInfoDTO();
		
		String msg = "";
		String url = "";

		try {
			// 휘원정보 입력화면에서 받는 정보를 string 변수에 저장시갖
			// 무조건 웹으로 받는 정보는 dto에 저장하기위해 임시로 string 변수에 저장함

			String email = CmmUtil.nvl(request.getParameter("email"));
			String user_name = CmmUtil.nvl(request.getParameter("user_name"));
			String password = CmmUtil.nvl(request.getParameter("password"));
			String phone = CmmUtil.nvl(request.getParameter("phone"));
			String have_sign = CmmUtil.nvl(request.getParameter("have_sign"));

			// 회원 정보 입력화면ㅅ에서 STRING 변수에 저장끝
			// 무조건 웹으로 받은 정보는 DTO에 저장하기위해 임시로 STRING 변수에 저장함

			// 반드시 값을 받았으면 꼭 로그를 찍어서 값이 제데로 들어가느지 파악해야함

			log.info("email : " + email);
			log.info("user_name : " + user_name);
			log.info("password : " + password);
			log.info("phone : " + phone);
			log.info("have_sign : " + have_sign);

			// 회원정보 입력화면ㅅ에서 받는정보를 DTO에 저장하기 시작
			// 무조건 웹으로 받은 정보는 dto에 저장해야 한다고 이해하길 권함


			// 민감 정보인 이메일은 AES128-CBC로 암호화함
			pDTO.setEmail(EncryptUtil.encAES128CBC(email));
			pDTO.setUser_name(user_name);
			// 비밀번호는 절대로 복호화 되지않도록 해시 알고르지음으로 암호화함
			pDTO.setPassword(EncryptUtil.encHashSHA256(password));
			pDTO.setPhone(phone);
			pDTO.setHave_sign(have_sign);
			// 회원가입

			
			url = "/user/login_register.do";
			
			int res = userInfoService.insertUserInfo(pDTO);
			log.info(res);

			if (res == 1) {
				MailDTO mDTO = new MailDTO();
				mDTO.setTitle("Do it Sign 이메일 인증");
				String parameterEmail = uDTO.getEmail();
				log.info("parameter Email : " + parameterEmail);
				mDTO.setToMail(parameterEmail);
				StringBuilder content = new StringBuilder();
				content.append("아래 링크를 클릭하시면 이메일 인증이 완료됩니다.\n");
				content.append("http://localhost:8080/user/verifyEmail.do?code=");
				String code = EncryptUtil.encAES128CBC(parameterEmail + ",1");
				content.append(code);
				
				mDTO.setContents(content.toString());
				mailService.doSendMail(mDTO);

				msg = "회원 가입이 완료 되었습니다. 이메일 인증 메일을 확인해 주십시오.";

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
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);

			pDTO = null;
		}
		return "/redirect";
	}
	
	//로그인처리 함수
	@PostMapping(value = "/user/getUserLoginCheck")
	public @ResponseBody Map<Object, Object> getUserLoginCheck(@RequestBody UserInfoDTO uDTO, HttpSession session, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + ".getuserlogincheck start123456!");
		log.info("request userInfo >>>>>"+uDTO.toString());
		// 로그인 처리결과를 저장할변수 (로그인성공:1, 아이디, 비밀번호 불일치로인한 실패:0, 시스템에러:2)
		
		
		// 웹(회원정보 입력화면)에서 받는 정보를 저장할 변수
		UserInfoDTO pDTO = new UserInfoDTO();
		Map<Object, Object> resultMap = new HashMap<Object, Object>();
		
		String email = CmmUtil.nvl(uDTO.getEmail());// 이메일
		String password = CmmUtil.nvl(uDTO.getPassword());// 비밀번호
		
		pDTO = new UserInfoDTO();

		pDTO.setEmail(EncryptUtil.encAES128CBC(email));

		pDTO.setPassword(EncryptUtil.encHashSHA256(password));
		
		uDTO = userInfoService.forSession(pDTO);
		
		if(uDTO == null) {
			
			resultMap.put("loginResult", "0");
			
			return resultMap;
			
		}
		
		session.setAttribute("user_no", uDTO.getUser_no());
		session.setAttribute("state", uDTO.getState());
		session.setAttribute("user_type", uDTO.getUser_type());
		session.setAttribute("user_name", uDTO.getUser_name());
		
		resultMap.put("loginResult", "1");
		
		pDTO = null;
		
		return resultMap;
		
		/*try {
			// 회원정보 입력화면에서 받는 정보를 String 변수에 저장시작!
			// 무조건 웹으로 받은 정보는 DTO에 저장하기위해 임시로 STring 변수에 저장함

			String email = CmmUtil.nvl(uDTO.getEmail());// 이메일
			String password = CmmUtil.nvl(uDTO.getPassword());// 비밀번호
			
			pDTO = new UserInfoDTO();

			pDTO.setEmail(EncryptUtil.encAES128CBC(email));

			pDTO.setPassword(EncryptUtil.encHashSHA256(password));
			
			res = userInfoService.getUserLoginCheck(pDTO);
			
			if (res == 1) {
				
				 //user_no : 회원번호로 구분 / PK
				 //state : 유저 상태 구분 / 0 : 이상 없음 / 1 : 문제 있음
				 //user_type : 일반 유저와 관리자 구분 / 1 : 일반 유저 / 2 : 관리자
				 
				
				uDTO = userInfoService.forSession(uDTO);
				
				if(uDTO == null) {
					resultMap.put("loginResult", res);
				}
				
				session.setAttribute("user_no", uDTO.getUser_no());
				session.setAttribute("state", uDTO.getState());
				session.setAttribute("user_type", uDTO.getUser_type());
				
				
				resultMap.put("loginResult", res);
				log.info(resultMap.get("loginResult"));
				return resultMap;
			}

		} catch (Exception e) {
			res = 2;
			e.printStackTrace();
		} finally {

			resultMap.put("loginResult", res);
			pDTO = null;
		}

		return resultMap;
		
		*/
	}
	
	@RequestMapping(value = "/user/logout")
	public String logout(HttpSession session, ModelMap model) {
		session.invalidate();
		model.addAttribute("msg", "로그아웃하였습니다.");
		model.addAttribute("url", "/index.do");
		return "/redirect";
	}
	
	@RequestMapping(value = "/user/findPasswordProc")
	public String findPasswordProc(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".findPasswordProc start");
		
		UserInfoDTO uDTO = new UserInfoDTO();
		String email2 = request.getParameter("email2");
		log.info("암호화 전 이메일 : " + email2);
		email2 = EncryptUtil.encAES128CBC(email2);
		log.info("암호화 후 이메일 : " + email2);
		//암호화한 이메일을 가지고 서비스 갔다오기 위함
		uDTO.setEmail(email2);
		
		//login_register.jsp로부터 받아온 email로 초기화
		//uDTO.setEmail(request.getParameter("email2"));
		
		// uDTO에 암호화된 패스워드와 이메일 불러옴
		uDTO = userInfoService.findPassword(uDTO);
		
		model.addAttribute("title", "암호 초기화");
		model.addAttribute("findType", "pw");
		
		// 없을 경우
		if (uDTO == null) {
			model.addAttribute("msg", "해당 아이디는 존재하지 않습니다.");
			model.addAttribute("status", "1");
			return "/user/findResult";

		// 있을 경우
		} else {
			MailDTO mDTO = new MailDTO();
			mDTO.setTitle("비밀번호 초기화 링크");
			email2 = EncryptUtil.decAES128CBC(email2);
			mDTO.setToMail(email2);
			StringBuilder content = new StringBuilder();
			content.append("아래 링크를 클릭하시면 비밀번호 초기화 페이지로 이동합니다.\n");
			content.append("http://localhost:8080/user/findPasswordForm.do?code=");
			content.append(uDTO.getPassword());
			mDTO.setContents(content.toString());
			int res = mailService.doSendMail(mDTO);
			
			if (res > 0) {
				//이메일 가리기 작업 들어가기 위해서 email을 DTO로부터 가져옴
				String email = uDTO.getEmail();
				//이메일 가리기 작업하기 위해서 복호화함
				email = EncryptUtil.decAES128CBC(email);
				String[] splitEmail = email.split("@");
				String id = splitEmail[0];
				String domain = splitEmail[1];

				
				//실제 이메일 가리기 로직
				String censoredId = id.substring(0, 2);
				if (id.length() <= 6) {
					for (int i = 2; i < id.length(); i++) {
						censoredId += "*";
					}
				} else {
					for (int i = 2; i < id.length() - 2; i++) {
						censoredId += "*";
					}
					censoredId += id.substring(id.length() - 2, id.length());
					censoredId += id.substring(censoredId.length(), id.length());

				}

				String censoredEmail = censoredId + "@" + domain;
				StringBuilder msg = new StringBuilder("아래 이메일로 초기화 링크를 보내드렸습니다<br>");
				msg.append(censoredEmail);
				msg.append("<br>");
				msg.append("암호 초기화 링크는 20분간 유효합니다.");

				model.addAttribute("msg", msg.toString());
				model.addAttribute("status", "0");
			}

			return "/user/findResult";
		}
		
	}
	
	@RequestMapping(value = "/user/findPasswordForm")
	public String findPasswordForm(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".findPasswordForm start");
		
		String code = request.getParameter("code").replaceAll(" ", "+");
		log.info("code : " + code);
		try {
			
			String[] decoded = EncryptUtil.decAES128CBC(code).split(",");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
			log.info("decoded[0] : " + decoded[0]);
			log.info("decoded[1] : " + decoded[1]);
			Date d = sdf.parse(decoded[0]);
			String email = decoded[1];
			Date now = new Date();
			
			log.info("link date : " + sdf.format(d));
			log.info("now : " + sdf.format(now));
			
			if (d.compareTo(now) > 0) {
				log.info("시간지남");
				model.addAttribute("msg", "만료된 초기화 코드입니다.");
				model.addAttribute("url", "/user/login_register.do");
				return "/redirect";
			}
			
			
			
			model.addAttribute("code", code);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "유효하지 않은 코드입니다.");
			model.addAttribute("url", "/user/login_register.do");
			return "/redirect";
		}
		
		
		return "/user/findPasswordForm";
	}
	
	@RequestMapping(value = "/user/findPasswordFormProc")
	public String findPasswordFormProc(HttpServletRequest request, ModelMap model) throws Exception {
		String code = request.getParameter("code").replaceAll(" ", "+");
		String password = request.getParameter("password");
		String email = null;
		
		try {
			String[] decoded = EncryptUtil.decAES128CBC(code).split(",");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
			log.info("decode[0] : " + decoded[0]);
			log.info("decode[1] : " + decoded[1]);
			Date d = sdf.parse(decoded[0]);
			email = decoded[1];

			Date now = new Date();

			if (d.compareTo(now) > 0) {
				model.addAttribute("msg", "만료된 초기화 코드입니다.");
				model.addAttribute("url", "/index.do");
				return "/redirect";
			}
			
			
			
			model.addAttribute("code", code);
			
			
		} catch (Exception e) {
			model.addAttribute("msg", "유효하지 않은 코드입니다.");
			model.addAttribute("url", "/user/login_register.do");
			return "/redirect";
		}
		
		
		
		
		int result;
		// 히새 암호화된 암호를 찾아서 새 암호로 엎어씌움
		result = userInfoService.findPasswordProc(email, password);
		
		model.addAttribute("title", "암호 초기화");
		model.addAttribute("findType", "pwProc");
		String msg;
		String status;
		if(result>0) {
			msg = "암호 초기화에 성공하였습니다.";
			status = "0";
		}else {
			msg = "암호 초기화에 실패하였습니다.";
			status = "1";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("status", status);
		
		return "/user/findResult";
	}
	
	@RequestMapping(value = "/user/myPage")
	public String myPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + "myPage ok!");

		String user_no = (String)session.getAttribute("user_no");
		log.info("user_no : " + user_no);
		UserInfoDTO uDTO = userInfoService.getUserInfo(user_no);
		
		if(uDTO == null) {
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		
		model.addAttribute("uDTO", uDTO);
		
		return "/user/myPage";
	}
	
	@RequestMapping(value = "/user/verifyEmail")
	public String verifyEmail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".verifyEmail start");
		String[] decoded;
		try {
		String code = request.getParameter("code").replaceAll(" ", "+");
		decoded = EncryptUtil.decAES128CBC(code).split(",");
		}catch(Exception e){
			model.addAttribute("msg", "잘못된 링크입니다.");
			model.addAttribute("url", "/user/login_register.do");
			return "/redirect";
		}
		
		int res = 0;
		try {
			//decoded[0] : email, decoded[1] : state 1
			log.info("decoded[0] ENCODED: " + EncryptUtil.encAES128CBC(decoded[0]));
			log.info("decoded[1] : " + decoded[1]);
			res = userInfoService.verifyEmail(EncryptUtil.encAES128CBC(decoded[0]), decoded[1]);
			
		}catch(Exception e) {
			log.info(e.toString());
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/user/login_register.do");
			return "/redirect";
		}
		if(res>0) {
			model.addAttribute("msg", "이메일 인증에 성공했습니다.");
			model.addAttribute("url", "/user/login_register.do");
		}else {
			model.addAttribute("msg", "이메일 인증에 실패했습니다.");
			model.addAttribute("url", "/user/login_register.do");
		}

		log.info(this.getClass().getName() + ".verifyEmail end");
		return "/redirect";
		
	}
	
	@RequestMapping(value = "/user/editMyPage")
	public String editMyPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + "editMyPage start");

		String user_no = (String) session.getAttribute("user_no");
		//String user_no = request.getParameter("user_no");
		log.info("user_no : " + user_no);
		
		UserInfoDTO uDTO = userInfoService.getUserInfo(user_no);
		
		if(uDTO == null) {
			model.addAttribute("msg", "존재하지 않는 회원입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		
		model.addAttribute("uDTO", uDTO);
		
		uDTO = null;
		
		return "/user/editMyPage";
	}
	
	@RequestMapping(value = "/user/doEditMyPage")
	public String doEditMyPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		
		log.info(this.getClass().getName() + "doEditMyPage start");

		UserInfoDTO pDTO = new UserInfoDTO();
		
		String user_no = (String)session.getAttribute("user_no");
		String user_name = request.getParameter("user_name");
		String have_sign = request.getParameter("have_sign");
		String phone = request.getParameter("phone");
		
		log.info("user_no : " + user_no);
		log.info("user_name : " + user_name);
		log.info("have_sign : " + have_sign);
		log.info("phone : " + phone);
		
		pDTO.setUser_no(user_no);
		pDTO.setUser_name(user_name);
		pDTO.setHave_sign(have_sign);
		pDTO.setPhone(phone);
		
		int res = userInfoService.updateMyPage(pDTO);
		
		log.info("res : " + res);
		
		String msg;
		String url = "/user/myPage.do";
		
		if(res>0) {
			msg = "마이페이지 수정에 성공 하였습니다.";
		} else {
			msg = "마이페이지 수정에 실패 하였습니다. 잠시 후 다시 시도하여 주십시오.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + "doEditMyPage end");
		
		return "/redirect";
	}
	
	@RequestMapping(value = "/user/deleteUserInfo")
	public String deleteUserInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + "deleteUserInfo start");

		String user_no = (String) session.getAttribute("user_no");
		//String user_no = request.getParameter("user_no");
		log.info("user_no : " + user_no);
		
		int res = userInfoService.deleteUserInfo(user_no);
		
		String msg;
		String url = "/user/login_register.do";
		
		if(res > 0) {
			msg = "회원 탈퇴 처리가 완료 되었습니다.";
		} else {
			msg = "잠시 후 다시 시도해 주십시오.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + " .deleteUserInfo end");
		
		return "/redirect";
	}
	
	
	
}
