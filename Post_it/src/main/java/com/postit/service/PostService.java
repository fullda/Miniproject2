package com.postit.service;

import java.util.List;

import com.postit.domain.Criteria;
import com.postit.domain.PostDTO;


public interface PostService {
	//목록
	public List<PostDTO> getList();
	//전체글수
	public int getTotal(Criteria cri);
	//목록 with paging
	public List<PostDTO> getList(Criteria cri); //overloading
	//상세보기
	public PostDTO get(Long pno);
	//삭제
	public boolean remove(Long pno);
	//수정
	public boolean update(PostDTO pDTO);
	// 상세글을 pno를 통해 불러오기
	public PostDTO read(Long pno);
	// pno를 통해 불러온 글의 비밀번호와 입력받은 비밀번호 비교하기
	public boolean checkPW(Long pno, String password);
	//등록
	public void register(PostDTO board);   
	//최신글 불러오기
	public PostDTO latestRead();
}
