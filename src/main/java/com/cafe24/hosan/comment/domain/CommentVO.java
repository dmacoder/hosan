package com.cafe24.hosan.comment.domain;

import java.sql.Date;

public class CommentVO {
	private int comment_srl;
	private int parent_board_srl;
	private String user_id;
	private String comments;
	private Date postdate;
	private int parent_comment_srl;
	private int step;
	private int indent;
	private Date last_update;
	private String comment_type;
	
	public String getComment_type() {
		return comment_type;
	}
	public void setComment_type(String comment_type) {
		this.comment_type = comment_type;
	}
	public int getComment_srl() {
		return comment_srl;
	}
	public void setComment_srl(int comment_srl) {
		this.comment_srl = comment_srl;
	}
	public int getParent_board_srl() {
		return parent_board_srl;
	}
	public void setParent_board_srl(int parent_board_srl) {
		this.parent_board_srl = parent_board_srl;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public int getParent_comment_srl() {
		return parent_comment_srl;
	}
	public void setParent_comment_srl(int parent_comment_srl) {
		this.parent_comment_srl = parent_comment_srl;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public Date getLast_update() {
		return last_update;
	}
	public void setLast_update(Date last_update) {
		this.last_update = last_update;
	}
	
	
}
