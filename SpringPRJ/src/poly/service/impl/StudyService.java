package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.dto.StudyDTO;
import poly.persistance.mapper.IStudyMapper;
import poly.service.IStudyService;

@Service("StudyService")
public class StudyService implements IStudyService {

	@Resource(name = "StudyMapper")
	IStudyMapper studyMapper;

	@Override
	public List<StudyDTO> getStudyList() throws Exception {
		
		return studyMapper.getStudyList();
	}


	@Override
	public int doStudyForm(StudyDTO pDTO) {
		// TODO Auto-generated method stub
		return studyMapper.doStudyForm();
	}

	@Override
	public StudyDTO getStudyDetail(StudyDTO pDTO) {
		// TODO Auto-generated method stub
		return null;
	}

	
}