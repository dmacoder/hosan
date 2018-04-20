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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member_withdraw_confirm_password.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script>
function checkAgree(f){
	if(f.idAgree.checked!=true)
	{
		
		popLayerMsg("아이디 재사용 불가 및 복구 불가에 동의 하셔야 합니다.");
		return false;
	}
	if(f.boardAgree.checked!=true)
	{
		popLayerMsg("게시판 서비스 등록 게시글 삭제 불가에 동의 하셔야 합니다.");
		return false;
	}
	
}
function checkPassword(f){
	if (f.user_pw.value == "") {
		alert("패스워드를 입력하세요");
		f.user_pw.focus();
		return false;
	}
	
}
</script>
</head>
<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

		<!-- Top영역 1첫번째 -->
		<div class="row">
		<%@ include file="/WEB-INF/views/common/common_top1.jsp"%>
		</div>
		<!-- Top영역 2첫번째  (마이페이지부분의 탑2 적용)-->
		<div class="row">
		<%@ include file="/WEB-INF/views/common/common_top2_mypage.jsp"%>
		</div>
		
		<!-- Body영역 -->
		<div class="row" id="row-body-withdraw">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<!-- 서브메뉴부분 -->
				<div class="col-xs-2" id="profile-menu">
					<h3>계정설정</h3>
					<a href="${pageContext.request.contextPath}/member/myinfo"><p>계정정보</p></a>
					<a href="${pageContext.request.contextPath}/member/change_password"><p>비밀번호 변경</p></a>
					<a href="${pageContext.request.contextPath}/member/withdraw"><p>회원탈퇴</p></a>
				</div>
				<!-- 회원탈퇴 비밀번호 작성후 탈퇴부분 -->
				<div class="col-xs-10" id="profile-info">
					<h4>회원탈퇴 전 비밀번호 확인</h4>
					<hr/>
					<br/>
					<form name="withdrawFrm" method="post" action="<c:url value="/member/withdraw"/>" onsubmit="return checkPassword(this);">	
						<!-- 폼값으로 넘겨받으면 변조 우려 있음 그나마 세션이 안전하긴함 이것도 암호화해얄듯-->
						<%-- <input type="hidden" name="user_id" value="${sessionScope.USER_ID }"/> --%>
						<input type="hidden" name="step" value="3"/>
						<table>
							<tr>
								<td>
									<p class="confirm-title">확인 비밀번호</p>
									<input type="password" name="password" class="form-control" placeholder="비밀번호 확인후 바로 탈퇴 처리 됩니다."/>
								</td>
							</tr>
							<tr id="confirm-btn">
								<td>
									<button type="button" class="btn btn-success btn-back" onclick="history.back();">취소하기</button>
									<button type="submit" class="btn btn-danger">회원탈퇴</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>

		<!-- 모달창 -->
		<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->

		<!-- Footer section(하단부분) -->
		<%@ include file="/WEB-INF/views/common/common_bottom.jsp"%>
		<!-- Footer section(하단부분) -->
	</div>
</body>
</html>
