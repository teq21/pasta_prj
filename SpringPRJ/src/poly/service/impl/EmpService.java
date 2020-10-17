package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.EmpDTO;
import poly.persistance.mapper.IEmpMapper;
import poly.service.IEmpService;

@Service("EmpService")
public class EmpService implements IEmpService{

	@Resource(name="EmpMapper")
	IEmpMapper empMapper;
	
	
	@Override
	public List<EmpDTO> getEmpList() {
		
		return empMapper.getEmpList();
	}


	@Override
	public List<EmpDTO> getManagerList() {
		return empMapper.getManagerList();
	}

}
