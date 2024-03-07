package com.postit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.postit.domain.Criteria;
import com.postit.domain.ReplyDTO;


public interface ReplyMapper {
		//등록
		public int insert(ReplyDTO dto);
		//상세보기
		public ReplyDTO read(Integer rno);
		//삭제
		public int delete(Integer rno);
		//수정
		public int update(ReplyDTO dto);
		//목록 with paging. parameter가 2개 이상일 때 @Param사용 필요.
		public List<ReplyDTO> getListWithPaging(@Param("cri") Criteria cri,@Param("pno") Integer pno);
		//댓글갯수
		public int getCountByPno(Integer pno);
}
