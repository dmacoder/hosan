package com.cafe24.hosan.member.domain;

import java.util.Date;

public class MemberVO {
	
	private int member_srl;	
    private String member_type;
    private String user_id;	
    private String email_address;	
    private String password;	
    private String salt;
    private String email_id;
    private String email_host;
    private String user_name;
    private int find_account_question;
    private String find_account_answer;
    //@DateTimeFormat(pattern = "yyyy/MM/dd")
    private java.util.Date birthday;
    private String allow_mailing;
    private String allow_message;
    private String gender;
    private String address;
    private String mobile;		
    private String career;			
    private String career_history;			
    private String license_date;				
    private String license_provider;		
    private String license_description;

    private String company_name;
    private String company_number;				
    private java.util.Date regdate;			
    private String denied;
    private java.util.Date limit_date;		
    private String is_admin;
    private java.util.Date change_password_date;			
    private String profile_img_path;			
    private String member_grade;
    private java.util.Date last_login;
	private String sessionKey;
    
    public MemberVO() {}
    
	public MemberVO(String member_type, String user_id, String email_address, String password, String salt,
			String email_id, String email_host, String user_name, int find_account_question, String find_account_answer,
			Date birthday, String allow_mailing, String allow_message, String gender, String address, String mobile,
			String career, String career_history, String license_date, String license_provider,
			String license_description, String company_name, String company_number, Date regdate, String denied,
			Date limit_date, String is_admin, Date change_password_date, String profile_img_path, String member_grade,
			Date last_login) {

		this.member_type = member_type;
		this.user_id = user_id;
		this.email_address = email_address;
		this.password = password;
		this.salt = salt;
		this.email_id = email_id;
		this.email_host = email_host;
		this.user_name = user_name;
		this.find_account_question = find_account_question;
		this.find_account_answer = find_account_answer;
		this.birthday = birthday;
		this.allow_mailing = allow_mailing;
		this.allow_message = allow_message;
		this.gender = gender;
		this.address = address;
		this.mobile = mobile;
		this.career = career;
		this.career_history = career_history;
		this.license_date = license_date;
		this.license_provider = license_provider;
		this.license_description = license_description;
		this.company_name = company_name;
		this.company_number = company_number;
		this.regdate = regdate;
		this.denied = denied;
		this.limit_date = limit_date;
		this.is_admin = is_admin;
		this.change_password_date = change_password_date;
		this.profile_img_path = profile_img_path;
		this.member_grade = member_grade;
		this.last_login = last_login;
	}

	public MemberVO(int member_srl, String member_type, String user_id, String email_address, String password,
			String salt, String email_id, String email_host, String user_name, int find_account_question,
			String find_account_answer, Date birthday, String allow_mailing, String allow_message, String gender,
			String address, String mobile, String career, String career_history, String license_date,
			String license_provider, String license_description,  String company_name,
			String company_number, Date regdate, String denied, Date limit_date, String is_admin,
			Date change_password_date, String profile_img_path, String member_grade, Date last_login) {
		this.member_srl = member_srl;
		this.member_type = member_type;
		this.user_id = user_id;
		this.email_address = email_address;
		this.password = password;
		this.salt = salt;
		this.email_id = email_id;
		this.email_host = email_host;
		this.user_name = user_name;
		this.find_account_question = find_account_question;
		this.find_account_answer = find_account_answer;
		this.birthday = birthday;
		this.allow_mailing = allow_mailing;
		this.allow_message = allow_message;
		this.gender = gender;
		this.address = address;
		this.mobile = mobile;
		this.career = career;
		this.career_history = career_history;
		this.license_date = license_date;
		this.license_provider = license_provider;
		this.license_description = license_description;
	
		this.company_name = company_name;
		this.company_number = company_number;
		this.regdate = regdate;
		this.denied = denied;
		this.limit_date = limit_date;
		this.is_admin = is_admin;
		this.change_password_date = change_password_date;
		this.profile_img_path = profile_img_path;
		this.member_grade = member_grade;
		this.last_login = last_login;
	}
	

	public String getSessionKey() {
		return sessionKey;
	}


	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}


	public int getMember_srl() {
		return member_srl;
	}
	public void setMember_srl(int member_srl) {
		this.member_srl = member_srl;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getEmail_address() {
		return email_address;
	}
	public void setEmail_address(String email_address) {
		this.email_address = email_address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getEmail_id() {
		return email_id;
	}
	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}
	public String getEmail_host() {
		return email_host;
	}
	public void setEmail_host(String email_host) {
		this.email_host = email_host;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getFind_account_question() {
		return find_account_question;
	}
	public void setFind_account_question(int find_account_question) {
		this.find_account_question = find_account_question;
	}
	public String getFind_account_answer() {
		return find_account_answer;
	}
	public void setFind_account_answer(String find_account_answer) {
		this.find_account_answer = find_account_answer;
	}
	public java.util.Date getBirthday() {
		return birthday;
	}
	public void setBirthday(java.sql.Date birthday) {
		this.birthday = birthday;
	}
	public String getAllow_mailing() {
		return allow_mailing;
	}
	public void setAllow_mailing(String allow_mailing) {
		this.allow_mailing = allow_mailing;
	}
	public String getAllow_message() {
		return allow_message;
	}
	public void setAllow_message(String allow_message) {
		this.allow_message = allow_message;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getCareer_history() {
		return career_history;
	}
	public void setCareer_history(String career_history) {
		this.career_history = career_history;
	}
	public String getLicense_date() {
		return license_date;
	}
	public void setLicense_date(String license_date) {
		this.license_date = license_date;
	}
	public String getLicense_provider() {
		return license_provider;
	}
	public void setLicense_provider(String license_provider) {
		this.license_provider = license_provider;
	}
	public String getLicense_description() {
		return license_description;
	}
	public void setLicense_description(String license_description) {
		this.license_description = license_description;
	}

	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getCompany_number() {
		return company_number;
	}
	public void setCompany_number(String company_number) {
		this.company_number = company_number;
	}
	public java.util.Date getRegdate() {
		return regdate;
	}
	public void setRegdate(java.sql.Date regdate) {
		this.regdate = regdate;
	}
	public String getDenied() {
		return denied;
	}
	public void setDenied(String denied) {
		this.denied = denied;
	}
	public java.util.Date getLimit_date() {
		return limit_date;
	}
	public void setLimit_date(java.sql.Date limit_date) {
		this.limit_date = limit_date;
	}
	public String getIs_admin() {
		return is_admin;
	}
	public void setIs_admin(String is_admin) {
		this.is_admin = is_admin;
	}
	public java.util.Date getChange_password_date() {
		return change_password_date;
	}
	public void setChange_password_date(java.sql.Date change_password_date) {
		this.change_password_date = change_password_date;
	}
	public String getProfile_img_path() {
		return profile_img_path;
	}
	public void setProfile_img_path(String profile_img_path) {
		this.profile_img_path = profile_img_path;
	}
	public String getMember_grade() {
		return member_grade;
	}
	public void setMember_grade(String member_grade) {
		this.member_grade = member_grade;
	}
	public java.util.Date getLast_login() {
		return last_login;
	}
	public void setLast_login(java.sql.Date last_login) {
		this.last_login = last_login;
	}
	
    
    
}
