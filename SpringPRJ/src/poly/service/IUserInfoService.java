package poly.service;

import poly.dto.UserInfoDTO;

public interface IUserInfoService {

	int insertUserInfo(UserInfoDTO pDTO)throws Exception;
	
	int isDuplicateEmail(String email) throws Exception;
	
	
	//로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
	int getUserLoginCheck(UserInfoDTO pDTO) throws Exception;
	
	UserInfoDTO findPassword(UserInfoDTO uDTO) throws Exception;
}
