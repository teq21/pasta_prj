package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.QuizDTO;

@Mapper("QuizMapper")
public interface IQuizMapper {

	 //단어유형 목록 불러오기 -->
	List<QuizDTO> getQuizList();
	
	//단어 문제 상세페이지 보여주기 
	QuizDTO getQuizDetail(QuizDTO pDTO);
	
	//문장 유형 목록 불러오기
	List<QuizDTO> getQuizList2();
	
	//문장 문제 상세페이지 보여주기
	QuizDTO getQuizDetail2(QuizDTO pDTO);
}
