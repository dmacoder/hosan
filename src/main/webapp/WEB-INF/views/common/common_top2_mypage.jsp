<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 마이페이지영역시 탑2 변환 -->
<nav class="navber navbar-fixed-top"
	id="navbar-fixed-top2">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<ul class="nav navbar-nav navbar-left" id="navbar-nav2">
					<li class="dropdown">
						<a class="dropdown-toggle" href="${pageContext.request.contextPath}/mypage/myplan">마이플레너스</a>
					</li>
					<!-- <li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">채택관리
						<span class="glyphicon glyphicon-chevron-down"></span></a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">채택관리</a></li>
							<li><a href="#">채택내역</a></li>
						</ul>
					</li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">기술관리
						<span class="glyphicon glyphicon-chevron-down"></span></a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">기술관리</a></li>
							<li><a href="#">나의서비스</a></li>
							<li><a href="#">채택요청관리</a></li>
							<li><a href="#">서비스등록</a></li>
							<li><a href="#">광고신청</a></li>
						</ul>
					</li> -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">계정설정
						<span class="glyphicon glyphicon-chevron-down"></span></a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="${pageContext.request.contextPath}/member/myinfo">계정정보</a></li>
							<li><a href="${pageContext.request.contextPath}/member/change_password">비밀번호 변경</a></li>
							<li><a href="${pageContext.request.contextPath}/member/withdraw">회원탈퇴</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" href="${pageContext.request.contextPath}/message">메시지</a>
					</li>
				</ul>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>
	</div>
</nav>