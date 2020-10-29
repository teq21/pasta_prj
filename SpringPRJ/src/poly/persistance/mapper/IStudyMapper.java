package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.StudyDTO;

@Mapper("StudyMapper")
public interface IStudyMapper {

	List<StudyDTO> getStudyList() throws Exception;

	int doStudyForm(StudyDTO pDTO);

	StudyDTO getStudyDetail(StudyDTO pDTO);
}
