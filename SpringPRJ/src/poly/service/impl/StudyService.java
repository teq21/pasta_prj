package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.persistance.mapper.IStudyMapper;
import poly.service.IStudyService;

@Service("StudyService")
public class StudyService implements IStudyService {

	@Resource(name = "StudyMapper")
	IStudyMapper studyMapper;
}
