package org.zerock.service;

import java.util.List;

import org.zerock.domain.ReplyVO;

public interface ReplyService {
	int register(ReplyVO vo);			// 댓글 등록
	List<ReplyVO> getList(Long bno);	// 댓글 보기
	int modify(ReplyVO vo);				// 댓글 수정
	int remove(Long rno);				// 댓글 삭제
}