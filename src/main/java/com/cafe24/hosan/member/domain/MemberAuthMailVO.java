package com.cafe24.hosan.member.domain;

import java.sql.Date;

public class MemberAuthMailVO {
	
	  private String auth_key;
	  private String user_id;
	  private String password;
	  private String is_register;
	  private java.sql.Date regdate ;
	  
	  
	public MemberAuthMailVO(String auth_key, String user_id, String password, String is_register, Date regdate) {
	
		this.auth_key = auth_key;
		this.user_id = user_id;
		this.password = password;
		this.is_register = is_register;
		this.regdate = regdate;
	}
	
	public String getAuth_key() {
		return auth_key;
	}
	public void setAuth_key(String auth_key) {
		this.auth_key = auth_key;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIs_register() {
		return is_register;
	}
	public void setIs_register(String is_register) {
		this.is_register = is_register;
	}
	public java.sql.Date getRegdate() {
		return regdate;
	}
	public void setRegdate(java.sql.Date regdate) {
		this.regdate = regdate;
	}
	
}
