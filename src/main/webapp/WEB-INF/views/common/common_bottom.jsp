<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	// 아이디클릭시 팦메뉴나오기
	function popUserMenu2(user_id) {

		var ctx = '<c:out value="${pageContext.request.contextPath}"/>';
		
		var popup = document.getElementById("userPopup");
		
		
		
		var login_user_id = '<c:out value="${loginUserInfo.userId}"/>';
		
		var searchPath = '<c:out value="${pageContext.request.contextPath}"/>'+'/board/service?searchType=i&keyword='+user_id;
				
		var userMenuInnerHTML ="";

		userMenuInnerHTML+="<a href=\""+ctx+"/profile/"+user_id+"\">회원정보보기</a><br />"; 
		userMenuInnerHTML+="<a href=\""+ctx+"/message\">쪽지보내기</a><br />"; 
		
		if(login_user_id==user_id)
		{
			userMenuInnerHTML+="<a href=\""+searchPath+"\">작성글보기</a>";
			userMenuInnerHTML+="<br />";
			userMenuInnerHTML+="<a href=\""+ctx+"/member/myinfo\">계정 관리</a>";
			userMenuInnerHTML+="<br />";
		}
			
		$("#userPopup").html(userMenuInnerHTML);
		popup.classList.toggle("show");
	}
	
	function popUserMenu() {

		var popup = document.getElementById("userPopup");
		
	
		popup.classList.toggle("show");
	}
</script>
<script type="text/javascript">
	/* 	$(document).ready(function() {
	 var url = "${pageContext.request.contextPath}/notice/smallABoard"
	 $.ajax({
	 url : url,
	 dataType : "html",
	 type : "get",
	 contentType : "text/html; charset:utf-8",
	 data : {
	 param1 : "값1"
	 },
	 success : function(d) {
	 $('#smallABoard').html(d);
	 },
	 error : function(e) {
	 alert("실패" + e);
	 }
	 });
	 }); */
	$(document).ready(function() {
		getListNoticeOne(1);
	});

	function noticePaging(nowPage) {
		getListNoticeOne(nowPage);
	}

	//공지사항 리스트 개수 지정해서 가져오기
	function getListNoticeOne(nowPage) {

		// 파라미터에 nowPage=1로 기본값 파라미터 설정.
		// 디폴트 기본값 세팅 ( Edge, IE 11 버전에서는 작동하지 않으므로 다음과 같이 씀)
		nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;

		var url = "${pageContext.request.contextPath}/customercenter/notice/json/notice_list.json";
		var inHTML = "";

		var inHTMLPaging = "";
		$("#noticeBodyBottom").empty();
		var params = "nowPage=" + nowPage + "&pageSize=1&blockPage=1";
		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
			data : params,
			contentType : "text/html; charset=utf-8",
			success : function(data) {
				$.each(data.noticeLists, function(index, noticeList) { // each로 모든 데이터 가져와서 items 배열에 넣고

					inHTML += "<a href=\"${pageContext.request.contextPath}/customercenter/notice/"+noticeList.notice_srl+"\" style=\"font-size: 14px;\"> - " + noticeList.title + "&nbsp;&nbsp;</a>";

				});//each끝
				inHTML += "<div class=\"row text-center\">";
				inHTML += "<ul class=\"pagination\" id=\"noticePagingDiv\">";
				inHTML += "</ul> </div>";
				inHTML += "		</div>";
				$("#noticeBodyBottom").html(inHTML);
				$("#noticePagingDiv").html(data.pagingDiv);
			},
			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}
		});
	}
</script>
<script src="${pageContext.request.contextPath}/resources/common/js/script.js?ver=<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" />"></script>
<div class="container-fluid" style="background-color: white;">
	<ul class="footer-menu">
		<li><a href="${pageContext.request.contextPath}/policy/provision">이용약관</a></li>ㅣ
		<li><a href="${pageContext.request.contextPath}/policy/privacy">개인정보 취급방식</a></li>ㅣ
		<li><a href="${pageContext.request.contextPath}/about/sitemap">사이트맵</a></li>ㅣ
		<li><a href="${pageContext.request.contextPath}/customercenter/faq">FAQ</a></li>

	</ul>
	<div class="row">
		<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		<div class="col-lg-8 col-sm-10 col-xs-12">
			<div class="footer-body">
				<div class="row">
					<div class="col-xs-10">
						<h4>
							<a href="${pageContext.request.contextPath}/customercenter/notice" class="notice-title">공지사항</a>
						</h4>
						<div id="noticeBodyBottom">안녕하세요? 호산 철학관 입니다.</div>

					</div>
					<div class="col-xs-2">
						<a href="javascript:void(0);" onclick="getHotFAQList(1, 1, '');popModal('#layer_faq_qna');"><img class="footer-gara" src="${pageContext.request.contextPath}/resources/images/gara.jpg" title="서비스센터" /></a>
					</div>
				</div>
			</div>
			<div class="footer-waming">
				<p>(주)호산철학관의 사전 서면 동의 없이 사이트의 일체의 정보, 콘텐츠 및 UI등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</p>
			</div>
			<div class="footer-info">
				<span><b>상호명:</b>호산철학관&nbsp;&nbsp;&nbsp;l&nbsp;&nbsp;&nbsp;</span> <span><b>주소:</b>서울시 금천구 코스모로 17길 41, 14층&nbsp;&nbsp;&nbsp;l&nbsp;&nbsp;&nbsp;</span> <span><b>원장:</b>여여행&nbsp;&nbsp;&nbsp;l&nbsp;&nbsp;&nbsp;</span> <span><b>개인정보관리책임자:</b>박세창</span><br /> <span><b>사업자등록번호:</b>682-45-78541&nbsp;&nbsp;&nbsp;l&nbsp;&nbsp;&nbsp;</span> <span><b>전화번호:</b>1544-6524&nbsp;&nbsp;&nbsp;l&nbsp;&nbsp;&nbsp;</span> <span><b>이메일:</b>dmacoder@gmail.com</span><br />
				<h6>Copyright &copy; 2018 OurPlanners Inc. All rights reserved</h6>
			</div>
		</div>
		<div class="col-lg-2 col-sm-1 col-xs-0"></div>
	</div>
</div>

<!-- 
아이디 팝업 메뉴
 -->

<div class="popup" onclick="popUserMenu()">
	<span class="popuptext" id="userPopup"> 
	
	</span>
</div>
