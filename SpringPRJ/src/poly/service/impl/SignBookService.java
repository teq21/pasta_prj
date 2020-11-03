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
	private ISignBookMapper signBookMapper;

	@Override
	public SignBookDTO getSignBookDetail(SignBookDTO pDTO) {
		
		return signBookMapper.getSignBookDetail(pDTO);
	}

	@Override
	public int getSignBookListCnt() throws Exception {

		return signBookMapper.getSignBookListCnt();
	}

	@Override
	public List<SignBookDTO> getSignBookList(int start, int end) throws Exception {
		
		return signBookMapper.getSignBookList(start, end);
	}



	
	
	
}
