package org.zerock.service;

import java.util.List;

import org.zerock.domain.NewReplyVO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	int register(ReplyVO vo);			// 댓글 등록
	List<ReplyVO> getList(Long bno);	// 댓글 보기
	int modify(ReplyVO vo);				// 댓글 수정
	int remove(Long rno);				// 댓글 삭제
	void removebno(Long bno);
	ReplyVO get(Long rno);				// 댓글 1개 보기
	Long cnt(Long bno);					// 댓글 갯수
	Long todayCount();
	List<NewReplyVO> newReply();
}