package com.postit.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDTO {
	private Long pno;
	private Long cno;
	private String title;
	private String pcontent;
	private String name;
	private String password;
	private Date pdate;
	private Date updatedate;
	private String img;
}
