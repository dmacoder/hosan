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
<title>문의 메일 보내기|OUR PLANNERS</title>
<jsp:useBean id="today" class="java.util.Date" scope="page" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700|Raleway:300,400,500,600'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_1.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonTop_2.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonBottom.css?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->


<!-- include codemirror (codemirror.css, codemirror.js, xml.js, formatting.js) -->
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.css">
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/monokai.css">
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>

<script src="${pageContext.request.contextPath}/resources/pixit/admin/assets/plugins/summernote/summernote.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.js"></script>

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script>
	$(document).ready(function() {
		$('.summernote').summernote({
			height : 300, // set editor height
			minHeight : null, // set minimum height of editor
			maxHeight : null, // set maximum height of editor
			focus : true
		// set focus to editable area after initializing summernote
		});
	});
</script>
<script>
	$(document).ready(function() {

		loadEmail();

		$('#email_send_btn').on('click', emailSend);

		$('#saveEmailBtn').on('click', saveEmail);

	});

	function loadEmail() {

		var saveFlag = localStorage.getItem("email_save_flag");

		if (saveFlag != null & saveFlag == 'Y') {
			if (confirm("임시저장된 메일이 있습니다. 불러 오시겠습니까? ")) {

				var to = localStorage.getItem("email_to");

				if (to != null) {
					$("input[type='text'][name='to']").val(to);
				}
				var subject = localStorage.getItem("email_subject");
				if (subject != null) {
					$("input[type='text'][name='subject']").val(subject);
				}
				var content = localStorage.getItem("email_content");
				if (content != null) {
					//alert(content);
					//$('textarea[name="content"]').html(content);
					$('#content').summernote('editor.pasteHTML', content);
				}

				localStorage.clear();

			} else {
				localStorage.clear();
			}
		}

	}

	function saveEmail() {

		localStorage.setItem("email_save_flag", "Y");

		localStorage.setItem("email_to", $("input[type='text'][name='to']").val());

		localStorage.setItem("email_subject", $("input[type='text'][name='subject']").val());

		var contents = $('.summernote').code();

		$('textarea[name="content"]').html($('.summernote').code());

		var ir1 = $("#content").val();

		localStorage.setItem("email_content", contents);

		popLayerMsg("임시 저장 되었습니다.");
	}

	function checkEmail(email) {

		//이메일 유효성 검사
		var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

		//한글 들어가 있는지 확인
		var isHan = /[ㄱ-ㅎ가-힣]/g;
		if (!isEmail.test(email) || isHan.test(email)) {
			popLayerMsg("이메일 주소를 다시 확인해주세요.");
			return false;
		}

		return true;
	}

	function alertMailing() {
		popLayerMsg("메일 발송중 입니다.");
	}

	function emailSend() {

		if ($("input[type='text'][name='to']").val() == "") {
			alert("받는 사람을 입력해주세요");
			$("input[type='text'][name='to']").focus();
			return;
		}

		if (!checkEmail($("input[type='text'][name='to']").val())) {
			$("input[type='text'][name='to']").focus();
			return false;
		}

		if ($("input[type='text'][name='subject']").val() == "") {
			alert("제목 을 입력해주세요");
			$("input[type='text'][name='subject']").focus();
			return;
		}

		var contents = $('.summernote').code();

		$('textarea[name="content"]').html($('.summernote').code());

		var ir1 = $("#content").val();

		if (ir1 == "" || ir1 == null || ir1 == '&nbsp;' || ir1 == '<p>&nbsp;</p>') {
			alert("내용을 입력해주세요");
			$('textarea[name="content"]').focus();
			return;
		}

		var url = "${pageContext.request.contextPath}/mail/mail_send.json";
		var to = $("input[type='text'][name='to']").val();
		var subject = $("input[type='text'][name='subject']").val();
		var params = "to=" + to + "&subject=" + $("input[type='text'][name='subject']").val() + "&content=" + contents

		//popLayerMsg(url+"?"+params);

		popLayerMsg("메일 발송중 입니다.");

		//var jsonparams = JSON.stringify(${joinInfo}); 

		$('#email_send_btn').off('click', emailSend);

		$('#email_send_btn').css({
			'background-color' : 'gray'
		});

		$('#email_send_btn').on('click', alertMailing);

		$.ajax({
			type : 'post',

			url : url,
			dataType : 'json', //dataType에 데이터 타입 넣기
			data : params,

			success : function(data) { //success에 성공했을 때 동작 넣기.

				//중복되지 않은 경우
				if (data.result == "success") {

					popLayerMsg("메일이 발송 되었습니다.");
					emailReset();
					//$('#email_send_btn').css({'background-color': 'white'});
					$('#email_send_btn').removeAttr("style");
					$('#email_send_btn').on('click', emailSend);
					localStorage.clear();
				}
				//중복된 경우
				else {

					popLayerMsg("메일 발송 오류");
					//$('#email_send_btn').css({'background-color': 'white'});
					$('#email_send_btn').removeAttr("style");
					$('#email_send_btn').on('click', emailSend);
					//document.getElementById("Span").innerText = "이미 사용중이거나 탈퇴한 아이디입니다."+data.result;
				}

			},
			error : function() {

				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}
		});

	}
	function emailReset() {
		$('form').each(function() {
			this.reset();
		});
		//내용 클리어
		$('.summernote').code("");
	}

	///mail/mail_send.json?to=&subject=&content
</script>

</head>

<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
	<div class="preloader_hide">

		<!-- header1(네비게이션 탑1) -->
		<%@ include file="/WEB-INF/views/common/common_top1.jsp"%>
		<!-- header1(네비게이션 탑1) -->
		<!-- header2(네비게이션 탑2) -->
			<%@ include file="/WEB-INF/views/common/common_top2_mypage.jsp"%>
		<!-- header2(네비게이션 탑2) -->

		<!-- HOME -->
		<section id="main" class="section" style="margin-top: 120px;">

			<!-- CONTAINER -->
			<div class="container ">
				<!-- BEGIN WRAPPER -->

				<div class="page-title">
					<i class="icon-custom-left"></i>
					<h3>
						<strong>문의</strong> 메일 보내기
					</h3>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="row">
									<div class="col-md-12">
										<div class="border-bottom">
											<div class="pull-left">
												<a href="javascript:history.back();" class=" btn btn-default"><i class="fa fa-arrow-left fa-fw"></i> 뒤로가기</a>
											</div>
											<div class="pull-left p-l-20">
												<a href="javascript:;" id="saveEmailBtn" class=" btn btn-success"><i class="fa fa-floppy-o fa-fw"></i> 임시저장</a>
											</div>
											<div class="clearfix m-b-20"></div>
										</div>
										<form class="form-horizontal p-t-20" role="form">
											<div class="form-group">
												<label for="to" class="col-sm-2 control-label">받는사람:</label>
												<div class="col-sm-10">
													<div class="input-group">
														<input type="text" class="form-control" name="to" id="to" disabled="disabled" value="launchersf@gmail.com" />
													</div>
												</div>
											</div>

											<div id="cc" class="collapse">
												<div class="form-group">
													<label for="Cc" class="col-sm-2 control-label">참조:</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="Cc" />
													</div>
												</div>
												<div class="form-group">
													<label for="Bcc" class="col-sm-2 control-label">숨은참조:</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="Bcc">
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="Bcc" class="col-sm-2 control-label">보내는 사람:</label>
												<div class="col-sm-6">
													<div class="btn-group">
														<button type="button" class="btn btn-default dropdown-toggle width-230" data-toggle="dropdown">
															<i class="fa fa-ellipsis-horizontal"></i><span class="float-left"><strong>${loginUserInfo.email_address}</strong></span> <span class="float-right"><i class="fa fa-angle-down"></i></span>
														</button>
														<ul class="dropdown-menu">
															<li><a href="#">${loginUserInfo.email_address}</a></li>
														</ul>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="Bcc" class="col-sm-2 control-label">서명:</label>
												<div class="col-sm-6">
													<div class="btn-group">
														<button type="button" class="btn btn-default dropdown-toggle width-230" data-toggle="dropdown">
															<i class="fa fa-ellipsis-horizontal"></i><span class="float-left"><strong>Signature</strong></span> <span class="float-right"><i class="fa fa-angle-down"></i></span>
														</button>
														<ul class="dropdown-menu">
															<li><a href="#">Signature</a></li>
														</ul>
													</div>
												</div>
											</div>



											<div class="form-group">
												<label for="subject" class="col-sm-2 control-label">제목:</label>
												<div class="col-sm-10">
													<div class="input-group">
														<input type="text" class="form-control" name="subject" id="subject" />
													</div>
												</div>
											</div>

											<div class="clearfix"></div>
											<textarea class="summernote" name="content" id="content"></textarea>

											<div class="text-center footer-message">
												<a href="javascript:;" onclick="emailReset()" class="btn btn-default"><i class="fa fa-times-circle"></i> 리셋</a> <a href="javascript:;" id="email_send_btn" class="btn btn-primary"><i class="fa fa-share fa-fw"></i> 메일 전송</a>
											</div>

										</form>




									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
			<!-- //CONTAINER -->


		</section>
		<!-- //HOME -->

		<!-- 모달창 -->
		<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->


		
		<!-- Footer (하단부분) -->
		<%@ include file="/WEB-INF/views/common/common_bottom.jsp"%>
		<!--// Footer (하단부분) -->
	</div>
</body>
</html>
