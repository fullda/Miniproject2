package com.postit.service;

import java.util.List;

import com.postit.domain.Criteria;
import com.postit.domain.ReplyDTO;
import com.postit.domain.ReplyPageDTO;

public interface ReplyService {
	//등록
	public int register(ReplyDTO dto);
	
	//상세보기
	public ReplyDTO get(Integer rno);
	
	//삭제
	public int remove(Integer rno);
	
	//수정
	public int modify(ReplyDTO dto);
	
	//목록
	public List<ReplyDTO> getList(Criteria cri, Integer pno);
	
	//페이징+목록
	public ReplyPageDTO getListPage(Criteria cri , Integer pno);
	
}
