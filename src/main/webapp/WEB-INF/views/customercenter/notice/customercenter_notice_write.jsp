<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script charset="utf-8">
	$(function() {
		//전역변수선언
		var editor_object = [];
		var ctx = getContextPath();
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : editor_object,
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

		$('#writeActionBtn').click(function() {

			if ($("input[type='text'][name='title']").val() == "") {
				popLayerMsg("제목을 입력해주세요");
				$("input[type='text'][name='title']").focus();
				return;
			}

			//id가 smarteditor인 textarea에 에디터에서 대입
			editor_object.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

			// 이부분에 에디터 validation 검증
			var el = document.createElement('html');
			el.innerHTML = editor_object.getById["contents"].elPlaceHolder.value;

			//var elClickedObj = $("#writeNoticeFrm");

			//폼 검증
			var contentsVal = $("#contents").val();

			if (contentsVal == null || contentsVal == "" || contentsVal == '&nbsp;' || contentsVal == '<p>&nbsp;</p>') {
				popLayerMsg("내용을 입력해주세요");
				editor_object.getById["contents"].exec("FOCUS"); //포커싱
				return;
			}

			//글쓰기 처리
			var params = $('#writeNoticeFrm').serialize();

			$.ajax({
				cache : false, // 캐시 사용 없애기
				url : "${pageContext.request.contextPath}/customercenter/notice",
				type : "post",
				dataType : "json",
				//contentType : "text/html; charset=utf-8",
				data : params,
				success : function(d) {
					if (d.result == "fail") {
						if (d.errorMsg == "isNotLogin") {
							popLayerMsg("공지사항을 작성하시려면 관리자 아이디로 로그인 해주세요.");
							location.href = "${pageContext.request.contextPath}/member/login";
						} else if (d.errorMsg == "isNotAdmin") {
							popLayerMsg("공지사항을 작성하시려면 관리자 아이디로 로그인 해주세요.");
							location.href = "${pageContext.request.contextPath}/member/login";
						}

					} else if (d.result == "success") {

						popLayerMsg("글쓰기를 성공하였습니다.");
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
	});
</script>
<script type="text/javascript" charset="utf-8">
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>

<script type="text/javascript">
	/* 
	 $(function() {
	 //전역변수선언
	 var editor_object = [];
	 var ctx = getContextPath();

	 nhn.husky.EZCreator.createInIFrame({
	 oAppRef: editor_object,
	 elPlaceHolder: "contents",
	 sSkinURI: ctx + "/resources/smarteditor/SmartEditor2Skin.html",
	 htParams : {
	 // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	 bUseToolbar : true,             
	 // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	 bUseVerticalResizer : true,     
	 // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	 bUseModeChanger : true,
	 fOnBeforeUnload : function(){
	
	 }
	 }
	 });
	

	
	 function getContextPath(){
	 var offset=location.href.indexOf(location.host)+location.host.length;
	 var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
	 return ctxPath;
	 }
	
	 }); */

	$(document).ready(function() {

		$('#listView').click(function() {
			getListNotice(1);
		});

	});
</script>

<form id="writeNoticeFrm">

	<div class="write-body">

		<div class="title2">

			<p class="p-title">제목</p>
			<input type="text" class="form-control" placeholder="제목을 입력하세요" name="title" />
		</div>
		<div class="contents">
			<p class="p-title">내용</p>


			<textarea class="form-control" name="contents" id="contents" rows="10" cols="80" placeholder="서비스 내용을 입력하세요"></textarea>
		</div>


	</div>
	<div class="write-btn">
		<button type="button" class="btn btn-info" id="listView">목록보기</button>
		<button type="button" class="btn btn-success" id="writeActionBtn">작성완료</button>
	</div>



</form>
