package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/**")
@AllArgsConstructor
public class BoardController {
	BoardService service;

	@GetMapping("/list")	// board/list
	public void list(Model m, Criteria cri, Locale locale) {
		m.addAttribute("best", service.bestReply());
		m.addAttribute("totalReplyCount", service.totalReplyCount());
		m.addAttribute("serverTime", DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale).format(new Date()));
		m.addAttribute("cnt", service.cnt(cri));
		m.addAttribute("todayCnt", service.todayCnt());
		m.addAttribute("list", service.getList(cri));	// -> board/list.jsp
		m.addAttribute("pageMaker", new PageDTO(cri, service.cnt(cri)));
	}
	
	@GetMapping("/newSearch")
	public void newSearch() {
		
	}
	
	@GetMapping("/newReply")
	public void newReply() {
		
	}
	
	@PostMapping("/newSearch")
	public List<BoardVO> Search(@RequestBody Criteria cri) {
		return service.getList(cri);
	}

	@GetMapping("/register")
	public void register(BoardVO vo, Model m){
		log.info("get");
	}

	@PostMapping(value = "/register", produces = "text/plain; charset=UTF-8")	// 등록(작성글 - BoardVO) board/register (post) <- 입력화면(get)
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("register url post 요청");
		service.register(vo);
		rttr.addFlashAttribute("oper", "create");
		rttr.addFlashAttribute("result", vo.getBno());	// 데이터(작성글 번호) 1번만 전송
		return "redirect:/board/list";		// why? redirect가 없으면 jsp이고 /redirect가 있으면 request
	}

	@GetMapping("/get")			// 조회(글번호 - bno) board/get (get)
	public void get(Long bno, Model m, Criteria cri) {
		//log.info("글 상세보기 url 요청");
		m.addAttribute("board", service.get(bno));
		m.addAttribute("cri", cri);		// -> board/get.jsp
	}
	
	@GetMapping("/remove")
	public void remove(Long bno, Model m) {
		m.addAttribute("bno", bno);
	}
	
	@PostMapping("/remove")		// 삭제(글번호 - bno) board/remove (post)	<- 입력화면(get)
	public String remove(Long bno, RedirectAttributes rttr, String pw) {
		log.info("삭제 url 요청");
		if(pw.equals("1234")) {
			if(service.remove(bno)) {		// 이상 없으면 result 이름으로 success 문자 전송
				rttr.addFlashAttribute("oper", "remove");
				rttr.addFlashAttribute("result", bno);
			}
			return "redirect:/board/list";
		}else {
			rttr.addFlashAttribute("flag", "실패");
			return "redirect:/board/remove?bno=" + bno;
		}
	}

	@GetMapping("/modify")
	public void modify(Long bno, Model m, Criteria cri){
		m.addAttribute("board", service.get(bno));
		m.addAttribute("cri", cri);
	}

	@PostMapping(value = "/modify", produces = "text/plain; charset=UTF-8")	// 수정(수정글 - BoardVO) board/modify (post) <- 입력화면(get)
	public String modify(BoardVO vo, RedirectAttributes rttr, Criteria cri) {
		log.info("수정 url 요청");
		if(service.modify(vo)) {
			rttr.addFlashAttribute("oper", "modify");
			rttr.addFlashAttribute("result", vo.getBno());
		}
		return "redirect:/board/list?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}

	@GetMapping("/recom")
	public String recom(Long bno, Criteria cri) {
		service.recom(bno);
		return "redirect:/board/list?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}

	@GetMapping("/unrecom")
	public String unrecom(Long bno, Criteria cri) {
		service.unrecom(bno);
		return "redirect:/board/list?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}
}