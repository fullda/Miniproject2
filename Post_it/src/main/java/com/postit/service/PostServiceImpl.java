package com.postit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.postit.domain.Criteria;
import com.postit.domain.PostDTO;
import com.postit.mapper.PostMapper;

import lombok.AllArgsConstructor;


@Service // 없으면 500번 에러. internal server error
@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 만들어 줌.
public class PostServiceImpl implements PostService {
	//자동주입
	@Autowired
	private PostMapper mapper;

	@Override
	public List<PostDTO> getList() {		
		return mapper.getList();
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<PostDTO> getList(Criteria cri) {

		return mapper.getListWithPaging(cri);
	}

	@Override
	public PostDTO get(Long pno) {		
		return mapper.read(pno);
	}

	@Override
	public boolean remove(Long pno) {
		return mapper.delete(pno)==1; //영향을 받은 행의 수가 1이면 삭제가 성공함.
	}

	@Override
	public boolean update(PostDTO pDTO) {		
		return mapper.update(pDTO)==1; //영향을 받은 행의 수가 1이면 수정이 성공함.
	}
	
	@Override
	public PostDTO read(Long pno) {
		return mapper.read(pno);
	}

	@Override
	public boolean checkPW(Long pno, String password) {
		PostDTO postDTO = mapper.read(pno);
		//pno로 받아온 글의 비밀번호와 입력받은 비밀번호 비교
		if(password.equals(postDTO.getPassword())) {//pno통해 글의 비밀번호. 같다. 받은 값의 비밀번호()
			// 비밀번호가 같을 때 true
			return true;
		}else {
			// 비밀번호가 다를 때 false
			return false;
		}
	}
	 @Override
	   public void register(PostDTO board) {
	      mapper.insertSelectKey(board);
	      
	   }
	 //최신 글 번호 가져오기
	@Override
	public PostDTO latestRead() {
		//PostDTO pDTO =new PostDTO();
		PostDTO pDTO1 =new PostDTO();
		pDTO1 = mapper.latestRead();
		return pDTO1;
	}
}

