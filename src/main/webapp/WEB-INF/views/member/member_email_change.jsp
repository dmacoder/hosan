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
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function emailFrmCheck() {
		var f = document.emailFrm;

		if ((!f.email.value)) {
			popLayerMsg("이메일 주소를 입력하세요");
			f.email.focus();

		}

		if (!checkEmail()) {
			return false;
		}

		return true;
	}

	function checkEmail() {
		var f = document.emailFrm;

		var email = f.email.value;

		//이메일 유효성 검사
		var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

		//한글 들어가 있는지 확인
		var isHan = /[ㄱ-ㅎ가-힣]/g;
		if (!isEmail.test(email) || isHan.test(email)) {
			//popLayerMsg("이메일 주소를 다시 확인해주세요.");
			return false;
		}
		f.email.value = email;
		return true;
	}

	function resetDuplicationCheckEmail() {
		var fn = document.emailFrm;
		fn.DuplicationCheckEmail.value = "N";
	}

	$(window).load(function() {

		var email = document.getElementById("email");

		if (email != null) {
			$('#email').on('blur', function() {

				//uid에 입력된 값이 있으면
				if (email.value != null && email.value.length > 0) {

					if (!checkEmail()) {
						$('#emailCheckSpan').removeClass();
						$("#emailCheckSpan").addClass("alert-danger");
						document.getElementById("emailCheckSpan").innerText = "올바른 이메일 주소를 입력하세요.";
						document.emailFrm.DuplicationCheckEmail.value = "N";
						return;
					}

					$.ajax({
						url : '${pageContext.request.contextPath}/member/json/email_check.json', //url에 주소 넣기
						contentType : "text/html; charset=utf-8;",
						data : {
							email_address : email.value
						},
						dataType : 'json', //dataType에 데이터 타입 넣기
						success : function(data) { //success에 성공했을 때 동작 넣기.

							//data.result hasEmail =>
							//중복되지 않은 경우
							if (data.result == "N") {
								idCheck = true;
								
								 $('#emailCheckSpan').removeClass();
									$("#emailCheckSpan").addClass("alert-success");
								document.getElementById("emailCheckSpan").innerText = "사용할 수 있는 이메일 입니다.";
								document.emailFrm.DuplicationCheckEmail.value = "Y";
							}
							//중복된 경우
							else {
								idCheck = false;
								$('#emailCheckSpan').removeClass();
								$("#emailCheckSpan").addClass("alert-danger");
								document.getElementById("emailCheckSpan").innerText = "이미 사용중인 이메일 입니다." + data.result;
								document.emailFrm.DuplicationCheckEmail.value = "N";
							}

						},
						error : function(e) {
							popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);

						}
					});

				}
			});
		}

	});
</script>
</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

		<!-- HEADER -->

		<%@ include file="/WEB-INF/views/common/common_top1.jsp"%>

		<!-- HOME -->
		<section id="main" class="section">

			<!-- CONTAINER -->
			<div class="container">
				<br /> <br /> <br /> <br />
				<form class="form-horizontal" name="emailFrm" method="post" action="${pageContext.request.contextPath}/member/change_email" onsubmit="return emailFrmCheck(this);">
					<input type="hidden" name="action" value="change">

					<div class="row text-center">
						<h4>
							<b><strong class="tit_info">이메일 주소 등록</strong></b>
						</h4>
						<p class="text-center">아이디,아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 사용되므로, 최신정보로 등록해 주세요.</p>
					</div>


					<div class="well container">

						<div class="row text-center">

							<div class="form-group">
								<div class="col-lg-4 text-center">
									<div>이메일</div>
								</div>
								<div class="col-lg-4 text-center">
									<input type="text" class="form-control" name="email" id="email" data-rule-required="true" placeholder="이메일 주소 입력" onkeydown="resetDuplicationCheckEmail()"> <strong id="emailCheckSpan" class="text-danger"></strong> <input type="hidden" name="DuplicationCheckEmail" value="N">


									<button type="button" class="btn btn-info btn-xs" onclick="sendAuthMail();">발송</button>
								</div>
								<div class="col-lg-4 text-center"></div>
							</div>

							<div class="form-group text-center">
								<label for="inputauthkey" class="col-lg-12 text-center">위 메일로 발송된 8자리 인증 번호를 입력해주세요.</label>
							</div>

							<div class="form-group">
								<div class="col-lg-4 text-center">
									인증번호
									<div id="countdown"></div>
								</div>
								<div class="col-lg-4 text-center">
									<input type="text" class="form-control" name="authkey" id="authkey" data-rule-required="true" placeholder="인증번호 입력(10분 동안 유효)" maxlength="8">
								</div>
								<div class="col-lg-4 text-center"></div>
							</div>



						</div>



					</div>


					<div class="row">
						<div class="form-group">
							<div class="col-lg-12 text-center">
								<button type="submit" class="checkAuth_btn btn btn-success">다음</button>
							</div>
						</div>

						<div class="form-group text-center">
							<span class="text-center"> <a class="link_login link_resend" href="javascript:popModal('#layer_resend');" target="_blank"> 인증메일을 받지 못하셨나요? </a>
							</span>
						</div>
					</div>

				</form>

				<script>
					$(window).load(function() {
						$('.checkAuth_btn').on('click', function() {
							//인증번호 확인 요청시 버튼 잠시 비활성화
							$(this).prop("disabled", true);

							if (checkAuthKey(this.form)) {
								//이메일 인증 완료 되었으니 회원가입 처리요청

								this.form.submit();
							}

						});
					});

					//JAVA ==> JSTL ==> HTML ==> JAVASCRIPT 실행순서

					function checkAuthKey(f) {
						if (!f.authkey.value) {
							popLayerMsg("인증 번호를 입력하세요.");
							$('.checkAuth_btn').prop("disabled", false);
							f.authkey.focus();
							return false;
						}

						var url = "${pageContext.request.contextPath}/member/json/authkey_check.json";
						var params = "authkey=" + f.authkey.value + "&user_id=${emailInfo.user_id}&password=${emailInfo.password}";
						var isMatched = false;
						// alert(url+"?"+params);
						//popLayerMsg(url+"?"+params); 
						popLayerMsg("인증 번호 확인중");
						//동기방식으로 호출 그래야 알맞게 return 됨
						$.ajax({
							type : 'post',
							async : false,
							url : url,
							dataType : 'json',
							data : params,

							success : function(data) { //success에 성공했을 때 동작 넣기.

								//인증번호 일치
								if (data.result == "success") {
									//alert("인증 성공");
									//popLayerMsg("인증 되었습니다.");
									isMatched = true;
								}
								//중복된 경우
								else {

									popModal("#layer_unmatched_authkey");
									$('.checkAuth_btn').prop("disabled", false);
									isMatched = false;
								}

							},
							error : function() {
								popLayerMsg("AJAX Error 발생");
								$('.checkAuth_btn').prop("disabled", false);
								isMatched = false;
								//alert("ajax error");
							}
						});

						return isMatched;

					}

					function popModal(modalSelector) {

						$(modalSelector).modal();

					}

					function popResendAuthMail() {

						$("#layer_resend").modal();

					}

					function sendAuthMail() {

						$("#layer_resend .close").click();

						//countdown( "countdown", 10, 0 );

						var url = "${pageContext.request.contextPath}/mail/mail_authkey_send.json";
						var params = "to=" + document.emailFrm.email.value + "&user_id=${emailInfo.user_id}&password=${emailInfo.password}";

						//alert(url+"?"+params);
						popLayerMsg("인증메일 발송중 입니다.");

						//var jsonparams = JSON.stringify(${emailInfo}); 

						$.ajax({
							type : 'post',
							//async:false,
							url : url,
							dataType : 'json', //dataType에 데이터 타입 넣기
							data : params,

							success : function(data) { //success에 성공했을 때 동작 넣기.

								//중복되지 않은 경우
								if (data.result == "success") {

									popLayerMsg("인증 메일이 발송 되었습니다.");

									//$('#layer_resend').modal().hide();

									//alert("발송성공");
									//document.getElementById("Span").innerText = "인증 메일이 발송 되었습니다.";
								}
								//중복된 경우
								else {
									//alert("메일발송실패");

									popLayerMsg("메일 발송 오류");
									//document.getElementById("Span").innerText = "이미 사용중이거나 탈퇴한 아이디입니다."+data.result;
								}

							},
							error : function() {
								popLayerMsg("AJAX Error 발생");
								//alert("ajax error");
							}
						});

					}

					function countdown(elementName, minutes, seconds) {
						var element, endTime, hours, mins, msLeft, time;

						function twoDigits(n) {
							return (n <= 9 ? "0" + n : n);
						}

						function updateTimer() {
							msLeft = endTime - (+new Date);
							if (msLeft < 1000) {
								element.innerText = "인증기간 만료!";
							} else {
								time = new Date(msLeft);
								hours = time.getUTCHours();
								mins = time.getUTCMinutes();
								element.innerHTML = (hours ? hours + ':' + twoDigits(mins) : mins) + ':' + twoDigits(time.getUTCSeconds());
								setTimeout(updateTimer, time.getUTCMilliseconds() + 500);
							}
						}

						element = document.getElementById(elementName);
						endTime = (+new Date) + 1000 * (60 * minutes + seconds) + 500;
						updateTimer();
					}

					window.onload = function() {

						//sendAuthMail();
					}
				</script>

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
