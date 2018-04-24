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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<!-- CSS작업부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script>
	$(document).ready(function() {

	});

	function checkPassword(f) {
		if (f.password.value == "") {
			alert("패스워드를 입력하세요");
			f.password.focus();
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

		<!-- HOME -->
		<section id="main" class="section">

			<!-- CONTAINER -->
			<div class="container">
				<!-- 좌우측의 공간 확보 -->
				<div class="row" style="margin-top: 220px; margin-bottom: 100px;">
					<div class="col-lg-offset-3 col-lg-6 text-center">

						<h3>회원정보 수정전 비밀번호 확인</h3>
						<small>회원정보 수정전 개인 정보 보호를 위해 비밀번호를 다시 확인 합니다.</small><br />

						<c:if test="${errors.isNotMatchPassword}">
							<span class="text-danger">비밀번호가 일치하지 않습니다.</span>
							<br />
							<br />
						</c:if>

						<c:if test="${errors.isNotAdminModifyMember}">
							<span class="text-danger">관리자 계정만 이용할 수 있습니다.</span>
							<br />
							<br />
						</c:if>
						<form name="passwordFrm" method="post" action="<c:url value="/member/myinfo"/>" onsubmit="return checkPassword(this);">

							<input type="hidden" name="action" value="modify" />
							<table class="table table-bordered">
								<colgroup>
									<col width="50%" />
									<col width="*" />
								</colgroup>
								<tbody>


									<tr>
										<th class="text-center" style="vertical-align: middle;">패스워드</th>

										<td>
											<input type="password" name="password" class="form-control" style="width: 200px;" />
										</td>


									</tr>

								</tbody>
							</table>


							<div class="row text-center" style="">
								<!-- 각종 버튼 부분 -->
								<button type="submit" class="btn btn-danger">확인</button>
								<button type="button" class="btn btn-warning" onclick="history.back();">취소</button>

							</div>


						</form>


					</div>
				</div>

			</div>
			<!-- //CONTAINER -->


		</section>
		<!-- //HOME -->

		<!-- 모달창 -->
		<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->


		<!-- Footer section(하단부분) -->
		<%@ include file="/WEB-INF/views/common/common_bottom.jsp"%>
		<!-- Footer section(하단부분) -->
	</div>
</body>
</html>
