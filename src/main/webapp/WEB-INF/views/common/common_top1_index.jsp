<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	// [ 네비게이션 스크롤 시 변화 JS ] 
	//Hide Header on on scroll down
	var didScroll;
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $('#navbar-fixed-top').outerHeight();
	$(window).scroll(function(event) {
		didScroll = true;
	});
	setInterval(function() {
		if (didScroll) {
			hasScrolled();
			didScroll = false;
		}
	}, 1000);
	function hasScrolled() {
		var st = $(this).scrollTop();
		// Make sure they scroll more than delta
		if (Math.abs(lastScrollTop - st) <= delta)
			return;
		// If they scrolled down and are past the navbar, add class .nav-up. 
		// This is necessary so you never see what is "behind" the navbar. 
		if (st > lastScrollTop && st > navbarHeight) {
			// Scroll Down
			$('#navbar-fixed-top, #navbar-fixed-top2').removeClass('nav-up').addClass('nav-down').removeClass('hide');
		} else {
			// Scroll Up
			if (st + $(window).height() < $(document).height()) {
				$('#navbar-fixed-top, #navbar-fixed-top2').removeClass('nav-down').addClass('nav-up');
			}
		}
		lastScrollTop = st;
	}
</script>
<header>
	<nav class="navber navbar-fixed-top hide" id="navbar-fixed-top">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
				<div class="col-lg-8 col-sm-10 col-xs-12">
					<div class="navbar-header">
						<a class="navbar-brand" id="navbar-brand" href="${pageContext.request.contextPath}"><b>♣</b> OurPlanners</a>
					</div>
					<form class="navbar-form navbar-left" action="${pageContext.request.contextPath}/board/search">
						<div class="input-group">
						
						
						<input type="hidden" name="board_type" value=""/>
						<input type="hidden" name="searchType" value="tc"/>
						
							<input type="text" class="form-control" placeholder="검색어를 입력해 주세요" name="keyword" id="form-control" />
							<div class="input-group-btn">
								<button class="btn btn-default" id="btn-default" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
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
									<img id="top_profile_Img" class="id-image" src="${pageContext.request.contextPath}/resources/images/main_user_gray.png"  />
								</c:when>
								<c:otherwise>
									<img id="top_profile_Img" class="id-image" src="${pageContext.request.contextPath}/upload/displayFile?fileName=${loginUserInfo.profileImgPath}&directory=member/${loginUserInfo.memberSrl}/profile"  />
								</c:otherwise>
							</c:choose>
							<span class="text-uppercase">${loginUserInfo.userId}님</span> <span class="caret"></span></a>
								<ul class="dropdown-menu" id="dropdown-menu">
									<c:if test="${not empty loginUserInfo && loginUserInfo.isAdmin=='Y'}">
										<li><a href="${pageContext.request.contextPath}/admin/">관리자페이지</a></li>
									</c:if>
									<li><a href="${pageContext.request.contextPath}/mypage/myplan">마이플랜</a></li>
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
				<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			</div>
		</div>
	</nav>
</header>
