package poly.service;

import java.util.List;

import poly.dto.SignBookDTO;

public interface ISignBookService {

	List<SignBookDTO> getSignBookList() throws Exception;
	
	SignBookDTO getSignBookDetail(SignBookDTO pDTO);
}
