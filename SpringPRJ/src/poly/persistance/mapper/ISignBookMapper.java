package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.SignBookDTO;

@Mapper("SignBookMapper")
public interface ISignBookMapper {

	SignBookDTO getSignBookDetail(SignBookDTO pDTO);

	int getSignBookListCnt();

	List<SignBookDTO> getSignBookList(@Param("start")int start, @Param("end")int end) throws Exception;

	
}
