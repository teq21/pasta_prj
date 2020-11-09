package poly.service;

import java.util.List;

import poly.dto.QuizDTO;

public interface IQuizService {
	
	//단어 유형 리스트 불러오기
	List<QuizDTO> getQuizList() throws Exception;
	
	//문장 유형 리스트 불러오기
	List<QuizDTO> getQuizList2() throws Exception;
	
	//단어 유형 상세보여주기
	QuizDTO getQuizDetail(QuizDTO pDTO);
	
	//문장 유형 상세보여주기
	QuizDTO getQuizDetail2(QuizDTO pDTO);
}
