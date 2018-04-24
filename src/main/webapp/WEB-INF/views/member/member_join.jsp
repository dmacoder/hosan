<%@page import="com.cafe24.hosan.member.domain.MemberVO"%>
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
<title>회원가입|OUR PLANNERS</title>
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


<script type="text/javascript">
	function logoutGo() {
		var ans = confirm("정말로 로그아웃 하시겠습니까?");
		if (ans == true) {
			location.href = "logout.jsp";
		} else {
			popLayerMsg("로그아웃을 취소하셨습니다.");
		}
	}

	function loginFrmCheck() {
		var f = document.loginFrm;
		if (f.user_id.value == "") {
			popLayerMsg("아이디를 입력하세요");
			f.user_id.focus();
			return false;
		}
		if (f.password.value == "") {
			popLayerMsg("패스워드를 입력하세요");
			f.password.focus();
			return false;
		}

	}
    $(document).ready(function () {
        var url = window.location;
        //alert(url);
        $('nav.navmenu ul li a[href="'+ url +'"]').parent().addClass('active');
        $('nav.navmenu ul li a').filter(function() {
             return this.href == url;
        }).parent().addClass('active');
    });

</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

/* 
 to do
 비밀번호 단순 생성 방지 체크 정규식 만들기(아이디 못들어가게, 연속된 숫자입력X, 대문자나 특수문자 포함하게..)
 비밀번호 RSA 암호화해서 DB저장 (로그인 페이지도 연동해서)
 
*/
	function postOpen() {
		new daum.Postcode({
			oncomplete : function(data) {
				var f = document.registFrm;
				/*
				f.zipcode.value = data.zonecode;
				f.address1.value = data.address;
				f.sido.value = data.sido;
				f.gugun.value = data.sigungu;
				f.address2.focus();
				
				*/
				f.address.value = data.sido +" "+data.sigungu;
			}
		}).open();
	}


	function registFrmCheck() {
		var f = document.registFrm;
		if (f.user_id.value == "") {
			popLayerMsg("아이디를 입력하세요");
			f.id.focus();
			return false;
		}
		if (f.DuplicationCheckId.value == "N") {
			popLayerMsg("아이디 중복 체크를 하세요.");
			return false;
		}
		
		if (f.DuplicationCheckEmail.value == "N") {
			popLayerMsg("이메일 중복 체크를 하세요.");
			return false;
		}
		

		if (!f.password.value) {
			popLayerMsg("비밀번호를 입력하세요");
			f.password.focus();
			return false;
		}
		if (!f.user_pw2.value) {
			popLayerMsg("비밀번호 확인을 입력하세요");
			f.user_pw2.focus();
			return false;
		}

		//패스워드가 동일한지 검증
		if (f.password.value != f.user_pw2.value) {
			popLayerMsg("입력한 비밀번호가 일치하지 않습니다.");
			f.password.value = "";
			f.user_pw2.value = "";
			f.password.focus();
			return false;
		}

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
		
		if (!checkBirthday()) {
			return false;
		}

		if ((!f.email_id.value) || (!f.email_host.value)) {
			popLayerMsg("이메일 주소를 입력하세요");
			f.email_id.focus();

		}

		if (!checkEmail()) {
			return false;
		}


		if ((!f.mno1.value) || (!f.mno2.value) || (!f.mno3.value)) {
			popLayerMsg("휴대폰 번호를 입력하세요");
			f.mno1.focus();
			return false;
		}

		mergeMobNo();

		if ((f.pno1.value) && (f.pno2.value) && (f.pno3.value)) {

		}

		mergePhoneNo();
		
		return true;
	}



	function selectEmail(obj) {
		var f = document.registFrm;

		if (obj.value == "") {
			f.email_host.value = "";
			f.email_host.focus();
		} else {
			f.email_host.value = obj.value;
		}

	}
	var IDCheckPopObj;

	function checkName() {
		var f = document.registFrm;
		var namePattern = /[^가-힣a-zA-Z0-9]/gi;
		if (namePattern.test(f.user_name.value)) {
			popLayerMsg("한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
			return false;
		}
		return true;
	}

	function mergeMobNo() {
		var f = document.registFrm;
		var mobile = f.mno1.value.concat(f.mno2.value).concat(f.mno3.value);
		f.mobile.value = mobile.split("-").join("");
	}

	function mergePhoneNo() {
		var f = document.registFrm;
		var phoneno = f.pno1.value.concat(f.pno2.value).concat(f.pno3.value);
		f.phoneno.value = phoneno.split("-").join("");
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
		var f = document.registFrm;

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
		var f = document.registFrm;

		var email_id = f.email_id.value;
		var email_host = f.email_host.value;

		var email_address = email_id.concat("@").concat(email_host);

		//이메일 유효성 검사
		var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		
		//한글 들어가 있는지 확인
		var isHan = /[ㄱ-ㅎ가-힣]/g;
		if (!isEmail.test(email_address) || isHan.test(email_address)) {
			popLayerMsg("이메일 주소 형식이 맞지 않습니다. 이메일을 다시 확인해주세요.");
			return false;
		}
		f.email_address.value = email_address;
		return true;
	}
	
	function checkEmailDuplication(){
		var f = document.registFrm;
		if(!checkEmail())
		{
			
			
				$('#emailCheckSpan').removeClass();
				$("#emailCheckSpan").addClass("alert-danger");
				document.getElementById("emailCheckSpan").innerText = "이메일 주소 형식이 맞지 않습니다. 이메일을 다시 확인해주세요.";
				document.registFrm.DuplicationCheckEmail.value="N";
				return;
		}	
			
			//var url = '/json/id_check.json?user_id=' + uid.value;
	    	var email_address = f.email_address.value;
	     $.ajax({
	      url:'${pageContext.request.contextPath}/member/json/email_check.json',  //url에 주소 넣기
		  contentType : "text/html; charset=utf-8;",	  
	      data : {email_address : email_address},			  
	      dataType:'json',      //dataType에 데이터 타입 넣기
	      
	      success:function(data){     //success에 성공했을 때 동작 넣기.
	       
	       //중복되지 않은 경우 hasId=> N
	       if(data.result == "N"){
	        idCheck = true; 
	        $('#emailCheckSpan').removeClass();
			$("#emailCheckSpan").addClass("alert-success");
	        document.getElementById("emailCheckSpan").innerText = "사용 가능한 이메일입니다.";
	        document.registFrm.DuplicationCheckEmail.value="Y";
	       }
	       //중복된 경우 hasId =>Y
	       else{
	    	   
	        idCheck = false;
	        $('#emailCheckSpan').removeClass();
			$("#emailCheckSpan").addClass("alert-danger");
	        document.getElementById("emailCheckSpan").innerText = "이미 사용중인 이메일 입니다.";
	        document.registFrm.DuplicationCheckEmail.value="N";
	       }
	       
	      },
	      error: function (e) {
	    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
	    	  
	      }
	      
	     });
	    
	    }
			
		
	
	

	function checkID() {
		var f = document.registFrm;

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
		sOption = sOption + "toolbar=no, channelmode=no, location=no, directories=no, resizable=no, menubar=no";
		sOption = sOption + ", scrollbars=" + sScroll + ", left=" + x + ", top=" + y + ", width=" + w + ", height=" + h;

		var win = window.open(sURL, sWindowName, sOption);
		return win;
	}


	function resetDuplicationCheckId() {
		var fn = document.registFrm;
		fn.DuplicationCheckId.value = "N";
		$('#idCheckSpan').removeClass();
        document.getElementById("idCheckSpan").innerText = "";
		
	}

	
	
	function agreeCheck(f){
		if (!f.provisionYn.checked )
		{
			
			var msg = "회원가입약관에 동의 하셔야 합니다.";
			popLayerMsg(msg);
			return false;
		}
		if(!f.memberInfoYn.checked)
		{
			var msg = "개인정보취급방침에 동의 하셔야 합니다.";
			popLayerMsg(msg);
			return false;
		}
		return true;
		 
	}
	
	 window.onload = function(){
		  
		  
		  var uid = document.getElementById("user_id");
		  
		  var isValidID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
		  
		  if(uid != null)
		{
			  
		  uid.onblur = function(){
		    //uid에 입력된 값이 있으면
		    if(uid.value != null && uid.value.length > 0)
		    {
		    	
		    	
				if (!isValidID.test(uid.value)) {
					$('#idCheckSpan').removeClass();
					$("#idCheckSpan").addClass("alert-danger");
					document.getElementById("idCheckSpan").innerText = "아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
					document.registFrm.DuplicationCheckId.value="N";
					return;
				}
				
				//var url = '/json/id_check.json?user_id=' + uid.value;
		    	
		     $.ajax({
		      url:'${pageContext.request.contextPath}/member/json/id_check.json',  //url에 주소 넣기
			  contentType : "text/html; charset=utf-8;",	  
		      data : {user_id : uid.value},			  
		      dataType:'json',      //dataType에 데이터 타입 넣기
		      
		      success:function(data){     //success에 성공했을 때 동작 넣기.
		       
		       //중복되지 않은 경우 hasId=> N
		       if(data.result == "N"){
		        idCheck = true; 
		        $('#idCheckSpan').removeClass();
				$("#idCheckSpan").addClass("alert-success");
		        document.getElementById("idCheckSpan").innerText = "좋은 아이디네요!";
		        document.registFrm.DuplicationCheckId.value="Y";
		       }
		       //중복된 경우 hasId =>Y
		       else{
		        idCheck = false;
		        $('#idCheckSpan').removeClass();
				$("#idCheckSpan").addClass("alert-danger");
		        document.getElementById("idCheckSpan").innerText = "이미 사용중이거나 탈퇴한 아이디입니다.";
		        document.registFrm.DuplicationCheckId.value="N";
		       }
		       
		      },
		      error: function (e) {
		    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
		    	  
		      }
		      
		     });
		    
		    }
		  }
	 }
	 
	 }
</script>

<!-- 회원가입부분 CSS -->
<style type="text/css">

body{
	background-color: #FAFAFA;
}

.padbot0{
	margin-top: 60px;
	margin-bottom: 100px;
}
.title-image{
	padding-right: 30px;
}
.join-one-btn{
	background-color: #27CEA7;
	border: 0px solid;
	height: 50px;
	width: 150px;
	font-size: 1.1em;
	font-weight:bold;
	margin-top: 30px;
}

.member_choose{
	border: 1px solid #CFCFCF;
	border-radius: 5px;
	
}

.form-up{
	height: 40px;
	border: 1px solid #CFCFCF;
	background-color: white;
	margin-top: 2px;
}

.man-woman{
	height: 40px;
	border: 1px solid #CFCFCF;
	padding: 5px;
	width: 100%;
	margin-left: 0px;
	text-align: center;
	background-color: white;
}

#woman{
	margin-left: 130px;
}

#address-btn{
	margin-right: 13px;
	height: 40px;
	border: 0px solid;
	margin-top: 2px;
	padding-top: 0px;
	font-weight: bold;
	width: 100%;
	
}

#address-left{
	display: inline;
	float: left;
	width: 470px;
}

#address-right{
	display: inline;
	float: right;
}

#address-left>.form-up{
	width: 100%;
}

#email_id{
	display: inline-block;
	float: left;
}

#email_host{
	display: inline-block;
	
}

#email_type{
	display: inline;
	float: right;
}

#email-select{
	height: 40px;
	border: 1px solid #CFCFCF;
	background-color: white;
	width: 30%;
	float: right;
}

.joinhelp{
	float:right;
	font-size: 0.9em;
}

#joinhelp{
	margin-top: 20px;
}

#joinhelp2{
	margin-top: 20px;
}

#call_one{
	display: inline-block;
	float: left;
}

#call_two{
	display: inline-block;
}

.presonal-company{
	height: 55px;
	border: 1px solid #CFCFCF;
	padding: 5px;
	padding-top: 15px;
	width: 100%;
	margin-left: 0px;
	text-align: center;
	background-color: white;
}

#companyRadioBtn{
	margin-left: 130px;
}

.company-input{
	margin-bottom: 8px;
}

</style>
</head>
<body>
	<!-- PRELOADER -->
	<img id="preloader" src="${pageContext.request.contextPath}/resources/images/preloader.gif" alt="" />
	<!-- //PRELOADER -->
		<div class="preloader_hide">

			<!-- 탑부분(기본적인 틀) -->
			<nav class="navber navbar-fixed-top" id="navbar-fixed-top">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-2 col-sm-1 col-xs-0"></div>
						<div class="col-lg-8 col-sm-10 col-xs-12">
							<div class="navbar-header">
								<a class="navbar-brand" id="navbar-brand"
									href="${pageContext.request.contextPath}"><b>♣</b>
									OurPlanners</a>
							</div>
						</div>
						<div class="col-lg-2 col-sm-1 col-xs-0"></div>
					</div>
				</div>
			</nav>
			
			<!-- 모달창 메시지 -->
			<%@ include file="../common/modal_msg.jsp"%>
			<!--// 모달창 메시지 -->
			
			<!-- HOME -->
			<section id="home" class="padbot0">
				<!-- CONTAINER -->
				<div class="container">
					<br /> <br />
					<!-- 첫번째페이지(좌우측의 공간 확보) -->
					<%
						String action = ((String) request.getAttribute("action"));
						System.out.println("현재 join.jsp로 들어온 액션 : " + action);
						if ((action == null) || (action.equalsIgnoreCase("term"))) {
					%>

					<div class="container text-center title-image">
						<span class="glyphicon glyphicon-check"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>
					</div>
					<br/><br/>

					<div class="text-center">
						<h3>회원가입 약관 동의</h3>
					</div>

					<form class="form-horizontal" name="step1Frm" method="post" action="${pageContext.request.contextPath}/member/join" onsubmit="return agreeCheck(this);">
						<input type="hidden" id="action" name="action" value="signup">
						<div class="form-group">
							<div class="col-lg-12" id="provision">
							<label for="provision" class="control-label">회원가입약관</label>
							<textarea class="form-control" rows="8" style="resize: none;">
								
[코스모31기 사이트 이용 약관]
[제 1장 총칙]
제 1조 목적
이 약관은 KOSMO (이하 회사)가 제공하는 모든 서비스의 이용 조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.


제 2조 효력과 변경
(1) 이 약관은 이용자에게 서비스 화면을 통해 공지하거나 기타의 방법으로 회원에게 공지함으로써 효력을 발생합니다.
(2) 회사는 영업상 필요 또는 기타 사정 변경이 있을 때 약관을 변경할 수 있으며, 변경 일주일 이전에 그 내용을 서비스 제공자의 웹사이트의 "서비스"관련 페이지에 공지합니다. 이용자는 변경된 약관에 동의하지 않을 권리가 있으며, 변경된 약관에 동의하지 않을 경우 서비스 이용이 중단될 수 있습니다. 다만, 이용자가 위 기간 동안 서비스 제공자에 대하여 거부의 의사표시를 하지 않는 경우 이용자는 변경된 약관에 동의한 것으로 간주됩니다.
(3) 새로운 서비스가 개설될 경우 별도의 명시된 설명이 없는 한, 이 약관에 따라 제공합니다.
제 3조 약관 이외의 준칙
이 약관에 명시되지 않은 사항이 관계 법령에 규정되어 있을 경우에는 그 규정에 따릅니다.

[제 2장 회원 가입과 서비스 이용]
제 4조 정의
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.

(1) 회원 : 회사와 서비스 이용계약을 체결한 개인이나 법인 또는 법인에 준하는 단체
가. 유료회원 : 회사가 인정하는 제품 및 서비스를 구입한 고객이 온라인으로 고객등록을 신청하고 이에 대하여 회사가 등록 작업을 함으로써 자격 취득
나. 무료회원 : 이용자의 이용 신청 및 약관 내용에 대한 동의와 이에 대한 회사의 이용 승낙으로 자격 취득
(2) 상품/서비스 이용 : 사이트에 로그인하여 이 약관에 따라 상품/서비스를 제공 받거나 제품 및 서비스를 구매하여 사용함
(3) 운영자/관리자 : 서비스의 전반적인 관리와 원활한 운영을 위하여 회사가 선정한 사람
(4) 아이디(ID): 회원식별을 위하여 회원이 선정하고 회사가 승인하는 문자, 숫자, 특수문자의 조합
(5) 비밀번호 : 회원의 비밀 보호를 위해 회원 자신이 설정한 문자와 숫자의 조합
(6) 서비스 일시 정지 : 정상이용 중 회사가 정한 일정한 요건에 따라 일정 기간 동안 서비스의 제공을 중지하는 것
(7) 해지 : 회사 또는 회원이 서비스 개통 후 이용 계약을 해약하는 것
제 5조 서비스 회원 가입의 성립
(1) 회원은 유료회원과 무료회원으로 나누어 등록, 관리합니다.
(2) 고객 및 이용자의 회원 가입 신청에 대하여 회사가 이를 승낙한 경우, 회사는 회원 ID와 기타 회사가 필요하다고 인정하는 내용을 이용자에게 통지합니다.
(3) 회사는 다음 각 호에 해당하는 회원 가입 신청에 대하여는 이를 승낙하지 아니 합니다.
가. 다른 사람의 명의를 사용하여 신청하였을 때
나. 본인의 실명으로 신청하지 않았을 때
다. 회원 가입 신청 시 이용자 정보를 허위로 기재하였을 때
라. 사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때
마. 기타 회사가 정한 이용신청요건이 미비할 때
제 6조 서비스의 구분
(1) 회사가 회원에게 제공하는 서비스는 무료서비스와 유료서비스 등으로 구분합니다.
(2) 서비스의 종류와 내용 등은 회사가 공지나 서비스 이용 안내에서 별도로 정하는 바에 의합니다.
제 7조 서비스 이용 및 제한
(1) 회사가 제공하는 서비스는 회원의 자격에 따라 차등 제공되며, 무료회원도 유료회원의 자격을 취득하면 유료회원으로서 모든 서비스를 제공받을 수 있습니다.
(2) 서비스 이용 시간은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.
(3) 전항의 서비스 이용시간은 시스템 정기점검 등 회사가 필요에 의하여 정한 날 또는 시간의 경우 회원에게 사전 통지한 후, 제한할 수 있습니다.
제 8조 이용자 정보의 변경
회원은 회원 가입 신청시 기재한 정보가 변경되었을 경우에는, 즉시 온라인으로 수정을 하여야 하며 이용 신청시 기재한 사항 중 변경 사항을 수정하지 않아 발생되는 문제의 책임은 회원에게 있습니다.

[제 3장 의무]
제 9조 회사의 의무
(1) 회사는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시일에 서비스를 이용할 수 있도록 합니다.
(2) 회사는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.
(3) 회사는 회원으로부터 제기되는 의견에 대해서는 적절한 절차를 거처 처리하며, 일정 기간 내에 처리가 불가한 경우 회원에게 그 사유와 처리 일정을 알려주어야 합니다.
(4) 회사는 회원의 정보에 대하여 철저한 보안을 유지하며, 양질의 서비스를 운영하거나 개선하기 위한 목적으로만 사용하고, 이외의 다른 목적으로 타 기관 및 개인에게 양도하지 않습니다.
제 10조 회원의 의무
(1) 가입신청 양식에는 실명을 사용해야 합니다.
(2) 다른 사람의 명의를 사용하여 기재하지 않아야 합니다.
(3) 가입신청 양식의 내용은 현재의 사실과 일치해야 합니다.
(4) ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있습니다.
(5) 자신의 ID가 부정하게 사용된 경우, 회원은 반드시 회사에 그 사실을 통보해야 합니다.
(6) 다른 회원의 ID를 부정하게 사용하지 않아야 합니다.
(7) 서비스에서 얻은 정보를 회사의 사전승낙 없이 복제 및 변경하여 출판 및 방송 등에 사용하거나 타인에게 제공하는 행위를 하지 않아야 합니다.
(8) 회사의 저작권, 제 3자의 저작권 등 기타 권리를 침해하는 행위를 하지 않아야 합니다.
(9) 회원은 회사의 사전 승낙 없이 서비스를 이용한 영업행위를 할 수 없으며, 이에 따른 결과로 인하여 발생한 결과에 대해서는 회사가 책임지지 않습니다.
(10) 만 14세 미만의 어린이는 부모 등 법정 대리인의 동의를 얻은 후에 서비스 이용을 신청하여야 합니다. 또한 만 20세 미만의 이용자가 유료 서비스를 이용하고자 하는 경우에도 이와 같습니다.
(11)회사가 정한 정보 이외의 정보 등의 송신 또는 게시 행위를 하지 않아야 합니다.
(12) 회원은 이 약관 및 관계 법령에서 규정한 사항을 준수하여야 합니다.
제 11조 양도 금지
회원은 서비스의 이용권한, 기타 이용계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.

[제 4장 계약 해지 및 서비스 이용 제한]
제 12조 계약 해지 및 이용 제한
(1) 이용계약의 해지는 무료회원의 경우에는 언제나 가능하며, 제품고객으로 등록된 유료회원의 경우에는 자동 해지 처리 시 등록된 제품정보까지 삭제되어 제품 이용 관련 고객지원 서비스 제공에 문제가 발생할 수 있습니다. 따라서 자동 해지 처리가 불가하며 회사의 고객지원센터를 통해 관련 해지 절차를 안내 받아 개별적으로 처리할 수 있습니다. 단, 이럴 경우 유료서비스 고객에게만 제공되는 인터넷상의 다양한 유료 서비스를 이용하실 수 없게 됩니다.
(2) 무료회원이 서비스 이용계약을 해지하고자 하는 때에는 회원 본인이 직접 인터넷의 해지서비스를 이용하여 서비스 해지 신청을 해야 하며 비밀번호를 입력하여 본인임을 확인한 후, 해지 확인을 선택하면 자동으로 가입 해지됩니다. 단, 유료회원의 경우에는 고객만족센터를 통한 해지 신청시에만 처리 가능합니다.
(3) 유료서비스 신청 후, 서비스 해지 신청에 따른 서비스 환불 정책은 각 유료서비스 별 개별 약관에 따릅니다. 각 서비스 별 개별 약관은 이용하시는 서비스의 신청 시 확인이 가능합니다.
(4) 가입 해지 여부는 기존의 ID, 비밀번호로 로그인이 되지 않으면 해지된 것입니다.
(5) 회사는 2015년 8월 18일부로 회원의 개인정보 보호를 위하여 서비스 미사용자(최종 로그인한 후 연속하여 1년이상 로그인 기록이 없는 회원)에 대해 정기적으로 회원자격 상실에 대한 안내문(전자우편)을 통지하고, 안내문에서 정한 기한 내에 로그인이 없을 경우 다른 고객의 개인정보와 분리, 보관하여 서비스 이용을 제한합니다. 휴면계정 전환 이후 고객은 별도의 인증절차를 통해 휴면을 해제할 수 있습니다.

(6) 회사는 회원이 다음 사항에 해당하는 행위를 하였을 경우, 사전 통지 없이 이용 계약을 해지하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.
가. 공공 질서 및 미풍 양속에 반하는 경우
나. 범죄적 행위에 관련되는 경우
다. 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우
라. 타인의 ID 및 비밀번호를 도용한 경우
마. 타인의 명예를 손상시키거나 불이익을 주는 경우
바. 같은 사용자가 다른 ID로 이중 등록을 한 경우
사. 서비스에 위해를 가하는 등 건전한 이용을 저해하는 경우
아. 회사, 다른 회원 또는 제 3자의 지적재산권을 침해하는 경우
자. 회사의 서비스 정보를 이용하여 얻은 정보를 회사의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우
차. 기타 관련 법령이나 회사가 정한 이용조건에 위배되는 경우
제 13조 서비스 제한 및 해제 절차
(1) 회사가 서비스 이용을 제한하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 그 외의 방법을 이용하여 회원 또는 대리인에게 통지합니다.
(2) 회사는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우 및 기타 불가항력적 사유가 있는 경우에는 전항의 과정 없이 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.
(3) (1)항의 규정에 의하여 서비스 이용중지를 통지 받은 회원 또는 그 대리인은 이용 중지에 대하여 이의가 있을 경우 이의신청을 할 수 있습니다.
(4) 회사는 이용 중지 기간 중에 그 이용 중지 사유가 해소된 것이 확인된 경우에 한하여 이용 중지 조치를 즉시 해제합니다.

제 14조 청약철회 (환불규정)

상품/서비스 특성상 모든 상품/서비스 환불 불가능하니 반드시 무료체험해보시고 정상작동 되는지 확인후에 결재 부탁드립니다.

프로그램이 막히거나 오작동하는 경우 최선을 다해 사용할 수 있도록 도와드리지만 불가항력의 각종 문제로 인해 업데이트가 지연될 경우 사용기간을 연장해드립니다. 결재를 완료함과 동시에 판매자가 정해 놓은 환불규정 관한 공지에 동의하는 것으로 간주하오니 신중한 구매 부탁드립니다.

제 15조 손해배상
(1) 회사가 제공하는 서비스와 관련하여 서비스 요금이 무료인 동안의 서비스 이용과 관련하여 회원에게 발생한 어떠한 손해에 관하여도 책임을 지지 않으며, 그 외의 경우에도 회사의 중대한 과실에 의한 경우를 제외하고 이에 대하여 책임을 부담하지 않습니다.
(2) 회사는 제 2장, 제 4조 3항에 따라 유료회원 대상의 서비스에 대하여 사전 공지를 한 경우의 서비스 중지에 관하여도 책임을 지지 않습니다.
(3) 회사는 회사의 귀책 사유로 유료 서비스 이용자가 해당 유료 서비스를 이용하지 못하는 경우에는 이용자가 그 사실을 회사에 통보한 시점 또는 회사가 그 사실을 알았거나 알 수 있었을 시점으로부터 4시간 이상 연속적으로 그 상태가 계속될 때에는 회원의 청구에 대하여 손해배상책임이 있습니다.
(4) 손해배상은 아래 기준으로 유료서비스 만료일을 연장해 드립니다.
4시간~8시간 연속 서비스 사용 불가 → 1일 연장
9시간~16시간 연속 서비스 사용 불가 → 2일 연장
17시간~24시간 연속 서비스 사용 불가 → 3일 연장
(5) 회원이 이 약관의 규정을 위반함으로 인하여 회사나 회원 또는 제 3자에 대하여 책임을 부담하게 되고, 이로써 회사에게 손해가 발생하는 경우, 이 약관을 위반한 회원은 회사에게 발생하는 모든 손해를 배상하여야 합니다.
제 16조 손해배상의 청구
(1) 손해배상의 청구는 회사에 청구사유, 청구금액 및 산출근거를 기재하여 서면으로 하여야 합니다.
(2) 제 (1)항의 손해배상 청구는 그 청구사유를 안 날로부터 3개월 내에 행사하지 아니하면 그 청구권은 소멸합니다. 청구사유가 발생한 날로부터 1년이 경과한 때에도 이와 같습니다.
제 17조 면책조항
(1) 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
(2) 회사는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.
(3) 회사는 회원이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않습니다. 또한 회사는 서비스를 통하여 제공하는 자료의 정확성을 보장하지 아니하며 이로 인한 손해에 관하여 책임을 지지 않습니다.
(4) 회사는 고의에 의한 경우를 제외하고 회사가 제공하는 자료, 사실 기타 모든 정보의 신뢰도, 정확성에 대하여 책임을 지지 않습니다.
제 18조 관할법원
서비스 이용에 관하여 발생한 분쟁에 대해 소송이 제기될 경우 회사의 본사 소재지를 관할하는 법원을 관할법원으로 합니다.
                    </textarea>
                    <label> <input type="checkbox" name="provisionYn" value="Y" autofocus="autofocus"> 동의합니다.</label>
					</div>
					</div>


					<div class="form-group">
					<div class="col-lg-12" id="memberInfo">
					<label for="memberInfo" class="control-label">개인정보취급방침</label>
					<textarea class="form-control" rows="8" style="resize: none">
[개인정보수집 및 이용 약관]

[수집하는 개인정보의 항목]
회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.

[개인, 14세 미만, 외국인 회원]
- 필수항목 : 아이디, 비밀번호, 이메일, 비밀번호 힌트, 휴대폰 번호, 14세 미만인 경우 법정대리인 정보
- 선택항목 : 생년월일, 추천인
[기업회원]
- 필수항목 : 이름, 아이디, 비밀번호, 이메일, 비밀번호 힌트, 휴대폰 번호, 부서
- 선택항목 : 생년월일, 추천인
[해외교포회원]
- 필수항목 : 이름, 아이디, 비밀번호, 이메일, 비밀번호 힌트, 휴대폰 번호
[제품 구매 및 유료 서비스 이용 시]
- 결제 및 위해 결제 기록과  기타 연락처 등을 저장할 수 있습니다.
[자동 수집 항목]
- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록 , 분쟁조정을 위한 기록


[개인정보의 수집 및 이용목적]
[서비스 제공에 관한 계약 이행 및 요금정산]
- 공지사항 전달, 콘텐츠 제공, 불만 처리 등 의사소통 경로 확보, 구매 및 요금 결제, 물품배송 또는 청구지 등 발송, 금융거래 본인 인증 및 금융 서비스
[회원관리]
- 회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 연령확인, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 민원처리, 바이러스 신고, 고지사항 전달
[마케팅 및 광고에 활용]
- 신규 제품 · 서비스 개발 및 특화, 세미나 및 이벤트 안내, 개인 맞춤 서비스를 위한 자료

[개인정보의 보유 및 이용기간]
회사는 원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.

- 계약 또는 청약철회 등에 관한 기록: 5년
- 대금결제 및 재화 등의 공급에 관한 기록: 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
- 통신비밀보호법에 따른 통신사실확인자료에 관한 기록 : 3개월
- 보유기간을 이용자에게 미리 고지하거나 개별적으로 이용자의 동의를 받은 경우: 고지하거나 개별 동의한 기간

 


(부칙) 이 약관은 2018년 1월 1일부터 시행합니다.


(부칙)
1. 본 약관은 2018년 1월 1일부터 시행됩니다. 2. 2017년 12월 01일부터 시행되었던 종전의 약관은 본 약관으로 대체합니다.
----------------------------------------------------------------------------------------------------------------------------------------------------
                    </textarea>
					<label><input type="checkbox" name="memberInfoYn" value="Y"> 동의합니다.</label>
						</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<button type="submit" class="btn btn-success join-one-btn">다음</button>
							</div>
						</div>
					</form>


					<%
						} else if (action != null && action.equalsIgnoreCase("signup")) {
					%>
					
					
					<!-- 두번째 페이지 -->
					<div class="container text-center title-image">
						<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-check"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>
					</div>
					<br/><br/>
					<div class="text-center">
						<h3>
							계정 정보 입력
						</h3>
					</div>
					<form class="form-horizontal" name="registFrm" method="post" action="${pageContext.request.contextPath}/member/join" onsubmit="return registFrmCheck();">
						<input type="hidden" id="action" name="action" value="authmail">
						
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 회원구분</label>
									<div class="row presonal-company">
										<label for="personal">
										<input type="radio" name="member_type" id="personalRadioBtn" value="P" checked="checked" />개인</label>
										<label for="company">
										<input type="radio" name="member_type" id="companyRadioBtn" value="C" />기업</label>
									</div>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
						
						<div class="row hidden" id="companyDiv">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<input class="form-control form-up company-input" name="company_number" type="text" placeholder="사업자등록번호를 입력해주세요"/>
									<input class="form-control form-up company-input" name="company_name" type="text" placeholder="사업자등록번호의 회사명을 입력해주세요"/>
									<!-- <input class="form-control form-up company-input" name="" type="text" placeholder="사업자등록번호의 대표자명을 입력해주세요"/> -->
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
				
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 아이디</label>
									<input class="form-control form-up" id="user_id" name="user_id" type="text" placeholder="5~20자의 영문소문자,숫자,특수기호(_),(-)을 사용해주세요" onkeydown="resetDuplicationCheckId()" /> <strong id="idCheckSpan" class="joinhelpred"></strong> <input type="hidden" name="DuplicationCheckId" value="N">
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 비밀번호</label>
									<input class="form-control form-up" name="password" type="password" placeholder="8~20자리의 영문,숫자 조합권장합니다 (영문,숫자,특수기호 조합)" /> <span class="joinhelp"></span>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
						
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 비밀번호 확인</label>
									<input class="form-control form-up" name="user_pw2" type="password" placeholder="비밀번호를 한번 더 작성해주세요"/>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label" for="find_account_question"><em style="color: red;">*</em> 비밀번호 찾기 질문/답변</label>
									<select class="form-control form-up" name="find_account_question" id="find_account_question" style="margin: 0px 0px 8px; display: block;">
										<option value="1">나의 보물 1호는?</option>
										<option value="2">다른 이메일 주소는?</option>
										<option value="3">나의 출신 초등학교는?</option>
										<option value="4">나의 출신 고향은?</option>
										<option value="5">나의 이상형은?</option>
										<option value="6">어머니 성함은?</option>
										<option value="7">아버지 성함은?</option>
										<option value="8">가장 좋아하는 색깔은?</option>
										<option value="9">가장 좋아하는 음식은?</option>
									</select>
									<input class="form-control form-up" name="find_account_answer" title="비밀번호 찾기 답변" 
									id="find_account_answer" type="text" value="" placeholder="비밀번호찾기 질문의 답변을 작성해주세요">
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
						
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 이름</label>
									<input class="form-control form-up" name="user_name" type="text" placeholder="이름을 작성해주세요"/>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
						
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 성별</label>
									<div class="row man-woman">
										<label for="man">
										<input type="radio" name="gender" id="man" value="M" checked="checked"/>남성</label>
										<label for="woman">
										<input type="radio" name="gender" id="woman" value="W"/>여성</label>
									</div>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 생년월일</label>
									<input class="form-control form-up" name="birthday" type="date" step="1" /> 
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<input name="email_address" type="hidden" />
									<label class="control-label"><em style="color: red;">* </em>이메일</label>
									
									<div class="form-inline">
										<div id="email_id">
											<input class="form-control form-up" name="email_id" type="text" /> @ 
										</div>
										<div class="form-inline" id="email_host ">
											&nbsp;<input class="form-control form-up" name="email_host" type="text" />
											<select name="email_type" size="1" id="email-select"
												class="form-control form-up" onchange="selectEmail(this);">
												<option value="" selected="selected">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.com">yahoo.com</option>
											</select>
										</div>
										<input type="hidden" name="DuplicationCheckEmail" value="Y"/>
										
										<button type="button" class="btn" id="emailCheckBtn" onclick="checkEmailDuplication();">중복체크</button>
										<strong id="emailCheckSpan" class="joinhelpred"></strong>
									</div>	
									<div class="joinhelp" id="joinhelp">이메일 수신동의 시, 신상품/할인혜택/이벤트 등의 정보를 받아보실
										수 있습니다
									</div>
									<div class="joinhelp">
										수신동의 거부 시에도 기본서비스는 발송됩니다. &nbsp;&nbsp;&nbsp;<label><input
											type="radio" name="allow_mailing" value="Y" checked="checked" />
											예</label> <label><input type="radio" name="allow_mailing"
											value="N" /> 아니오</label>
									</div>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>


						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<input name="mobile" type="hidden" />
									<label class="control-label"><em style="color: red;">* </em>휴대전화</label>
									<div class="form-inline">
										<div id="call_one">
											<input class="form-control form-up" name="mno1" type="text" size="3" maxlength="3" style="width: 120px"/> -&nbsp;
										</div>
										<div class="form-inline" id="call_two ">
											<input class="form-control form-up" name="mno2" type="text" size="4" maxlength="4" style="width: 140px;"/> - 
											<input class="form-control form-up" name="mno3" type="text" size="4" maxlength="4" style="width: 140px;"/>
										</div>
									</div>
									<div class="joinhelp" id="joinhelp2">할인혜택과 이벤트 등의 소식 안내를 SMS로 받으실 수 있습니다.</div>
									<div class="joinhelp">
										수신동의 거부 시에도 기본서비스는 발송됩니다. &nbsp;&nbsp;&nbsp;<label><input type="radio"
											name="allow_message" value="Y" checked="checked" /> 예</label> <label><input
											type="radio" name="allow_message" value="N" /> 아니오</label>
									</div>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
						
						<div class="row">
							<div class="form-group">
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
								<div class="col-md-6 col-sm-8 col-xs-10">
									<label class="control-label"><em style="color: red;">*</em> 주소</label>
									<div class="form-inline">
										<div id="address-left">
											<input class="form-control form-up" type="text" name="address" size="20"/>
										</div>
										<div id="address-right">
											<button type="button" class="btn" id="address-btn" onclick="postOpen();">주소 검색</button>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-2 col-xs-1"></div>
							</div>
						</div>
				
						<div class="row">
							<div class="form-group">
								<div class="text-center">
									<button type="submit" class="btn btn-success join-one-btn" style="margin-top: 70px;">다음</button>
								</div>
							</div>
						</div>
					</form>
					<script type="text/javascript">
					$(document).ready(function() {
					    setMemberTypeListener(); 
					});
					
					function setMemberTypeListener() {

						var companyDiv = $('#companyDiv');

						$('#personalRadioBtn').click(function() {
						    companyDiv.addClass('hidden');
						});

						$('#companyRadioBtn').click(function() {
						    companyDiv.removeClass('hidden');
						})
					}
					
					</script>
					<%
						} else if (action != null && action.equalsIgnoreCase("authmail")) {

							MemberVO memInfo = (MemberVO) request.getAttribute("joinInfo");

							session.setAttribute("joinInfo", memInfo);

							request.setAttribute("joinInfo", memInfo);
							//request.getAttribute("joinInfo");
					%>
				
					<!-- 3번째 페이지 -->
					<div class="container text-center title-image">
						<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-check"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>
					</div>
					<br/><br/>
					<div class="text-center">
						<h3>이메일 인증단계</h3>
						<hr />
					</div>
					<br /><br /><br />

					<form class="form-horizontal" name="step1Frm" method="post" action="${pageContext.request.contextPath}/member/join" onsubmit="return checkAuthKey(this);">
						<input type="hidden" id="action" name="action" value="complete">

						<div class="form-group text-center">
							<b>${joinInfo.email_address }</b> <label for="inputauthkey" class="col-xs-12 text-center">위 메일로 발송된 8자리 인증 번호를 입력해주세요.</label>
						</div>

						<div class="form-group">
							<div class="col-sm-4 col-xs-2 text-center">
								<div id="countdown"></div>
							</div>
							<div class="col-sm-4 col-xs-8 text-center">
								<input type="text" class="form-control form-up" name="authkey" id="authkey" data-rule-required="true" placeholder="인증번호 입력(10분 동안 유효)" maxlength="8">
							</div>
							<div class="col-sm-4 col-xs-2 text-center"></div>
						</div>

						<div class="form-group">
							<div class="col-xs-12 text-center">
								<button type="submit" class="checkAuth_btn btn btn-success join-one-btn">다음</button>
							</div>
						</div>

						<div class="form-group text-center">
							<span class="text-center"> <a class="link_login link_resend" href="javascript:popModal('#layer_resend');" target="_blank"><b>인증메일을 받지 못하셨나요?</b></a>
							</span>
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
					

					function checkAuthKey(f){
						if (!f.authkey.value) {
							popLayerMsg("인증 번호를 입력하세요.");
							 $('.checkAuth_btn').prop("disabled", false);
							f.authkey.focus();
							return false;
						}
						
						
						
						 
						 var url="${pageContext.request.contextPath}/member/json/authkey_check.json";
						 var params= "auth_key="+f.authkey.value+"&user_id=${joinInfo.user_id}&password=${joinInfo.password}";
						 var isMatched = false;
						// alert(url+"?"+params);
						//popLayerMsg(url+"?"+params); 
						popLayerMsg("인증 번호 확인중");
						//동기방식으로 호출 그래야 알맞게 return 됨
						$.ajax({
							type: 'post',
							async : false,
							url: url,
						      dataType:'json',      
						      data: params,

						      success:function(data){     //success에 성공했을 때 동작 넣기.
						       
						       //인증번호 일치
						       if(data.result == "success"){
						        	//alert("인증 성공");
						        	//popLayerMsg("인증 되었습니다.");
						        	isMatched = true;
						       }
						       else{
						    	   
						    	  popModal("#layer_unmatched_authkey");
						    	  $('.checkAuth_btn').prop("disabled", false);
						    	  isMatched = false;
						       }
						       
						      },
						      error: function () {
						    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
						    	  $('.checkAuth_btn').prop("disabled", false);
						    	  isMatched = false;
						       }
						     });
						
						return isMatched;

					}
					
					function popModal(modalSelector){
						
						$(modalSelector).modal();
						
						
					}
					
					function popResendAuthMail(){
						
						$("#layer_resend").modal();
						
					}
					
					function sendAuthMail(){
						
						$("#layer_resend .close").click();
						
						//countdown( "countdown", 10, 0 );
						
						 var authkey = document.getElementById("authkey");
						 var url="${pageContext.request.contextPath}/mail/mail_authkey_send.json";
						 var params="to=${joinInfo.email_address}&user_id=${joinInfo.user_id}&password=${joinInfo.password}";
						 
						 //popLayerMsg(url+"?"+params);
						 popLayerMsg("인증메일 발송중 입니다.");
						 
						 //var jsonparams = JSON.stringify(${joinInfo}); 
						 
					$.ajax({
						type: 'post',

						url: url,
					      dataType:'json',      //dataType에 데이터 타입 넣기
					      data: params,

					      success:function(data){     //success에 성공했을 때 동작 넣기.
					       
					       //중복되지 않은 경우
					       if(data.result == "success"){
					        	
					    	   popLayerMsg("인증 메일이 발송 되었습니다.");
					    	   
					       }
					       //중복된 경우
					       else{
					    	   
					    	   popLayerMsg("메일 발송 오류");
					        //document.getElementById("Span").innerText = "이미 사용중이거나 탈퇴한 아이디입니다."+data.result;
					       }
					       
					      },
					      error: function () {
					    	 
					    	  popLayerMsg("AJAX Error 발생"+ e.status+":"+e.statusText);
					      }
					     });
					
						
						
					}
					
					function countdown( elementName, minutes, seconds )
					{
					    var element, endTime, hours, mins, msLeft, time;

					    function twoDigits( n )
					    {
					        return (n <= 9 ? "0" + n : n);
					    }

					    function updateTimer()
					    {
					        msLeft = endTime - (+new Date);
					        if ( msLeft < 1000 ) {
					            element.innerText = "인증기간 만료!";
					        } else {
					            time = new Date( msLeft );
					            hours = time.getUTCHours();
					            mins = time.getUTCMinutes();
					            element.innerHTML = (hours ? hours + ':' + twoDigits( mins ) : mins) + ':' + twoDigits( time.getUTCSeconds() );
					            setTimeout( updateTimer, time.getUTCMilliseconds() + 500 );
					        }
					    }

					    element = document.getElementById( elementName );
					    endTime = (+new Date) + 1000 * (60*minutes + seconds) + 500;
					    updateTimer();
					}
					
					 window.onload = function(){
						 
						 sendAuthMail();
					 }
					</script>



					<%
						} else if (action != null && action.equalsIgnoreCase("complete")) {

							//request.getAttribute("joinInfo");
					%>
					
					
					<!-- 4번째 페이지 -->
					<div class="container text-center title-image">
						<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-unchecked"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-check"></span>
					</div>
					<br/><br/>
					<div class="text-center">
						<h3>
							플레너스계정 가입완료
						</h3>
						<hr />
					</div>
					<br /><br /><br />
					<br /><br />
					
					<div class="row text-center">
						<b><strong class="tit_info">${joinInfo.user_name}님의 회원가입을 환영합니다!</strong></b>
						<p class="text-center">${joinInfo.user_id}으로 로그인하시면 다양한 서비스를 이용하실 수 있습니다.</p>
					</div>

					<div class=" container">
						<div class="text-center">
							<button class="btn btn-info join-one-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/member/login';">확인</button>
						</div>
					</div>


					<%
						}
					%>

				</div>
				<!-- //CONTAINER -->


			</section>
			<!-- //HOME -->


		<!-- 모달창 -->

		<div class="modal fade" id="layer_resend" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">

						<span class="glyphicon glyphicon-envelope"></span> <strong class="text-danger"> 인증메일을 받지 못하셨나요? </strong>

						<button type="button" class="close" data-dismiss="modal">&times;</button>

					</div>
					<div class="modal-body">

						<ul class="list-group">
							<li>1. 이메일을 올바르게 입력하셨는지 다시한번 확인해보세요.</li>
							<li>2. 스팸편지함 혹은 휴지통 등의 편지함을 확인해보세요.</li>
							<li>3. 메일서비스에 따라 메일이 도착하기 까지 다소 시간이 걸릴 수 있습니다.</li>
						</ul>
						<p>하루가 지나도 이메일이 오지 않으면, 고객센터에 문의해 주세요.</p>


					</div>

					<div class="modal-footer">

						<button class="btn btn-default" onclick="sendAuthMail();" type="button">인증메일 재발송</button>

						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>닫기
						</button>

					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" id="layer_unmatched_authkey" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">


						<span class="ico_myinfo ico_mail"></span> <strong class="text-danger"> 입력하신 인증번호가 올바르지 않습니다 </strong>


					</div>
					<div class="modal-body">

						<p>이메일로 발송된 인증번호를 다시 확인해주세요.</p>


					</div>

					<div class="modal-footer">

						<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>


					</div>
				</div>
			</div>
		</div>

	<!-- 이미지 프리로더,우측 사이드바 필요한 부분 -->

	<script src="${pageContext.request.contextPath}/resources/js/script.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
</div>
</body>
</html>
