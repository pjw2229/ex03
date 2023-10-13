package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.BestBoardVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.BoardService;
import org.zerock.subdomain.BnoVO;
import org.zerock.subdomain.Total;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/myapi/")
@AllArgsConstructor
public class MyApiController {
	private BoardService service;

	@GetMapping(value = "/replybnocount", produces = "text/plain; charset=UTF-8")
	public String replyBnoCnt() {
		return "댓글달린 글 갯수 : " + service.totalReplyCount();
	}

	@PutMapping(value = "/bestbno", produces = MediaType.APPLICATION_JSON_VALUE)
	public BnoVO best() {
		BnoVO vo = new BnoVO();
		vo.setBno(service.bestReply());
		return vo;
	}

	@GetMapping("/{first}/{last}")
	public Total sum(@PathVariable("first") Long first, @PathVariable("last") Long last) {
		Total t = new Total();

		Long total = 0L;
		for(Long i = first; i <= last; i++)
			total += i;
		t.setCount(total);
		return t;
	}

	@GetMapping(value = "/board/{page}/{amount}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<BoardVO> getBoard(@PathVariable("page") int page, @PathVariable("amount") int amount){
		Criteria cri = new Criteria(page, amount);	// 페이징
		return service.getList(cri);
	}

	@PostMapping(value = "/board/{page}/{amount}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<BoardVO> getKeyword(@PathVariable("page") int page, @PathVariable("amount") int amount, @RequestBody Criteria cri){
		cri.setAmount(amount);
		cri.setPageNum(page);
		return service.getList(cri);
	}

	@GetMapping("/bestboard")
	public List<BestBoardVO> postbest() {
		return service.bestboard();
	}
}