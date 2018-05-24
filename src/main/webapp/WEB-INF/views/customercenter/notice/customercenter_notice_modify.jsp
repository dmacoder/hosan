<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script charset="utf-8">
	$(function() {
		//전역변수선언
		var oEditors = [];
		var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR
		var ctx = getContextPath();

		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "contents",
			sSkinURI : ctx + "/resources/smarteditor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function() {

				}
			}
		});
		
	



		

		$('#modifyActionBtn').click(function() {

			//폼값 검증

			if ($("input[type='text'][name='title']").val() == "") {
				popLayerMsg("제목을 입력해주세요");
				$("input[type='text'][name='title']").focus();
				return;
			}

			//id가 smarteditor인 textarea에 에디터에서 대입
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			
			
			// 이부분에 에디터 validation 검증
			var el = document.createElement('html');
			el.innerHTML = oEditors.getById["contents"].elPlaceHolder.value;

			//폼 검증
			var contentsVal = $("#contents").val();

			if (contentsVal == null || contentsVal == "" || contentsVal == '&nbsp;' || contentsVal == '<p>&nbsp;</p>') {
				popLayerMsg("내용을 입력해주세요");
				oEditors.getById["contents"].exec("FOCUS"); //포커싱
				return;
			}

			//글수정 처리
			var params = $('#modifyNoticeFrm').serialize();
			var notice_srl = '<c:out value="${noticeVO.notice_srl}"/>';
			var contents = oEditors.getById["contents"].getIR(); 
				
			var title = $("input[type='text'][name='title']").val();

			var url = "${pageContext.request.contextPath}/customercenter/notice/"+notice_srl;
			$.ajax({
				cache : false, // 캐시 사용 없애기
				url : url,
				type : "put",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				
				dataType : "json",
				//contentType : "text/html; charset=utf-8",
				data : JSON.stringify({
					title : title,
					contents : contents
			}),
				//data : params,
				success : function(d) {
					if (d.result == "fail") {
						if (d.errorMsg == "isNotLogin") {
							popLayerMsg("공지사항을 수정하시려면 관리자 아이디로 로그인 해주세요.");
							location.href = "${pageContext.request.contextPath}/member/login";
						} else if (d.errorMsg == "isNotAdmin") {
							popLayerMsg("공지사항을 수정하시려면 관리자 아이디로 로그인 해주세요.");
							location.href = "${pageContext.request.contextPath}/member/login";
						}

					} else if (d.result == "success") {

						/* console.log("result: " + d.result); */
						popLayerMsg("글수정을 성공하였습니다.");
						//location.href = "${pageContext.request.contextPath}/customercenter/notice";
						getListNotice(1);
					}

				},
				error : function(e) {
					popLayerMsg("요청실패:" + e.status + " " + e.statusText);
				}
			});
		});

		function getContextPath() {
			return sessionStorage.getItem("contextpath");
		}
		
		function setDefaultFont() {

			var sDefaultFont = '궁서';

			var nFontSize = 24;

			oEditors.getById["contents"].setDefaultFont(sDefaultFont, nFontSize);

		}

	});
</script>
<script type="text/javascript" charset="utf-8">
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>

<script type="text/javascript">

	$(document).ready(function() {


		$("#listView").click(function() {
			getListNotice(1);
		});

	});
</script>

<form id="modifyNoticeFrm">

	<div class="write-body">

		<div class="title2">

			<p class="p-title">제목</p>
			<input type="text" class="form-control" placeholder="제목을 입력하세요" name="title" value="${noticeVO.title }"/>
		</div>
		<div class="contents">
			<p class="p-title">내용</p>


			<textarea class="form-control" name="contents" id="contents" rows="10" cols="80" placeholder="내용을 입력하세요">${noticeVO.contents }</textarea>
		</div>


	</div>
	<div class="write-btn">
		<button type="button" class="btn btn-info" id="listView">목록보기</button>
		<button type="button" class="btn btn-success" id="modifyActionBtn">수정완료</button>
	</div>



</form>
