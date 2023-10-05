package org.zerock.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.ReplyVO;
import org.zerock.domain.SampleVO;

import com.google.gson.Gson;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class SampleControllerTests {
	@Autowired
	private WebApplicationContext ctx;	// mockMvc 객체 생성에 필요
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testTicket() throws Exception {
		SampleVO vo = new SampleVO(2, "abc", "xyz");
		Gson gson = new Gson();
		String jsonData = gson.toJson(vo);
		
		log.info("JSON 형태로 변환 : " + jsonData);
		mockMvc.perform(post("/sample/ticket").contentType(MediaType.APPLICATION_JSON).content(jsonData)).andExpect(status().is(200));
		// crud = read, create, update, delete
		// 메소드 : get, post, put, patch, delete
	}
	
	// json 생성
	@Test
	public void makeJson() {
		ReplyVO vo = new ReplyVO();
		
		vo.setBno(284L);
		vo.setReply("그냥 댓글 내용이다.");
		vo.setReplyer("관리자 박");
		log.info("json 문자열 : " + new Gson().toJson(vo));
	}
}
