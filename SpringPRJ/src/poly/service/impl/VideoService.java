package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.VideoDTO;
import poly.persistance.mapper.IVideoMapper;
import poly.service.IVideoService;

@Service("VideoService")
public class VideoService implements IVideoService {
	@Resource(name = "VideoMapper")
	private IVideoMapper videomapper;

	@Override
	public VideoDTO getvideo(VideoDTO pDTO) throws Exception {
	
		return videomapper.getvideo(pDTO);
	}
	
	
}
	

	
	
	
	

