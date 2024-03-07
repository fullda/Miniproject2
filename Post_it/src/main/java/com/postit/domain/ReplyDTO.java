package com.postit.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	private Integer rno , pno , password;
	private String name, rcontent;
	private Date rdate;
}
