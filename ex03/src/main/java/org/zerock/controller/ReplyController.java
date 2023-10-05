package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

	// consumes를 통해 보내온 데이터타입 확인해 틀리면 415
	@PostMapping(value = "/new", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> urlNew(@RequestBody ReplyVO vo) {
		log.info("등록할 댓글 정보 : " + vo);
		// 댓글 등록 시 success 문자를 보내고 상태는 정상, 실패 시 500 error
		return service.register(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// HttpStatus.BAD_REQUEST : 400 error
	}
	
	@DeleteMapping(value = "/{rno}", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> urlDelete(@PathVariable("rno") Long rno) {
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.I_AM_A_TEAPOT);
	}

	@PutMapping(value = "/{rno}", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> urlPut(@PathVariable("rno") Long rno, @RequestBody ReplyVO vo) {
		vo.setRno(rno);
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.I_AM_A_TEAPOT);
	}

	// ex : /replies/pages/285
	@GetMapping("/pages/{bno}")
	public List<ReplyVO> urlList(@PathVariable("bno") Long bno){
		return service.getList(bno);
	}
	
	// ex : /replies/read/26 : 26번 댓글을 보여준다.
	@GetMapping("/read/{rno}")
	public ReplyVO urlGet(@PathVariable("rno") Long rno) {
		return service.get(rno);
	}
	
	// ex : /replies/count/285 : 285번 게시글의 댓글 개수를 보여준다.
	@GetMapping("/count/{bno}")
	public Long urlCnt(@PathVariable("bno") Long bno) {
		return service.cnt(285L);
	}
}