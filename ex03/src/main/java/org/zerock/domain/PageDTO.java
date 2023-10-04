package org.zerock.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage, endPage;		// 화면에 page바 표시를 위해 필요한 정보
	private boolean prev, next;
	private Criteria cri;
	private Long total;				// 전체 글 개수
	
	public PageDTO(Criteria cri, Long total) {
		this.cri = cri;
		this.total = total;
		
		endPage = (int)((Math.ceil(cri.getPageNum() / 10.0)) * 10);	// 페이지바의 끝페이지 = (올림(현현재페이지 * 10)) * 10
		startPage = endPage - 9;		// 페이지바의 시작페이지 = 끝페이지 - 9
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));	// 소수점 올림(전체 글 개수 / 1페이지당 개수)
		if(endPage > realEnd)			// 페이지바 끝페이지가 가장 마지막 페이지보다 클 때 변경
			endPage = realEnd;
		next = endPage != realEnd;		// endPage가 끝페이지면 next가 true
		prev = startPage != 1;			// 시작페이지가 1이 아닐 때 prev가 true;
	}
}