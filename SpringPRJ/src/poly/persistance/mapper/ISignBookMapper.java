package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.SignBookDTO;

@Mapper("SignBookMapper")
public interface ISignBookMapper {

	List<SignBookDTO> getSignBookList();

	SignBookDTO getSignBookDetail(SignBookDTO pDTO);

	
}
