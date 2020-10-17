package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.IBoardMapper;
import poly.persistance.mapper.INoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService") // Controller에서 Service를 찾을 수 있는 이름.
public class NoticeService implements INoticeService {

	@Resource(name = "NoticeMapper")
	INoticeMapper noticeMapper;
	
	@Override
	public int doNoticeForm(NoticeDTO pDTO) {
		
		return noticeMapper.doNoticeForm(pDTO);
	}

	@Override
	public List<NoticeDTO> getNoticeList() throws Exception {
		
		return noticeMapper.getNoticeList();
	}

	@Override
	public NoticeDTO getNoticeDetail(NoticeDTO pDTO) {
		
		return noticeMapper.getNoticeDetail(pDTO);
	}

	@Override
	public int updateNotice(NoticeDTO pDTO) {
		
		return noticeMapper.updateNotice(pDTO);
	}

	@Override
	public int doDeleteNotice(NoticeDTO pDTO) {
		
		return noticeMapper.doDeleteNotice(pDTO);
	}

	

	
}
