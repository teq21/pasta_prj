package poly.service;

import poly.dto.MailDTO;

public interface IMailService {

	// send mail
	int doSendMail(MailDTO pDTO);

}
