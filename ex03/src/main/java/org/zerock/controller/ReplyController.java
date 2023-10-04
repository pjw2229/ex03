package org.zerock.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;

	@PostMapping(value = "/new", produces = "text/plain; charset=UTF-8")
	public String urlNew(@RequestBody ReplyVO vo) {
		log.info("등록할 댓글 정보 : " + vo);
		int cnt = service.register(vo);	// 댓글 등록 시 success 문자를 보내고 상태는 정상, 실패 시 500 error
		// cnt == 1 ?
		return "등록 완료";
	}
	
	@DeleteMapping("/{rno}")
	public String urlDelete() {
		return null;
	}

	@PutMapping("/{rno}")
	public String urlPut() {
		return null;
	}

	@GetMapping("/pages/{bno}")
	public List<ReplyVO> urlList(){
		return null;
	}

	
}