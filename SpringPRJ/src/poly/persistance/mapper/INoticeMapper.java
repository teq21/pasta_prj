package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.BoardDTO;
import poly.dto.NoticeDTO;

@Mapper("NoticeMapper") // Service에서 mapper를 찾을 수 있도록
public interface INoticeMapper {

	int doNoticeForm(NoticeDTO pDTO);
	
	List<NoticeDTO> getNoticeList() throws Exception;

	NoticeDTO getNoticeDetail(NoticeDTO pDTO);

	int updateNotice(NoticeDTO pDTO);

	int doDeleteNotice(NoticeDTO pDTO);

}
