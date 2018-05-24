package com.cafe24.hosan.member.dto;

/*
 * 프로필에서 보여질 기본 정보만.. 
 */
public class MemberDTO {

	private int member_srl;	
   
    private String userId;	
    private String emailAddress;	
    private String emailId;
    private String emailHost;
    private String userName;
    private String nickName;
    private String allow_mailing;
    private String allow_message;
    private String gender;
    private String zonecode;
    private String address;
    private String address2;
    private String sido;
    private String sigungu;
    
    private String mobile;		
		
    
    private String denied;
    private java.util.Date limitDate;		
    
    private String profileImgPath;			
    private String memberGrade;
    
    private java.util.Date lastLogin;

	public int getMember_srl() {
		return member_srl;
	}

	public void setMember_srl(int member_srl) {
		this.member_srl = member_srl;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getEmailHost() {
		return emailHost;
	}

	public void setEmailHost(String emailHost) {
		this.emailHost = emailHost;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public String getZonecode() {
		return zonecode;
	}

	public void setZonecode(String zonecode) {
		this.zonecode = zonecode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getSigungu() {
		return sigungu;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getDenied() {
		return denied;
	}

	public void setDenied(String denied) {
		this.denied = denied;
	}

	public java.util.Date getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(java.util.Date limitDate) {
		this.limitDate = limitDate;
	}

	public String getProfileImgPath() {
		return profileImgPath;
	}

	public void setProfileImgPath(String profileImgPath) {
		this.profileImgPath = profileImgPath;
	}

	public String getMemberGrade() {
		return memberGrade;
	}

	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}

	public java.util.Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(java.util.Date lastLogin) {
		this.lastLogin = lastLogin;
	}

    
    
    
}
