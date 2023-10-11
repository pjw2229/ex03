package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.NewReplyVO;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	int insert(ReplyVO vo);				// 쓰기
	List<ReplyVO> getList(Long bno);	// 목록 읽기
	int update(ReplyVO vo);				// 수정
	int delete(Long rno);				// 삭제
	ReplyVO get(Long rno);				// 댓글 1개 보기
	Long cnt(Long bno);					// 댓글 갯수
	Long todayCount();
	List<NewReplyVO> newReply();
}