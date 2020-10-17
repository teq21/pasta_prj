package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserInfoDTO;
import poly.persistance.mapper.UserInfoMapper;
import poly.service.IUserInfoService;
import poly.util.CmmUtil;

@Service("UserInfoService")
public class UserInfoService implements IUserInfoService {
	
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




}
