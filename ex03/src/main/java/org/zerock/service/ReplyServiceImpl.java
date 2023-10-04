package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Log4j
@Service
public class ReplyServiceImpl implements ReplyService{
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public List<ReplyVO> getList(Long bno) {
		return mapper.getList(bno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}
}