package poly.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.BoardDTO;
import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.service.impl.NoticeService;
import poly.util.CmmUtil;


@Controller
public class NoticeController {
	
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "NoticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value = "/notice/noticeList")
	public String noticeList(ModelMap model) throws Exception {
		log.info(this.getClass().getName() + " noticeList start");
		
		List<NoticeDTO> rList = noticeService.getNoticeList();
		
		if (rList == null) {
			rList = new ArrayList<NoticeDTO>();
		}
		
		model.addAttribute("rList", rList);

		rList = null;
		
		log.info("noticeList end");
		
		return "/notice/noticeList";
	}
	
	@RequestMapping(value = "/notice/noticeForm")
	public String noticeForm() {
		log.info(this.getClass().getName() + " noticeForm start");
		
		return "/notice/noticeForm";
	}
	
	@RequestMapping(value = "/notice/doNoticeForm")
	public String doNoticeForm(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " doNoticeForm start");
		
		String reg_id = "admin";
		
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");
		//String reg_dt = request.getParameter("reg_dt");
		
		NoticeDTO pDTO = new NoticeDTO();
		
		
		pDTO.setReg_id(reg_id);
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);
		//pDTO.setReg_dt(reg_dt);
		
		//log.info(reg_dt);
		
		int res = noticeService.doNoticeForm(pDTO);
		
		String msg;
		String url = "/notice/noticeList.do";
		
		if(res>0) {
			msg = "게시글 등록 성공";
		} else {
			msg = "게시글 등록 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	}

	@RequestMapping(value = "/dummyPage")
	public String dummyPage() {
		log.info(this.getClass().getName() + " dummyPage start");
		
		return "/dummyPage";
	}
	
	@RequestMapping(value = "/notice/noticeDetail")
	public String noticeDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " noticeDetail start");
		
		String post_no = request.getParameter("no");
		NoticeDTO pDTO = new NoticeDTO();
		pDTO.setPost_no(post_no);
		
		log.info("pDTO set 성공");
		
		NoticeDTO rDTO = noticeService.getNoticeDetail(pDTO);
		
		log.info("rDTO 탑재 성공");
		
		if(rDTO==null) {
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/notice/noticeList.do");
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);
		
		return "/notice/noticeDetail";
	}
	
	@RequestMapping(value = "/notice/editNoticeDetail")
	public String editNoticeDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " editNoticeDetail start");
		
		String post_title = request.getParameter("title");
		String post_content = request.getParameter("content");
		
		NoticeDTO pDTO = new NoticeDTO();
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);
		
		log.info("pDTO post_title 탑재 : " + post_title );
		log.info("pDTO post_content 탑재 : " + post_content );
		
		NoticeDTO rDTO = noticeService.getNoticeDetail(pDTO);
		
		if(rDTO==null) {
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/notice/noticeList.do");
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);
		
		log.info(post_content );
		
		return "/notice/editNoticeDetail";
	}
	
	@RequestMapping(value = "/notice/doEditNoticeDetail")
	public String doEditNoticeDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " doEditNoticeDetail start");
		
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");
		
		
		NoticeDTO pDTO = new NoticeDTO();
		
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);
		
		log.info(post_title);
		log.info(post_content);
		log.info("로그 확인용");
		
		int res = noticeService.updateNotice(pDTO);
		
		String msg;
		String url = "/notice/noticeList.do";
		
		if(res>0) {
			
			msg = "공지사항 수정에 성공 하였습니다.";
			
		} else {
			
			msg = "공지사항 수정에 실패 하였습니다.";
			
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		
		return "/redirect";
	}
	
	@RequestMapping(value = "/notice/doDeleteNotice")
	public String doDeleteNotice(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " doDeleteNotice start");
		
		String post_no = request.getParameter("no");
		
		NoticeDTO pDTO = new NoticeDTO();
		
		pDTO.setPost_no(post_no);
		
		int res = noticeService.doDeleteNotice(pDTO);
		
		String msg;
		String url = "/notice/noticeList.do";
		
		if(res>0) {
			msg = "삭제 성공";
		} else {
			msg = "삭제 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	}
	
}
