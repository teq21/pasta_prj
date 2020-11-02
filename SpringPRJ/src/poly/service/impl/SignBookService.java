package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.SignBookDTO;
import poly.persistance.mapper.ISignBookMapper;
import poly.service.ISignBookService;

@Service("SignBookService")
public class SignBookService implements ISignBookService {

	@Resource(name = "SignBookMapper")
	ISignBookMapper signBookMapper;

	

	@Override
	public SignBookDTO getSignBookDetail(SignBookDTO pDTO) {
		
		return signBookMapper.getSignBookDetail(pDTO);
	}



	@Override
	public List<SignBookDTO> getSignBookList() throws Exception {
		
		return signBookMapper.getSignBookList();
	}



	
	
	
}
