package com.postit.mapper;

import java.util.List;

import com.postit.domain.Criteria;
import com.postit.domain.PostDTO;

public interface PostMapper {
	//목록
	public List<PostDTO> getList();
	//전체글수
	public int getTotalCount(Criteria cri);
	//목록 with paging
	public List<PostDTO> getListWithPaging(Criteria cri);
	//상세보기
	public PostDTO read(Long pno);
	//삭제
	public int delete(Long pno);
	//수정
	public int update(PostDTO board);
	//등록.key값 구하기
	public Integer insertSelectKey(PostDTO board);
	//최신글 불러오기
	public PostDTO latestRead();
}
