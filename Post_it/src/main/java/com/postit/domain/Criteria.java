package com.postit.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
	private int pageNum; //페이지번호
	private int amount; //한페이지에 출력되는 글의 수
	private String type; // 검색컬럼. title, content, writer
	private String keyword; //검색어
	
	public Criteria() {
		this(1,3);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	// 'TCW' => {'T','C','W'} 로 split
	public String[] getTypeArr() {
		return type==null?new String[] {}:type.split("");
	}
	
}
