package com.cafe24.hosan.notice.domain;

public class NoticeVO {
	private int notice_srl;
	private String title;
	private String contents;
	private java.sql.Date postdate;
	
	public int getNotice_srl() {
		return notice_srl;
	}
	public void setNotice_srl(int notice_srl) {
		this.notice_srl = notice_srl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	
	
}
