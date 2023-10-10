package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.HourGroupVO;
import org.zerock.domain.RankVO;

public interface BoardMapper {
	//@Select("select * from tbl_board")
	List<BoardVO> getList();			// 게시글 목록보기
	List<BoardVO> getListWithPaging(Criteria cri);	// 페이지 처리 - 현재 무조건 2페이지 출력(1페이지당 10개)
	BoardVO read(Long bno);				// 게시글 상세
	void insert(BoardVO vo);			// 게시글 작성
	void insertSelectKey(BoardVO vo);	// 게시글 작성(작성된 글번호 확인)
	int update(BoardVO vo);				// 게시글 수정
	int delete(Long bno);				// 게시글 삭제
	// insert, update, delete시 return type을 int하면 처리된 행을 개수가 return된다.

	List<RankVO> rank();				// (랭킹 5등까지) 작성자, 작성글 개수
	Long count(Criteria cri);						// 전체 글 갯수
	List<BoardVO> lastBoard();			// 업데이트 일자 기준 가장 최신글 5개
	List<HourGroupVO> hourGroup();		// 작성 시간대별 글 갯수 통계 - 00 5 / 01 1 / .. / 23 11
	Long todayCount(Criteria cri);		// 게시글 검색
	Long totalReplyCount();
	Long bestReply();
	void recom(Long bno);				// 추천 시 추천 카운트 +1
	void unrecom(Long bno);				// 비추천 시 비추천 카운트 +1
}