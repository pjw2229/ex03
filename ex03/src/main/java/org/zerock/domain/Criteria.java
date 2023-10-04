package org.zerock.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum = 1, amount = 10;	// page 처리 정보 : 페이지 번호(pageNum), 1페이지에 보여줄 갯수(amount)
	private String type, keyword;	// 검색 정보, 검색 선택(type) - C(내용) T(제목) W(작성어), 검색어(keyword)

	public Criteria() {
		
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// type 글자를 한글자씩 자르는 메소드
	public String[] getTypeArr() {		// typeArr
		return (type != null) ? type.split("") : new String[] {};
	}
}