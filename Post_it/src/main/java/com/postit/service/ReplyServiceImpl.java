package com.postit.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.postit.domain.Criteria;
import com.postit.domain.ReplyDTO;
import com.postit.domain.ReplyPageDTO;
import com.postit.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{
	//인젝션
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyDTO dto) {
		return mapper.insert(dto);
	}

	@Override
	public ReplyDTO get(Integer rno) {
		return mapper.read(rno);
	}

	@Override
	public int remove(Integer rno) {
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyDTO dto) {
		return mapper.update(dto);
	}

	@Override
	public List<ReplyDTO> getList(Criteria cri, Integer pno) {
		return mapper.getListWithPaging(cri, pno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Integer pno) {
		return new ReplyPageDTO(mapper.getCountByPno(pno),mapper.getListWithPaging(cri, pno));
	}

}
