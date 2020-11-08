package poly.persistance.mapper;

import config.Mapper;
import poly.dto.VideoDTO;

@Mapper("VideoMapper")
public interface IVideoMapper {
	
	VideoDTO  getvideo(VideoDTO pDTO) throws Exception ;
	
}
