package poly.service.impl;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.MailDTO;
import poly.service.IMailService;
import poly.util.CmmUtil;

@Service("MailService")
public class MailService implements IMailService {

	// 濡쒓렇 �뙆�씪 �깮�꽦 諛� 濡쒓렇 異쒕젰�쓣 �쐞�븳 log4j �봽�젅�엫�썙�겕�쓽 �옄諛� 媛앹껜
	private Logger log = Logger.getLogger(this.getClass());

	final String host = "smtp.naver.com"; // �꽕�씠踰꾩뿉�꽌 �젣怨듯븯�뒗 SMTP�꽌踰�
	final String user = "sdfgx123@naver.com"; // 蹂몄씤 �꽕�씠踰� �븘�씠�뵒
	final String password = "tuan948#$qp12";

	@Override
	public int doSendMail(MailDTO pDTO) {

		// 濡쒓렇 李띻린(異뷀썑 李띿� 濡쒓렇瑜� �넻�빐 �씠 �븿�닔�뿉 �젒洹쇳뻽�뒗吏� �뙆�븙�븯湲� �슜�씠�븯�떎.)
		log.info(this.getClass().getName() + ".doSendMail start");

		// 硫붿씪 諛쒖넚 �꽦怨듭뿬遺�(諛쒖넚�꽦怨� : 1 / 諛쒖넚�떎�뙣 : 0)
		int res = 1;

		// �쟾�떖 諛쏆� DTO濡쒕��꽣 �뜲�씠�꽣 媛��졇�삤湲�(null 諛⑹� if臾�)
		if (pDTO == null) {
			pDTO = new MailDTO();
		}

		String toMail = CmmUtil.nvl(pDTO.getToMail()); // 諛쏅뒗 �궗�엺

		Properties props = new Properties();
		props.put("mail.smtp.host", host); // javax �쇅遺� �씪�씠釉뚮윭由ъ뿉 硫붿씪 蹂대궡�뒗 �궗�엺�쓽 �젙蹂� �꽕�젙
		props.put("mail.smtp.auth", "true"); // javax �쇅遺� �씪�씠釉뚮윭由ъ뿉 硫붿씪 蹂대궡�뒗 �궗�엺 �씤利� �뿬遺� �꽕�젙

		// �꽕�씠踰� SMTP�꽌踰� �씤利� 泥섎━ 濡쒖쭅
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));

			// 硫붿씪 �젣紐�
			message.setSubject(CmmUtil.nvl(pDTO.getTitle()));

			// 硫붿씪 �궡�슜
			message.setText(CmmUtil.nvl(pDTO.getContents()));

			// 硫붿씪 諛쒖넚
			Transport.send(message);
		} catch (MessagingException e) {
			res = 0; // 硫붿씪 諛쒖넚 �떎�뙣 0
			log.info("[ERROR]" + this.getClass().getName() + ".doSnedMail :" + e);
		} catch (Exception e) {
			res = 0; // 硫붿씪 諛쒖넚 �떎�뙣 0
			log.info("[ERROR]" + this.getClass().getName() + ".doSnedMail :" + e);
		}

		// 濡쒓렇 李띻린
		log.info(this.getClass().getName() + ".doSendMail end!");
		return res;
	}

}
