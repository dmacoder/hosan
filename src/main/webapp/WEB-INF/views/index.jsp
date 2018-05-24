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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/video.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/index.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/op.index.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script>
	$(document).ready(function() {

	});
</script>

</head>

<body>
  <!-- PRELOADER -->
  <img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
  <!-- //PRELOADER -->
  <div class="preloader_hide">

    <!-- HEADER -->

    <%@ include file="./common/common_top1_index.jsp"%>

    <%@ include file="./common/common_top2_index.jsp"%>


    <!-- 탑부분(기본적인 틀) -->
    <nav class="navber" id="navbar-fixed-top">
      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-2 col-sm-1 col-xs-0"></div>
          <div class="col-lg-8 col-sm-10 col-xs-12">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="glyphicon glyphicon-align-justify"></span>
              </button>
              <a class="navbar-brand" id="navbar-brand" href="${pageContext.request.contextPath}"><b>卍</b> 호산철학관</a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
              <ul class="nav navbar-nav navbar-right" id="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/board/service?board_type=E">기술자 게시판</a></li>
                <li><a href="${pageContext.request.contextPath}/board/service?board_type=C">의뢰인 게시판</a></li>
                <c:choose>
                  <c:when test="${empty loginUserInfo}">
                    <li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                    <li><a href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
                  </c:when>
                  <c:otherwise>
                    <li class="dropdown size-up">
                    <a class="dropdown-toggle margin-left-10" data-toggle="dropdown" href="javascript:void(0);"> 
                    <c:choose>
                          <c:when test="${loginUserInfo.profileImgPath==null}">
                            <img class="id-image" src="${pageContext.request.contextPath}/resources/images/main_user_gray.png" />
                          </c:when>
                          <c:otherwise>
                            <img class="id-image" src="${pageContext.request.contextPath}/upload/displayFile?fileName=${loginUserInfo.profileImgPath}&directory=member/${loginUserInfo.memberSrl}/profile" />
                          </c:otherwise>
                        </c:choose> 
                        <span class="text-uppercase">${loginUserInfo.userId}님</span> <span class="caret"></span>
                        </a>
                      <ul class="dropdown-menu" id="dropdown-menu">
                        <c:if test="${not empty loginUserInfo && loginUserInfo.isAdmin=='Y'}">
                          <li><a href="${pageContext.request.contextPath}/admin/">관리자페이지</a></li>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}/mypage/myconsulting">나의상담</a></li>
                        <li><a href="${pageContext.request.contextPath}/message">쪽지함</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile/${loginUserInfo.userId}">프로필</a></li>
                        <li><a href="${pageContext.request.contextPath}/member/myinfo">계정정보</a></li>
                        <li><a href="${pageContext.request.contextPath}/member/change_password">비밀번호 변경</a></li>
                        <li><a href="${pageContext.request.contextPath}/member/withdraw">회원탈퇴</a></li>
                      </ul>
                     </li>
                    <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                  </c:otherwise>
                </c:choose>
              </ul>
            </div>
          </div>
          <div class="col-lg-2 col-sm-1 col-xs-0"></div>
        </div>
      </div>
    </nav>
    <!-- 탑부분(기본적인 틀) -->

    <!-- HOME -->
    <section id="main" class="section">

      <!-- CONTAINER -->
      <div class="container "></div>
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
