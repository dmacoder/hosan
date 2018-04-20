package com.cafe24.hosan.member.dto;

/*
 * 프로필에서 보여질 기본 정보만.. 
 */
public class MemberDTO {

	private int member_srl;	
    private String member_type;
    private String user_id;	
    private String email_address;	
    private String email_id;
    private String email_host;
    private String user_name;
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
    
    private String denied;
    private java.util.Date limit_date;		
    
    private String profile_img_path;			
    private String member_grade;
    
    private java.util.Date last_login;

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

	public String getDenied() {
		return denied;
	}

	public void setDenied(String denied) {
		this.denied = denied;
	}

	public java.util.Date getLimit_date() {
		return limit_date;
	}

	public void setLimit_date(java.util.Date limit_date) {
		this.limit_date = limit_date;
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

	public void setLast_login(java.util.Date last_login) {
		this.last_login = last_login;
	}
    
    
    
    
}
