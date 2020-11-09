package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.QuizDTO;
import poly.persistance.mapper.IQuizMapper;
import poly.service.IQuizService;

@Service("QuizService")
public class QuizService implements IQuizService {

	@Resource(name="QuizMapper")
	IQuizMapper QuizMapper;
	
	//단어유형 퀴즈 목록 불러오기
	@Override
	public List<QuizDTO> getQuizList() throws Exception {
		 return QuizMapper.getQuizList();
	}
	
	//단어유형 상세페이지 불러오기
	@Override
    public QuizDTO getQuizDetail(QuizDTO pDTO) {
		
		return QuizMapper.getQuizDetail(pDTO);
	}
	
	//문장유형 퀴즈 목록 불러오기
	@Override
	public List<QuizDTO> getQuizList2() throws Exception {
		return QuizMapper.getQuizList2();
	}
	
	//문장유형 상세페이지 불러오기
	@Override
	public QuizDTO getQuizDetail2(QuizDTO pDTO) {
		return QuizMapper.getQuizDetail2(pDTO);
	}
	}


