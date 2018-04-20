<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member_password_change.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<style type="text/css">
body{
	background-color: #FAFAFA;
}

.panel-success{
	margin-top: 200px;
}

#login-btn{
	background-color: #333333;
	border-radius: 5px;
	height: 60px;
}
</style>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>


<script type="text/javascript">
	function logout() {
		var ans = confirm("정말로 로그아웃 하시겠습니까?");
		if (ans == true) {
			location.href = "${pageContext.request.contextPath}/member/logout";
		} else {
			popLayerMsg("로그아웃을 취소하셨습니다.");
		}
	}

	function loginFrmCheck() {
		var f = document.loginFrm;
		if (f.user_id.value == "") {
			popLayerMsg("아이디를 입력하세요");
			f.user_id.focus();
			return false;
		}
		if (f.password.value == "") {
			popLayerMsg("패스워드를 입력하세요");
			f.password.focus();
			return false;
		}

	}
</script>

</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
		<div class="preloader_hide">
	<!-- 탑부분(기본적인 틀) -->
	<nav class="navber navbar-fixed-top" id="navbar-fixed-top">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
				<div class="col-lg-8 col-sm-10 col-xs-12">
					<div class="navbar-header">
						<a class="navbar-brand" id="navbar-brand"
							href="${pageContext.request.contextPath}"><b>♣</b>
							OurPlanners</a>
					</div>
				</div>
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			</div>
		</div>
	</nav>
	
	<!-- CONTAINER -->
	<div class="container">
		<br /><br />
		<c:choose>
			<c:when test="${empty sessionScope.loginUserInfo}">
				<div class="col-md-4 col-sm-3"></div>
				<div class="col-md-4 col-sm-6">
					<div class="panel panel-success">
						<div class="panel-heading">
							<div class="panel-title"><%=request.getAttribute("ERROR_MSG") == null ? "환영합니다!" : request.getAttribute("ERROR_MSG")%>
							</div>
						</div>
						<%
							if (request.getAttribute("ERROR_MSG") == null) {
										//$("p").css({"background-color": "yellow", "font-size": "200%"});
									}
						%>
						<div class="panel-body">
							<form class="form-signin" action="${pageContext.request.contextPath}/member/loginPost" method="post"
								name="loginFrm" onsubmit="return loginFrmCheck();">
								<!-- <h2 class="form-signin-heading">로그인</h2> -->
								<label>아이디</label>
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span><input type="text"
										class="form-control" name="user_id" placeholder="아이디">
								</div>
								<label>비밀번호</label>
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-lock"></i></span> <input type="password"
										class="form-control" name="password" placeholder="비밀번호">
								</div>
								<div class="input-group">
									<label> <input type="checkbox" name="useCookie">로그인
										상태 유지
									</label>
								</div>
								<div class="info_account">
									<div class="sign_up_account ">
										<a href="${pageContext.request.contextPath}/member/join" id="signUp">회원가입</a><span class="txt_bar">|</span>
										<span class="account_more"> <a href="${pageContext.request.contextPath}/find/id"
											class="link_more">아이디 찾기</a> <span class="txt_bar">|</span>
											<a href="${pageContext.request.contextPath}/find/password" class="link_more">비밀번호
												찾기</a>
										</span> <span class="ico_login ico_top"></span>
									</div>
								</div>
								<button type="submit" class="btn btn-lg btn-primary btn-block" id="login-btn">로그인</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-3"></div>
			</c:when>
			<c:otherwise>
			
			<script>
			location.href='${pageContext.request.contextPath}';
			</script>
				<table border="1" style="width: 300px">
					<tr>
						<td>아이디</td>
						<td>${sessionScope.loginUserInfo.user_id }</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${sessionScope.loginUserInfo.user_name }</td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="button"
							value="로그아웃" onclick="logout();" /></td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- //CONTAINER -->
	
	

	<!-- 모달창 -->
	<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>

	<script src="${pageContext.request.contextPath}/resources/js/script.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
</div>
</body>
</html>
