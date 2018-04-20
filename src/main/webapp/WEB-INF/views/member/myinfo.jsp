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
<title>|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myinfo.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="${pageContext.request.contextPath}/resources/js/myinfo.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>


</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<div class="preloader_hide">
		<!-- //PRELOADER -->

		<!-- Top영역 1첫번째 -->
		<div class="row">
			<%@ include file="/WEB-INF/views/common/common_top1.jsp"%>
		</div>
		<!-- Top영역 2첫번째  (마이페이지부분의 탑2 적용)-->
		<div class="row">
			<%@ include file="/WEB-INF/views/common/common_top2_mypage.jsp"%>
		</div>

		<!-- Body영역 -->
		<div class="row" id="row-body-my-profile">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<!-- 서브메뉴부분 -->
				<div class="col-xs-2" id="profile-menu">
					<h3>계정설정</h3>
					<a href="${pageContext.request.contextPath}/member/myinfo"><p>계정정보</p></a>  <a href="${pageContext.request.contextPath}/member/change_password"><p>비밀번호 변경</p></a> <a href="${pageContext.request.contextPath}/member/withdraw"><p>회원탈퇴</p></a>
				</div>
				<!-- 기본정보부분 -->
				<form action="${pageContext.request.contextPath}/member/myinfo" method="post">
					<div class="col-xs-10" id="profile-info">
						<h4>기본정보</h4>
						<input type="hidden" name="action" value="password" />
						<table>
							<tr class="mini-title">
								<!-- 프로필이미지 -->
								<td rowspan="14" class="image-area" align="center">

									<c:choose>

										<c:when test="${not empty loginUserInfo.profile_img_path}">

											<img src="${pageContext.request.contextPath}/upload/displayFile?fileName=${loginUserInfo.profile_img_path}&directory=member/${loginUserInfo.member_srl}/profile" id="profile_Img" class="profile-image" />

										</c:when>

										<c:otherwise>

											<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png" class="profile-image" id="profile_Img" />

										</c:otherwise>
									</c:choose>

									<input id="thumbnail_upload" name="profile_img_path" type="file" style="display: none;">
									<div class="margin-top-20">
										<label id="changeMemberPicture" class="label-margin-none btn btn-default btn-sm width-100px border-888" for="thumbnail_upload"> 사진 변경 </label>
									</div>

								</td>
								<td colspan="4">
									<span class="info-title">아이디</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.user_id}" disabled="disabled" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title"> 이름 ( <c:choose>
											<c:when test="${loginUserInfo.gender == 'M' }">
								남
							</c:when>
											<c:otherwise>
								여
							</c:otherwise>
										</c:choose> )
									</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.user_name}" disabled="disabled" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">생년월일</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.birthday}" disabled="disabled" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">지역</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.address}" disabled="disabled" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">이메일</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.email_address}" disabled="disabled" />
								</td>
							</tr>
							<tr>
								<td colspan="2">이메일수신동의 거부 시에도 기본서비스(주문배송 메일)는 발송됩니다.</td>
								<td colspan="2" style="float: right;">
									<c:choose>
										<c:when test="${loginUserInfo.allow_mailing == 'Y' }">
											<label><input type="radio" name="allow_mailing" value="Y" checked="checked" disabled="disabled" /> 예 </label>&nbsp;&nbsp;
									<label><input type="radio" name="allow_mailing" value="N" disabled="disabled" /> 아니오</label>
										</c:when>
										<c:otherwise>
											<label><input type="radio" name="allow_mailing" value="Y" disabled="disabled" /> 예 </label>
											<label><input type="radio" name="allow_mailing" value="N" checked="checked" disabled="disabled" /> 아니오 </label>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">연락처</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${loginUserInfo.mobile}" disabled="disabled" />
								</td>
							</tr>
							<tr>
								<td colspan="2">메시지수신동의 시에 기본서비스(할인혜택과 이벤트 등의 소식 안내)를 받아보실수 있습니다.</td>
								<td colspan="2" style="float: right;">
									<c:choose>
										<c:when test="${loginUserInfo.allow_message == 'Y' }">
											<label><input type="radio" name="allow_message" value="Y" checked="checked" disabled="disabled" /> 예</label>&nbsp;&nbsp;
									<label><input type="radio" name="allow_message" value="N" disabled="disabled" /> 아니오</label>
										</c:when>
										<c:otherwise>
											<label><input type="radio" name="allow_message" value="Y" disabled="disabled" /> 예</label>
											<label><input type="radio" name="allow_message" value="N" checked="checked" disabled="disabled" /> 아니오</label>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
					<!-- 버튼부분 -->
					<div class="myinfo-edit-btn">
						<button type="submit" class="btn btn-success">수정하기</button>
					</div>
				</form>
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
