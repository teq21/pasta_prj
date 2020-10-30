package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.NoticeDTO;
import poly.dto.StudyDTO;
import poly.service.impl.StudyService;

@Controller
public class StudyController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "StudyService")
	private StudyService studyService;
	
	@RequestMapping(value = "/study/studyForm")
	public String studyForm() {
		log.info(this.getClass().getName() + " studyForm start");

		return "/study/studyForm";
	}

	@RequestMapping(value = "/study/studyList")
	public String studyList(ModelMap model, HttpServletRequest request) throws Exception {
		log.info(this.getClass().getName() + " studyList start");

		List<StudyDTO> rList = studyService.getStudyList();

		if (rList == null) {
			rList = new ArrayList<>();
		}

		model.addAttribute("rList", rList);

		rList = null;

		log.info("studyList end");

		return "/study/studyList";
	}
	
	@RequestMapping(value = "/study/doStudyForm")
	public String doStudyForm(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " doStudyForm start");
		
		String reg_id = "admin";
		
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");
		//String reg_dt = request.getParameter("reg_dt");
		
		StudyDTO pDTO = new StudyDTO();
		
		
		pDTO.setReg_id(reg_id);
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);
		//pDTO.setReg_dt(reg_dt);
		
		//log.info(reg_dt);
		
		int res = studyService.doStudyForm(pDTO);
		
		String msg;
		String url = "/study/studyList.do";
		
		if(res>0) {
			msg = "게시글 등록 성공";
		} else {
			msg = "게시글 등록 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	}
	
	@RequestMapping(value = "/study/studyDetail")
	public String studyDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " studyDetail start");
		
		String post_no = request.getParameter("no");
		StudyDTO pDTO = new StudyDTO();
		pDTO.setPost_no(post_no);
		
		log.info("pDTO set 성공");
		
		StudyDTO rDTO = studyService.getStudyDetail(pDTO);
		
		log.info("rDTO 탑재 성공");
		
		if(rDTO==null) {
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/study/studyList.do");
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);
		
		return "/study/studyDetail";
	}
	
	@RequestMapping(value = "/study/editStudyDetail")
	public String editStudyDetail(HttpServletRequest request, ModelMap model) {
		
		log.info(this.getClass().getName() + " editStudyDetail start");
		
		String post_no = request.getParameter("no");
		
		StudyDTO pDTO = new StudyDTO();
		pDTO.setPost_no(post_no);
		log.info("pDTO set 성공");
		
		StudyDTO rDTO = studyService.getStudyDetail(pDTO);
		log.info("rDTO 탑재 성공");
		
		if(rDTO==null) {
			model.addAttribute("msg", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/study/studyList.do");
			return "/redirect";
		}
		
		model.addAttribute("rDTO", rDTO);
		
		return "/study/editStudyDetail";
		
	}
	
	@RequestMapping(value = "/study/doEditStudyDetail")
	public String doEditStudyDetail(HttpServletRequest request, ModelMap model) {
		log.info(this.getClass().getName() + " doEditStudyDetail start");
		
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");
		String post_no = request.getParameter("post_no");
		
		StudyDTO pDTO = new StudyDTO();
		
		log.info(post_title);
		log.info(post_content);
		log.info(post_no);
		
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);
		pDTO.setPost_no(post_no);
		
		int res = studyService.updateStudyDetail(pDTO);
		
		String msg;
		String url = "/study/studyList.do";
		
		if(res>0) {
			
			msg = "게시글 수정에 성공 하였습니다.";
			
		} else {
			
			msg = "게시글 수정에 실패 하였습니다.";
			
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		
		return "/redirect";
	}
	
}
