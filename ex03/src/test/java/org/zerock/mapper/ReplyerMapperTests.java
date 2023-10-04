package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.zerock.controller.SampleControllerTests;
import org.zerock.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class ReplyerMapperTests {
	@Autowired
	private ReplyMapper rm;
	
	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(285L);
		vo.setReply("여기도 깨집니다!!!!!");
		vo.setReplyer("박재웅");
		rm.insert(vo);
	}
	
	@Test
	public void testGetList() {
		rm.getList(285L).forEach(x->log.info(x));
	}
	
	@Test
	public void testUpdate() {
		ReplyVO vo = rm.getList(285L).get(1);
		vo.setReply("한글 깨짐!!!");
		vo.setReplyer("jw");
		rm.update(vo);
	}
	
	@Test
	public void testDelete() {
		rm.delete(4L);
	}
}