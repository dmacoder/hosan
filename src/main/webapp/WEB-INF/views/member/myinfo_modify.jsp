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



<%--
//로그인이 안된 경우나 비밀번호가 틀린 경우 관리자 계정이 아닌 경우 정보보기 페이지로 포워딩
 if (session == null || request.getAttribute("userInfo") == null || ((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("N") && (request.getAttribute("isMatchedPass") != "Y")) 	
		request.getRequestDispatcher("/member/myinfo").forward(request, response);
 
 
 --%>
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/myinfo.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
<script>
$(document).ready(function(){
	
	//옵션 순서값으로 선택 (인덱스 0부터)
	//$("#find_account_question option:eq(${userInfo.find_account_question}+1)").prop("selected", true);
	
	//밸류값으로 선택
	$("#find_account_question").val("${userInfo.find_account_question}").prop("selected", true);
	
	//성별 선택하기 jstl 말고 jquery로 하는법
	//$('input:radio[name=gender]:input[value='${userInfo.gender}']').attr("checked", true);
	
	//선택된 라디오 값 가져오기
	//var genderType = $(":input:radio[name=gender]:checked").val();
	
	
  
    

    $('#user_name').keyup(function(event){
        
        var divUsername = $('#divUsername');
         
        if($('#user_name').val()==""){
        	divUsername.removeClass("has-success");
        	divUsername.addClass("has-error");
        	$('#user_name').focus();
        }else{
        	divUsername.removeClass("has-error");
        	divUsername.addClass("has-success");
        }
    });
    
	
	
});




function logoutGo() {
	var ans = confirm("정말로 로그아웃 하시겠습니까?");
	if (ans == true) {
		location.href = "logout.jsp";
	} else {
		alert("로그아웃을 취소하셨습니다.");
	}
}

function loginFrmCheck() {
	var f = document.loginFrm;
	if (f.user_id.value == "") {
		popLayerMsg("아이디를 입력하세요");
		f.user_id.focus();
		return false;
	}
	if (f.user_pw.value == "") {
		popLayerMsg("패스워드를 입력하세요");
		f.user_pw.focus();
		return false;
	}

}


function winOpenAtCenter(sURL, sWindowName, w, h, sScroll) {
	// 화면 중앙으로 Popup 띄우기.. 스크롤바는 옵션..
	// ex)
	// openWin("test.jsp", "winTest", 400, 300); ☞ 스크롤바 없음
	// openWin("test.jsp", "winTest", 400, 300, "yes"); ☞ 스크롤바 있음
	// openWin("test.jsp", "winTest", 400, 300, "auto"); ☞ 스크롤바 자동

	var x = (screen.width - w) / 2;
	var y = (screen.height - h) / 2;

	if (sScroll == null)
		sScroll = "no";

	var sOption = "";
	sOption = sOption
			+ "toolbar=no, channelmode=no, location=no, directories=no, resizable=no, menubar=no";
	sOption = sOption + ", scrollbars=" + sScroll + ", left=" + x
			+ ", top=" + y + ", width=" + w + ", height=" + h;

	var win = window.open(sURL, sWindowName, sOption);
	return win;
}
function openPopChangeEmail() {
	winOpenAtCenter(
			"${pageContext.request.contextPath}/member/change_email",
			"emailchange", screen.width, screen.height, "yes");
}

function postOpen() {
	new daum.Postcode({
		oncomplete : function(data) {
			var f = document.modifyFrm;
			
			f.address.value = data.sido +" "+data.sigungu;
			
			

		}
	}).open();
}

function checkForm(f){
	
	if (!f.user_name.value) {
		popLayerMsg("이름을 입력하세요");
		f.user_name.focus();
		return false;
	}
	
	if (!checkName()) {
		return false;
	}

	var isGender = false;
	for (var i = 0; i < f.gender.length; i++) {
		if (f.gender[i].checked == true) {
			isGender = true;
			break;
		}
	}

	if (isGender == false) {
		popLayerMsg("성별을 선택하세요.");
		f.gender[0].focus();
		return false;
	}

	if (!f.birthday.value ) {
		popLayerMsg("생년월일을 입력하세요");
		f.birthday.focus();
		return false;
	}
	
	/* if (!checkBirthday()) {
		return false;
	} */

	if ((!f.mobile.value)) {
		popLayerMsg("휴대폰 번호를 입력하세요");
		f.mobile.focus();
		return false;
	}
	
	return true;
}

function checkName() {
	
	var f = document.modifyFrm;
	var namePattern = /[^가-힣a-zA-Z0-9]/gi;
	if (namePattern.test(f.user_name.value)) {
		popLayerMsg("한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
		return false;
	}
	return true;
}

function calcAge(birth) {
	var date = new Date();
	var year = date.getFullYear();
	var month = (date.getMonth() + 1);
	var day = date.getDate();
	if (month < 10)
		month = '0' + month;
	if (day < 10)
		day = '0' + day;
	var monthDay = month + '' + day;

	birth = birth.replace('-', '').replace('-', '');
	var birthdayy = birth.substr(0, 4);
	var birthdaymd = birth.substr(4, 4);

	var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
	return age;
}

function isValidDate(param) {
	try {
		param = param.replace(/-/g, '');

		// 자리수가 맞지않을때
		if (isNaN(param) || param.length != 8) {
			return false;
		}

		var year = Number(param.substring(0, 4));
		var month = Number(param.substring(4, 6));
		var day = Number(param.substring(6, 8));

		if (month < 1 || month > 12) {
			return false;
		}

		var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var maxDay = maxDaysInMonth[month - 1];

		// 그레고리력 윤년 체크(4로 나누어 떨어지면서 100으로 나누어 떨어지지않고,400으로 나누어 떨어지는 년도)
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
			maxDay = 29;
		}

		if (day <= 0 || day > maxDay) {
			return false;
		}
		return true;

	} catch (err) {
		return false;
	}
	
}

function checkBirthday() {
	var f = document.modifyFrm;

	var birthday = f.birthday.value;

	if (!isValidDate(birthday)) {
		popLayerMsg("생년월일을 다시 확인해주세요.");
		return false;
	}

	//document.getElementById("birthday").value = birthday;

	var age = calcAge(birthday);
	if (age < 0) {
		popLayerMsg("미래에서 오셨나요?");
		return false;
	}

	return true;
}


function checkEmail() {
	var f = document.modifyFrm;

	var email_id = f.email_id.value;
	var email_domain = f.email_domain.value;

	var email = email_id.concat("@").concat(email_domain);

	//이메일 유효성 검사
	var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
	//한글 들어가 있는지 확인
	var isHan = /[ㄱ-ㅎ가-힣]/g;
	if (!isEmail.test(email) || isHan.test(email)) {
		popLayerMsg("이메일 주소를 다시 확인해주세요.");
		return false;
	}
	f.email.value = email;
	return true;
}

function checkID() {
	var f = document.modifyFrm;

	if (!f.user_id.value) {
		popLayerMsg("아이디를 입력하세요.");
		return false;
	}

	var id = f.user_id.value;
	
	var isValidID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	if (!isValidID.test(id)) {
		popLayerMsg("아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
		
		return false;
	}
	return true;
}

function isNumeric(num, opt){
	  // 좌우 trim(공백제거)을 해준다.
	  num = String(num).replace(/^\s+|\s+$/g, "");
	  if(typeof opt == "undefined" || opt == "1"){
	    // 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
	    var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	  }else if(opt == "2"){
	    // 부호 미사용, 자릿수구분기호 선택, 소수점 선택
	    var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	  }else if(opt == "3"){
	    // 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
	    var regex = /^[0-9]+(\.[0-9]+)?$/g;
	  }else{
	    // only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
	    var regex = /^[0-9]$/g;
	  }		
	  if( regex.test(num) ){
	    num = num.replace(/,/g, "");
	    return isNaN(num) ? false : true;
	  }else{ return false;  }
	}
</script>

</head>

<body>

	<c:choose>

		<c:when test="${empty userInfo || (loginUserInfo.is_admin!='Y' && isMatchedPass!='Y')}">

			<script>
			alert("저장된값 없어요.");
			location.href='${pageContext.request.contextPath}/member/myinfo';
		</script>

		</c:when>

		<c:otherwise>

		</c:otherwise>
	</c:choose>

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
		<div class="row" id="row-body-my-profile">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<!-- 서브메뉴부분 -->
				<div class="col-xs-2" id="profile-menu">
					<h3>계정설정</h3>
					<a href="${pageContext.request.contextPath}/member/myinfo"><p>계정정보</p></a> <a href="#"><p>인증정보</p></a> <a href="#"><p>알림설정</p></a> <a href="${pageContext.request.contextPath}/member/change_password"><p>비밀번호 변경</p></a> <a href="${pageContext.request.contextPath}/member/withdraw"><p>회원탈퇴</p></a>
				</div>
				<!-- 기본정보부분 -->
				<input id="thumbnail_upload" name="profile_img_path" type="file" style="display: none;">
				
				<form class="form-horizontal" name="modifyFrm" method="post" action="${pageContext.request.contextPath}/member/myinfo" onsubmit="return checkForm(this);">
					<div class="col-xs-10" id="profile-info">
						<h4>기본정보</h4>
						<input type="hidden" name="action" value="complete">
						<table>
							<tr class="mini-title">
								<!-- 프로필이미지 -->
								<td rowspan="17" class="image-area" align="center">
									
									<c:choose>

										<c:when test="${ not empty modify_id}">

											<input type="hidden" name="modify_id" value="${modify_id}">

										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>

									<c:choose>

										<c:when test="${not empty loginUserInfo.profile_img_path}">

											<img src="${pageContext.request.contextPath}/upload/displayFile?fileName=${loginUserInfo.profile_img_path}&directory=member/${loginUserInfo.member_srl}/profile" id="profile_Img" class="profile-image" />

										</c:when>

										<c:otherwise>

											<img src="${pageContext.request.contextPath}/resources/images/main_user_gray.png" class="profile-image" id="profile_Img" />

										</c:otherwise>
									</c:choose>

									
									<div class="margin-top-20">
										<label id="profilePictureBtn" class="label-margin-none btn btn-default btn-sm width-100px border-888" for="thumbnail_upload"> 이미지 등록 </label>
									</div>
								</td>
								<td colspan="4">
									<span class="info-title">아이디</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" class="form-control" placeholder="${userInfo.user_id}" disabled="disabled" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">비밀번호찾기 질문/답변</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<select name="find_account_question" id="find_account_question" class="form-control" style="margin: 0px 0px 8px; display: block;">
										<option value="1">다른 이메일 주소는?</option>
										<option value="2">나의 보물 1호는?</option>
										<option value="3">나의 출신 초등학교는?</option>
										<option value="4">나의 출신 고향은?</option>
										<option value="5">나의 이상형은?</option>
										<option value="6">어머니 성함은?</option>
										<option value="7">아버지 성함은?</option>
										<option value="8">가장 좋아하는 색깔은?</option>
										<option value="9">가장 좋아하는 음식은?</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input class="form-control" name="find_account_answer" title="비밀번호 찾기 답변" id="find_account_answer" placeholder="비밀번호 찾기 답변" type="text" data-rule-required="true" value="${userInfo.find_account_answer}">
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="2">
									<span class="info-title">이름</span>
								</td>
								<td colspan="2" style="float: right;">
									<span class="info-title"> 성별 : <c:choose>
											<c:when test="${userInfo.gender == 'M' }">
												<label><input type="radio" name="gender" value="M" checked="checked" /> 남</label>
												<label><input type="radio" name="gender" value="W" /> 여</label>
											</c:when>
											<c:otherwise>
												<label><input type="radio" name="gender" value="M" /> 남</label>
												<label><input type="radio" name="gender" value="W" checked="checked" /> 여</label>
											</c:otherwise>
										</c:choose>
									</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input class="form-control" id="user_name" name="user_name" type="text" data-rule-required="true" value="${userInfo.user_name}" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">생년월일</span>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input class="form-control" name="birthday" type="date" step="1" value="${userInfo.birthday}" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">지역</span>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input class="form-control" type="text" name="address" size="20" value="${userInfo.address}" />
								</td>
								<td colspan="2">
									<input class="btnType1 form-control" type="button" style="margin-right: 10px" value="주소 검색" onclick="postOpen();" />
								</td>
							</tr>
							<tr class="mini-title">
								<td colspan="4">
									<span class="info-title">이메일</span>
								</td>
							</tr>
							<tr>

								<td colspan="2">
									<input type="text" class="form-control" id="email" placeholder="${userInfo.email_address}" disabled="disabled" />
								</td>
								<td colspan="2">
									<button type="button" class="form-control" onclick="openPopChangeEmail();">이메일 변경</button>
								</td>
							</tr>
							<tr>
								<td colspan="2">이메일수신동의 거부 시에도 기본서비스(주문배송 메일)는 발송됩니다.</td>
								<td colspan="2" style="float: right;">
									<c:choose>
										<c:when test="${userInfo.allow_mailing == 'Y' }">
											<label><input type="radio" name="allow_mailing" value="Y" checked="checked" /> 예 </label>&nbsp;&nbsp;
									<label><input type="radio" name="allow_mailing" value="N" /> 아니오</label>
										</c:when>
										<c:otherwise>
											<label><input type="radio" name="allow_mailing" value="Y" /> 예 </label>
											<label><input type="radio" name="allow_mailing" value="N" checked="checked" /> 아니오 </label>
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
									<input type="text" name="mobile" class="form-control" value="${userInfo.mobile}" maxlength="11">
								</td>
							</tr>
							<tr>
								<td colspan="2">메시지수신동의 시에 기본서비스(할인혜택과 이벤트 등의 소식 안내)를 받아보실수 있습니다.</td>
								<td colspan="2" style="float: right;">
									<c:choose>
										<c:when test="${userInfo.allow_message == 'Y' }">
											<label><input type="radio" name="allow_message" value="Y" checked="checked" /> 예</label>&nbsp;&nbsp;
									<label><input type="radio" name="allow_message" value="N" /> 아니오</label>
										</c:when>
										<c:otherwise>
											<label><input type="radio" name="allow_message" value="Y" /> 예</label>
											<label><input type="radio" name="allow_message" value="N" checked="checked" /> 아니오</label>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
					<!-- 버튼부분 -->
					<div class="myinfo-edit-btn">
						<button type="submit" class="btn btn-success">수정완료</button>
					</div>
				</form>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>
		<!-- Body영역 -->

		<!-- 테스트 후 문제 없을시 삭제요망 -->
		<%-- 기존에 세창이형이 작업한 코드 (문제없을시 삭제요망)
	<!-- HOME -->
	<section id="main" class="section">
		<!-- CONTAINER -->
		<div class="container">
			<!-- 좌우측의 공간 확보  -->
			<!--row 안에서 요소들 vertical middle => align-items-center -->
			<br /> <br />

			<div class="col-lg-offset-3 col-lg-6 text-center">

				<form class="form-horizontal" name="modifyFrm" method="post" action="" onsubmit="return checkForm(this);">
					<input type="hidden" name="action" value="complete">


					<div class="row">
						<h3 class="text-center">
							<b>내 정보를 <span class="text-primary">최신 정보로 관리</span>해 주세요.
							</b>
						</h3>
						<p class="text-center">아이디/비밀번호 분실 및 보호조치 해제를 위해 최신 정보로 내정보를 관리하세요.</p>
						<hr class="container col-lg-8 col-lg-offset-2" />

					</div>

					<div class="row ">
						<div class="col-lg-offset-2 col-lg-4 text-center">아이디</div>
						<div class="col-lg-4 text-left">${userInfo.user_id}</div>
					</div>

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-4 text-center">비밀번호 찾기 질문</div>
						<div class="col-lg-4 text-left">
							<select name="find_account_question" id="find_account_question" style="margin: 0px 0px 8px; display: block;">
								<option value="1">다른 이메일 주소는?</option>
								<option value="2">나의 보물 1호는?</option>
								<option value="3">나의 출신 초등학교는?</option>
								<option value="4">나의 출신 고향은?</option>
								<option value="5">나의 이상형은?</option>
								<option value="6">어머니 성함은?</option>
								<option value="7">아버지 성함은?</option>
								<option value="8">가장 좋아하는 색깔은?</option>
								<option value="9">가장 좋아하는 음식은?</option>
							</select>

						</div>

						<div class="col-lg-offset-2 col-lg-4 text-center">비밀번호 찾기 답변</div>
						<div class="col-lg-4 text-left">
							<input class="form-control" name="find_account_answer" title="비밀번호 찾기 답변" id="find_account_answer" placeholder="비밀번호 찾기 답변" type="text" data-rule-required="true" value="${userInfo.find_account_answer}">
						</div>
					</div>

					<div class="form-group" id="divUsername">
						<div class="col-lg-offset-2 col-lg-4 text-center">이름</div>
						<div class="col-lg-4 text-left">
							<input class="form-control" id="user_name" name="user_name" type="text" data-rule-required="true" value="${userInfo.user_name}" />
						</div>
					</div>

					<div class="row">
						<div class="col-lg-offset-2 col-lg-4 text-center">성별</div>
						<div class="col-lg-4 text-left">

							<c:choose>
								<c:when test="${userInfo.gender == 'M' }">
									<label><input type="radio" name="gender" value="M" checked="checked" /> 남성</label>
									<label><input type="radio" name="gender" value="W" /> 여성</label>

								</c:when>

								<c:otherwise>
									<label><input type="radio" name="gender" value="M" /> 남성</label>
									<label><input type="radio" name="gender" value="W" checked="checked" /> 여성</label>
								</c:otherwise>
							</c:choose>
						</div>
					</div>



					<div class="row">
						<div class="col-lg-offset-2 col-lg-4 text-center">생년월일</div>
						<div class="col-lg-4 text-left">

							<input class="text-center" name="birthday" type="date" step="1" value="${userInfo.birthday}" />

						</div>

					</div>

					<br />

					<div class="row">
						<div class="col-lg-offset-2 col-lg-4 text-center">주소</div>

						<div class="col-lg-2 ">
							<input type="text" name="address" size="20" value="${userInfo.address}" />
						</div>
						<div class="col-lg-2 ">
							<input class="btnType1" type="button" style="margin-right: 10px" value="주소 검색" onclick="postOpen();" />
						</div>

						<div class="col-lg-2 text-left">
							<input type="text" name="address" size="20" />
						</div>


					</div>

					<div class="row">
						<div class="col-lg-offset-2 col-lg-4 text-center">이메일</div>
						<div class="col-lg-4 text-left">
							<span class="text-left" id="email">${userInfo.email_address}</span>&nbsp;&nbsp;
							<button type="button" class="btn btn-info btn-xs" onclick="openPopChangeEmail();">변경</button>
						</div>
						<div class="col-lg-offset-2 col-lg-4 text-center">SMS 수신동의</div>
						<div class="col-lg-4 text-left">
							수신동의 거부 시에도 기본서비스(주문배송 메일)는 발송됩니다.

							<c:choose>
								<c:when test="${userInfo.allow_mailing == 'Y' }">
									<label><input type="radio" name="allow_mailing" value="Y" checked="checked" /> 예</label>
									<label><input type="radio" name="allow_mailing" value="N" /> 아니오</label>

								</c:when>

								<c:otherwise>
									<label><input type="radio" name="allow_mailing" value="Y" /> 예</label>
									<label><input type="radio" name="allow_mailing" value="N" checked="checked" /> 아니오</label>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-offset-2 col-lg-4 text-center">휴대전화</div>
						<div class="col-lg-4 text-left">
							<input type="text" name="mobile" value="${userInfo.mobile}" maxlength="11">
						</div>

						<div class="col-lg-offset-2 col-lg-4 text-center">SMS 수신동의</div>
						<div class="col-lg-4 text-left">
							할인혜택과 이벤트 등의 소식 안내를 SMS로 받으실 수 있습니다.<br /> 수신동의 거부 시에도 기본서비스는 발송됩니다.
							<c:choose>
								<c:when test="${userInfo.allow_message == 'Y' }">
									<label><input type="radio" name="allow_message" value="Y" checked="checked" /> 예</label>
									<label><input type="radio" name="allow_message" value="N" /> 아니오</label>

								</c:when>

								<c:otherwise>
									<label><input type="radio" name="allow_message" value="Y" /> 예</label>
									<label><input type="radio" name="allow_message" value="N" checked="checked" /> 아니오</label>
								</c:otherwise>
							</c:choose>

						</div>
					</div>

					<br />
					<div class="row text-center">
						<button type="submit" class="btn btn-info">수정</button>
					</div>
				</form>
			</div>
		</div>
		<!-- //CONTAINER -->
	</section>
	<!-- //HOME --> --%>
		<!-- 테스트 후 문제 없을시 삭제요망 -->

		<!-- 모달창 -->
		<%@ include file="/WEB-INF/views/common/modal_msg.jsp"%>
		<!-- //모달창 끝 -->

		<!-- Footer section(하단부분) -->
		<%@ include file="/WEB-INF/views/common/common_bottom.jsp"%>
		<!-- Footer section(하단부분) -->
	</div>
</body>
</html>
