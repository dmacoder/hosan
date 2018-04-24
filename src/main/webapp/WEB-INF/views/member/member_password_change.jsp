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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 변경|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/member_password_change.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

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

	function checkPassword(f) {
		if (f.password.value == "") {
			alert("현재 비밀번호를 입력하세요");
			f.password.focus();
			return false;
		}
		if (f.newPassword.value == "") {
			alert("새 비밀번호를 입력하세요");
			f.newPassword.focus();
			return false;
		}
		if (f.newPassword_confirm.value == "") {
			alert("새 비밀번호 확인을 입력하세요");
			f.newPassword_confirm.focus();
			return false;
		}

		if (f.newPassword.value != f.newPassword_confirm.value) {
			alert("새 비밀번호 확인이 일치하지 않습니다.");
			f.newPassword.focus();
			return false;
		}

	}
</script>

</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->

	<!-- Top영역 1첫번째 -->
	<div class="row">
		<%@ include file="/WEB-INF/views/common/common_top1.jsp"%>
	</div>
	<!-- Top영역 2첫번째  (마이페이지부분의 탑2 적용)-->
	<div class="row">
		<%@ include file="/WEB-INF/views/common/common_top2_mypage.jsp"%>
	</div>

	<!-- 모달창 메시지 -->
	<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>
	<!--// 모달창 메시지 -->


	<!-- Body영역 -->
	<div class="row" id="row-body-change-password">
		<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		<div class="col-lg-8 col-sm-10 col-xs-12">
			<!-- 서브메뉴부분 -->
			<div class="col-xs-2" id="profile-menu">
				<h3>계정설정</h3>
				<a href="${pageContext.request.contextPath}/member/myinfo"><p>계정정보</p></a>
				<a href="${pageContext.request.contextPath}/member/change_password"><p>비밀번호 변경</p></a>
				<a href="${pageContext.request.contextPath}/member/withdraw"><p>회원탈퇴</p></a>
			</div>
			<!-- 비밀번호변경부분 -->
			<form name="changePasswordFrm" method="post" action="<c:url value="../member/change_password"/>" onsubmit="return checkPassword(this);">
				<div class="col-xs-10" id="profile-info">
					<table>
						<tr>
							<td colspan="2">
								<h4>현재 비밀번호</h4>
								<hr />
								<p class="password-title">현재 비밀번호
								<c:if test="${not empty error_msg}">
																		
										<strong class="alert-danger"> (알림!)  ${error_msg}</strong>

								</c:if>
								</p>
								<input type="password" name="password" class="form-control" placeholder="기존 비밀번호를 입력해 주세요." />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<h4>변경 비밀번호</h4>
								<hr />
							</td>
						</tr>
						<tr>
							<td colspan="1" id="change-password">
								<p class="password-title">변경할 비밀번호</p>
								<input type="password" class="form-control" style="width: 95%" name="newPassword" placeholder="변경할 비밀번호를 입력해주세요." />
							</td>
							<td colspan="1">
								<p class="password-title">한번 더 입력</p>
								<input type="password" name="newPassword_confirm" class="form-control" placeholder="변경할 비밀번호를 한번 더 입력해주세요." />
							</td>
						</tr>
					</table>
				</div>
				<!-- 버튼부분 -->
				<div class="password-btn">
					<button type="submit" class="btn btn-success">변경하기</button>
				</div>
			</form>
		</div>
		<div class="col-lg-2 col-sm-1 col-xs-0"></div>
	</div>

	<!-- Footer section(하단부분) -->
	<%@ include file="/WEB-INF/views/common/common_bottom.jsp"%>
	<!-- Footer section(하단부분) -->
</body>
</html>

