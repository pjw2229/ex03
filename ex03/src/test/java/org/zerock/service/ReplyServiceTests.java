package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)		// junit으로 test시 spring framework로 실행
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")	// spring framework 설정 파일 위치
@Log4j
public class ReplyServiceTests {
	@Autowired
	private ReplyService service;
	
	@Test
	public void testRegister() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(285L);
		vo.setReply("알립니다. ... 이상입니다.");
		vo.setReplyer("관리자 박");
		service.register(vo);
	}
	
	@Test
	public void testGetList() {
		log.info(service.getList(285L) + "\n");
	}
	
	@Test
	public void testModify() {
		ReplyVO vo = new ReplyVO();
		vo.setRno(22L);
		vo.setReply("(수정완료)");
		vo.setReplyer("관리자 박");
		log.info(service.modify(vo));
	}
	
	@Test
	public void testRemove() {
		log.info(service.remove(30L));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(26L));
	}
	
	@Test
	public void testCnt() {
		log.info(service.cnt(285L));
	}
}
