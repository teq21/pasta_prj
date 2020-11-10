package poly.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.UserInfoDTO;
import poly.persistance.mapper.UserInfoMapper;
import poly.service.IUserInfoService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Service("UserInfoService")
public class UserInfoService implements IUserInfoService {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "UserInfoMapper")
	private UserInfoMapper userInfoMapper;
	

	@Override
	public int insertUserInfo(UserInfoDTO pDTO) throws Exception {

		// 회원가입 성공: 1, 아이디 중복으로인한 가입취소 :2 , 기타에러발생 :0
		int res = 0;

		if (pDTO == null) {

			pDTO = new UserInfoDTO();
		}
		// controller 에서 값이 정상적으로 못넘어오는 경우를 대비하기 위해 사용
		// 회원 가입 중복 방지를 위해 db에서 데이터 조회
		UserInfoDTO rDTO = userInfoMapper.getUserExists(pDTO);

		// mapper 에서 값이 정상정오로 못넘어오는 경우를 대비하기 위해 사용
		if (rDTO == null) {
			rDTO = new UserInfoDTO();
		}

		// 중복된 회원정보가 있는 경우 결과값을 2로변경후, 더이상 잡엇을 진행하지않음

		if (CmmUtil.nvl(rDTO.getExists_yn()).equals("Y")) {
			res = 2;

			// 회원가입이 중복이아니므로 . 회원가입 진행함
		} else {
			// 회원가입
			int success = userInfoMapper.insertUserInfo(pDTO);

			// db에 데이터가 등록되었다면

			if (success > 0) {
				res = 1;
			} else {
				res = 0;
			}
		}

		return res;
	}


	@Override
	public int isDuplicateEmail(String email) throws Exception {
		return userInfoMapper.isDuplicateEmail(email);
	}


	@Override
	public int getUserLoginCheck(UserInfoDTO pDTO) throws Exception {
	// 로그인성공 :1, 실패 :0
		int res=0;
		
		//로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기위한  mapper 호출하기
		
		UserInfoDTO rDTO=userInfoMapper.getUserLoginCheck(pDTO);
		
		if(rDTO==null) {
			rDTO=new UserInfoDTO();
		}
		
		
		//로그인성공여부 체크시작
		// USERINFOMAPPER 로부터 쿼리의 결과로 회원아이디를 받아왔다면 로그인성공!
		//DTO의 변수에 값이 있는지 확인하기 처리속도 측면에서 가장 좋은방법은 변수의 길이를 가져오는것이다
		// 따라서 .length() 함수를 통해 회원아이디의 글자수를 가져와 0보다 큰지 비교한다
		//0보다 크다면 글자가 존재하는것이기 떄문에 값이 존재한다
		
		
		if(CmmUtil.nvl(rDTO.getEmail()).length()>0){
			res=1;
		}
		
		//로그인 성공여부 체크 끝!
		
		
		
		return res;
	}


	@Override
	public UserInfoDTO findPassword(UserInfoDTO uDTO) throws Exception {
		
		UserInfoDTO rDTO = new UserInfoDTO();
		
		//이메일, 비밀번호, 회원 이름을 가져와 DTO로 반환함
		rDTO = userInfoMapper.findPassword(uDTO);
		
		if(rDTO == null) {
			return null;
		} else {
			
			//암호화된 이메일을 가져옴
			String email = uDTO.getEmail();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
			Date d = new Date();
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			c.add(Calendar.MINUTE, 20);
			
			String timeLimit = sdf.format(c.getTime());
			log.info("timeLimit : " + timeLimit);
			
			//timeLimit이랑 합쳐서 암호화 걸기 위해서 일시적으로 복호화함
			email = EncryptUtil.decAES128CBC(email);
			//timeLimit과 이메일을 섞어서 해시코드 생성
			String accessCode = EncryptUtil.encAES128CBC(timeLimit + "," + email);
			log.info("access code : " + accessCode);
			// 앞서 만든 코드를 데이터베이스 암호란에 업데이트
			rDTO.setPassword(accessCode);
			// 암호 찾기 활성화
			userInfoMapper.setFindPassword(email, "1");
			return rDTO;
		}
	}


	@Override
	public int verifyPwFind(String email) throws Exception {

		return userInfoMapper.verifyPwFind(email);
	}


	@Override
	public int findPasswordProc(String email, String password) throws Exception {

		password = EncryptUtil.encHashSHA256(password);
		email = EncryptUtil.encAES128CBC(email);
		
		return userInfoMapper.findPasswordProc(email, password);
	}


	@Override
	public int verifyEmail(String email, String state) throws Exception {

		
		return userInfoMapper.verifyEmail(email, state);
	}


	@Override
	public UserInfoDTO getUserInfo(String user_no) throws Exception {

		
		return userInfoMapper.getUserInfo(user_no);
	}


	@Override
	public UserInfoDTO forSession(UserInfoDTO pDTO) throws Exception {

		return userInfoMapper.forSession(pDTO);
	}




}
