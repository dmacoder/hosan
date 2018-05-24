package com.cafe24.hosan.util;

import java.util.Date;

import com.cafe24.hosan.util.common.Criteria;

public class MemberCriteria extends Criteria {

	private int memberSrl;
	private String userId;
	private String emailAddress;
	private String password;
	private String salt;
	private String emailId;
	private String emailHost;
	private String userName;
	private String nickName;

	private int findAccountQuestion;
	private String findAccountAnswer;

	private java.util.Date birthday;
	private String gender;

	private String zonecode;
	private String address;
	private String address2;
	private String sido;
	private String sigungu;

	private String mobile;

	private String allowMailing;
	private String allowMessage;
	private String denied;
	private java.util.Date limitDate;
	private java.util.Date regdate;

	private java.util.Date lastLogin;
	private java.util.Date changePasswordDate;
	private String isAdmin;
	private String description;
	private String extraVars;

	private String profileImgPath;
	private String memberGrade;

	private String sessionKey;
	private java.util.Date sessionLimit;

	public int getMemberSrl() {
		return memberSrl;
	}

	public void setMemberSrl(int memberSrl) {
		this.memberSrl = memberSrl;
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

	public int getFindAccountQuestion() {
		return findAccountQuestion;
	}

	public void setFindAccountQuestion(int findAccountQuestion) {
		this.findAccountQuestion = findAccountQuestion;
	}

	public String getFindAccountAnswer() {
		return findAccountAnswer;
	}

	public void setFindAccountAnswer(String findAccountAnswer) {
		this.findAccountAnswer = findAccountAnswer;
	}

	public java.util.Date getBirthday() {
		return birthday;
	}

	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAllowMailing() {
		return allowMailing;
	}

	public void setAllowMailing(String allowMailing) {
		this.allowMailing = allowMailing;
	}

	public String getAllowMessage() {
		return allowMessage;
	}

	public void setAllowMessage(String allowMessage) {
		this.allowMessage = allowMessage;
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

	public java.util.Date getRegdate() {
		return regdate;
	}

	public void setRegdate(java.util.Date regdate) {
		this.regdate = regdate;
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

	public java.util.Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(java.util.Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	public java.util.Date getChangePasswordDate() {
		return changePasswordDate;
	}

	public void setChangePasswordDate(java.util.Date changePasswordDate) {
		this.changePasswordDate = changePasswordDate;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getExtraVars() {
		return extraVars;
	}

	public void setExtraVars(String extraVars) {
		this.extraVars = extraVars;
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

	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}

	public java.util.Date getSessionLimit() {
		return sessionLimit;
	}

	public void setSessionLimit(java.util.Date sessionLimit) {
		this.sessionLimit = sessionLimit;
	}

}
