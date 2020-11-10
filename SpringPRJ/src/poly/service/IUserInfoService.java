package poly.service;

import poly.dto.UserInfoDTO;

public interface IUserInfoService {

	int insertUserInfo(UserInfoDTO pDTO)throws Exception;
	
	int isDuplicateEmail(String email) throws Exception;
	
	
	//로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
	int getUserLoginCheck(UserInfoDTO pDTO) throws Exception;
	
	UserInfoDTO findPassword(UserInfoDTO uDTO) throws Exception;
	
	int verifyPwFind(String email) throws Exception;
	
	int findPasswordProc(String email, String password) throws Exception;
	
	int verifyEmail(String email, String state) throws Exception;
	
	UserInfoDTO getUserInfo(String user_no) throws Exception;
	
	UserInfoDTO forSession(UserInfoDTO pDTO) throws Exception;
	
	int deleteUserInfo(String user_no) throws Exception;
	
	int updateMyPage(UserInfoDTO pDTO) throws Exception;
}
