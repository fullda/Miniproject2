package com.postit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.postit.domain.PostVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")

@Log4j
public class PostController3 {
	//자동주입

	
	
	//등록화면
	@GetMapping("/register")
	public void register() {} //register.jsp로 이동
	

}
