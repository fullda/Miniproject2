package com.postit.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostVO {
	private int pno;
	private int cno;
	private String title;
	private String pcontent;
	private String name;
	private String password;
	private Date pdate;
	private String img;
}
