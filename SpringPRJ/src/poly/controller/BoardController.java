package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.BoardDTO;
import poly.service.IBoardService;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class BoardController {

	// 로그 파일 생성 및 로그 출력을 위한 log4j 프레임워크의 자바 객체
	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨) static 선언 방식 기반의 싱글톤패턴
	 */
	@Resource(name = "BoardService")
	private IBoardService boardService;

	@RequestMapping(value = "/board/boardList.do")
	public String boardList(ModelMap model) throws Exception {
		log.info("boardList start!!");

		List<BoardDTO> rList = boardService.getBoardList();

		if (rList == null) {
			rList = new ArrayList<BoardDTO>();
		}

		model.addAttribute("rList", rList);

		rList = null;

		log.info("boardList end");

		return "/board/boardList";
	}

	@RequestMapping(value = "/board/newPost.do")
	public String newPost() {
		log.info("newPost start!!");
		return "/board/newPost";
	}

	@RequestMapping(value = "/board/doPost.do", method = RequestMethod.POST)
	public String doPost(HttpServletRequest request, ModelMap model) throws Exception {

		log.info("doPost start!");

		// 임시로 설정하는 아이디
		String id = "admin";

		// 요청으로부터 받은 파라미터를 변수에 저장
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");

		// 게시자, 게시글 제목, 게시글 내용을 담아 서비스에 전송할 DTO객체 생성
		BoardDTO pDTO = new BoardDTO();

		pDTO.setReg_id(id);
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);

		int res = boardService.insertPost(pDTO);

		String msg;
		String url = "/board/boardList.do";

		// 게시글 등록 성공할 경우 res에 0보다 큰 수가 저장됨
		if (res > 0) {
			msg = "등록에 성공했습니다.";

			// res가 0일 경우 등록에 실패한 것
		} else {
			msg = "등록에 실패했습니다.";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		log.info("doPost end");

		return "/redirect";

	}

	@RequestMapping(value = "/board/boardDetail.do")
	public String boardDetail(HttpServletRequest request, ModelMap model) throws Exception {
		log.info("boardDetail start");

		String post_no = request.getParameter("no");

		BoardDTO pDTO = new BoardDTO();
		pDTO.setPost_no(post_no);

		BoardDTO rDTO = boardService.getBoardDetail(pDTO);

		if (rDTO == null) {
			model.addAttribute("msg", "존재하지않는 게시물입니다.");
			model.addAttribute("url", "/board/boardList.do");
			return "/redirect";
		}

		model.addAttribute("rDTO", rDTO);

		return "/board/boardDetail";
	}

	@RequestMapping(value = "/board/editPost.do")
	public String editPost(HttpServletRequest request, ModelMap model) throws Exception {
		log.info("editPost start");

		String post_no = request.getParameter("no");
		BoardDTO pDTO = new BoardDTO();
		pDTO.setPost_no(post_no);

		BoardDTO rDTO = boardService.getBoardDetail(pDTO);

		if (rDTO == null) {
			model.addAttribute("msg", "존재하지않는 게시물입니다.");
			model.addAttribute("url", "/board/boardList.do");
			return "/redirect";
		}

		model.addAttribute("rDTO", rDTO);

		log.info("editPost end");

		return "/board/editPost";
	}

	@RequestMapping(value = "/board/doEditPost.do")
	public String doEditPost(HttpServletRequest request, ModelMap model) throws Exception {
		log.info("doEditPost start");

		String post_no = request.getParameter("post_no");
		String post_title = request.getParameter("post_title");
		String post_content = request.getParameter("post_content");

		BoardDTO pDTO = new BoardDTO();
		pDTO.setPost_no(post_no);
		pDTO.setPost_title(post_title);
		pDTO.setPost_content(post_content);

		int res = boardService.updatePost(pDTO);

		String msg;
		String url = "/board/boardList.do";

		if (res > 0) {
			msg = "게시글 수정 성공";
		} else {
			msg = "게시글 수정 실패";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info("doEditPost end");

		return "/redirect";

	}

	@RequestMapping(value = "/board/deletePost.do")
	public String deletePost(HttpServletRequest request, ModelMap model) throws Exception {
		log.info("deletePost start");

		String post_no = request.getParameter("no");

		BoardDTO pDTO = new BoardDTO();
		pDTO.setPost_no(post_no);

		int res = boardService.deletePost(pDTO);

		String msg;
		String url = "/board/boardList.do";

		if (res > 0) {
			msg = "게시글 삭제 성공";
		} else {
			msg = "게시글 삭제 실패";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/redirect";
	}
}
