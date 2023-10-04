package org.zerock.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Log4j
@Service	// spring에 service 객체로 인식시키기 위해 사용(현재는 @Component와 같다.)
public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("목록보기 Service 요청");
		//return mapper.getList();
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void register(BoardVO vo) {
		log.info("글 등록 Service 요청");
		mapper.insert(vo);
	}

	@Override
	public boolean modify(BoardVO vo) {
		log.info("글 수정 Service 요청");
		/*
		int cnt = mapper.update(vo);
		if(cnt == 1)
			return true;
		else
			return false;
		*/
		return mapper.update(vo) == 1 ? true : false;
	}

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1 ? true : false;
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Override
	public Long cnt(Criteria cri) {
		return mapper.count(cri);
	}

	@Override
	public Long todayCnt(Criteria cri) {
		return mapper.todayCount(cri);
	}
	
	@Override
	public void recom(Long bno) {
		mapper.recom(bno);
	}
	
	@Override
	public void unrecom(Long bno) {
		mapper.unrecom(bno);
	}
}