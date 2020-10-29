package poly.service;

import java.util.List;

import poly.dto.StudyDTO;

public interface IStudyService {

	List<StudyDTO> getStudyList() throws Exception;
	
	int doStudyForm(StudyDTO pDTO);
	
	StudyDTO getStudyDetail(StudyDTO pDTO);

}
