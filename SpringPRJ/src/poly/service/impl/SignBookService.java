package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.persistance.mapper.ISignBookMapper;
import poly.service.ISignBookService;

@Service("SignBookService")
public class SignBookService implements ISignBookService {

	@Resource(name = "SignBookMapper")
	ISignBookMapper signBookMapper;
}
