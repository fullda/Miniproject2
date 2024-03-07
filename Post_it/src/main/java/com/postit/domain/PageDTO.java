package com.postit.domain;


import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev,next; // 이전 , 다음 링크 유무
	private int total; //전체글수
	private Criteria cri; 
	
	public PageDTO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		//끝페이지.   1.2.3...9.10 에서 10
		this.endPage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
		//시작페이지.  1.2.3...9.10 에서 1
		this.startPage=this.endPage-9;
		//실제끝페이지
		int realEnd=(int)(Math.ceil((total*1.0)/cri.getAmount()));
		//실제끝페이지가 끝페이지보다 작으면
		if(realEnd<=this.endPage) {
			this.endPage=realEnd; // 끝페이지를 실제끝페이지값으로 변경
		}
		this.prev=this.startPage>1; // 시작페이지가 1보다 커야(11부터) prev 존재
		this.next=this.endPage<realEnd; // 끝페이지가 실제끝페이지보다 작아야 next 존재		
	}
	
	
}
