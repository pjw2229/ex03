package org.zerock.service;

import java.util.List;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	// 사용자 관점 서비스
	List<BoardVO> getList(Criteria cri);	// 1. 게시글 목록 보기
	List<BoardVO> searchTitle(String keyword);
	void register(BoardVO vo);	// 2. 게시글 작성
	boolean modify(BoardVO vo);		// 3. 게시글 수정
	boolean remove(Long bno);		// 4. 게시글 삭제
	BoardVO get(Long bno);		// 5. 게시글 상세
	Long cnt(Criteria cri);		// 6. 게시글 갯수
	Long todayCnt(Criteria cri);
	Long totalReplyCount();
	Long bestReply();
	void recom(Long bno);
	void unrecom(Long bno);
}