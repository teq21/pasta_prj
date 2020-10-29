package poly.service;

import java.util.List;


import poly.dto.NoticeDTO;

//Controller는 인터페이스에 있는 함수 명을 기반으로 실행 됨
public interface INoticeService {

	int doNoticeForm(NoticeDTO pDTO);
	
	List<NoticeDTO> getNoticeList() throws Exception;

	NoticeDTO getNoticeDetail(NoticeDTO pDTO);
	
	int updateNotice(NoticeDTO pDTO);
	
	int doDeleteNotice(NoticeDTO pDTO);

}
