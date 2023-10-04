package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@RestController		// 데이터만 보내고 싶을 때 사용
@RequestMapping("/sample")
@Log4j
public class SampleController {
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE(데이터타입 의미) : " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하쇼";
	}
	
	@GetMapping(value = "/getSample", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		return new SampleVO(1, "박", "재웅");
		// json 변환 라이브러리가 있으면 json으로, xml 변환 라이브러리 있으면 xml, 둘 다 있으면 xml 우선으로 간다.
		// url 뒤에 .json으로 하면 json으로, .xml로 하면 xml로 처리된다.
	}
	
	@GetMapping(value = "/getList")
	public List<SampleVO> getList(){
		/*
		List<SampleVO> l = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			SampleVO vo = new SampleVO(i, i + "성", i + "번째 이름");
			l.add(vo);
		}
		return l;
		*/
		return IntStream.range(0, 10).mapToObj(i -> new SampleVO(i, i + "성", i + "번째 이름")).collect(Collectors.toList());
	}
	
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> m = new HashMap<>();
		m.put("Wednesday", new SampleVO(1, "오늘은", "수요일"));
		return m;
	}
	
	// params : 특정 key값이 존재하게 제한(params 없으면 404 not found)
	@GetMapping(value = "/check", params = {"height", "weight"})	// /sample/check?height=140&weight=50
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
		if(height < 150)
			return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		else
			return ResponseEntity.status(HttpStatus.OK).body(vo);
	}
	
	// url에 있는 값 읽기	/sample/product/dog/111
	@GetMapping("/product/{dog}/{pid}")
	public String[] getPath(@PathVariable("dog") String dog, @PathVariable("pid") Integer pid) {
		return new String[] {"카테고리 : " + dog, " productId : " + pid};
	}
	
	// 보낸 데이터 읽기
	@PostMapping("/ticket")
	public SampleVO convert(@RequestBody SampleVO vo) {
		log.info(vo + " 수집 여부 확인");
		return vo;
	}
}