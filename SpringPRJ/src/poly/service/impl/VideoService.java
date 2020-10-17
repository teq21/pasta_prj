package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.persistance.mapper.IVideoMapper;
import poly.service.IVideoService;

@Service("VideoService")
public class VideoService implements IVideoService {
	@Resource(name = "IVideoMapper")
	private IVideoMapper videomapper;
	
	@Override
	public String getvideo() throws Exception {
		return videomapper.getvideo();
		
		
	}
	
	
	
	
	
	
}
