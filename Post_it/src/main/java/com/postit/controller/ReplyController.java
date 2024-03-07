package com.postit.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.postit.domain.Criteria;
import com.postit.domain.ReplyDTO;
import com.postit.domain.ReplyPageDTO;
import com.postit.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	//인젝션
	private ReplyService service;
	
	//등록
	@PostMapping(value="/new",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyDTO dto){
		log.info("d");
		int insertCount = service.register(dto);
		log.info(insertCount);
		log.info("e");
		return insertCount==1? new ResponseEntity<>("댓글등록성공" , HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//목록
	@GetMapping(value="/{pno}/{page}" , produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page , @PathVariable("pno") Integer pno){
	Criteria cri = new Criteria(page,10);
	return new ResponseEntity<>(service.getListPage(cri, pno),HttpStatus.OK);
	}
	
	//상세보기
	@GetMapping(value="/{rno}")
	public ResponseEntity<ReplyDTO> get(@PathVariable("rno") Integer rno){
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	
	//수정
	@PutMapping(value="/{rno}")
	public ResponseEntity<String> modify(@RequestBody ReplyDTO dto,@PathVariable("rno") Integer rno){
		dto.setPno(rno);
		return service.modify(dto)==1?new ResponseEntity<>("success",HttpStatus.OK):
									new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//삭제
	@DeleteMapping(value="/{rno}",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Integer rno){		
		return service.remove(rno)==1?new ResponseEntity<>("success",HttpStatus.OK):
									new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
