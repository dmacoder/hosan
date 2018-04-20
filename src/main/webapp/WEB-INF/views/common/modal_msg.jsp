<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="modal fade " id="layer_msg" tabindex="-1" role="dialog" aria-labelledby="layer_msg_title" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="layer_msg_title">알림</h4>
			</div>
			<div class="modal-body" id="layer_msg_content">...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="layer_faq_qna" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">

						<span class="glyphicon glyphicon-envelope"></span> <strong class="text-danger"> 자주 묻는 질문 안내 </strong>

						<button type="button" class="close" data-dismiss="modal">&times;</button>

					</div>
					<div class="modal-body">

						<ul class="list-group" id="FAQInnerUL">
							<li><a href="">1. 자주 묻는 질문 테스트</a></li>
							
						</ul>

					</div>

					<div class="modal-footer">
						<p>원하는 결과를 찾지 못했나요?</p>
						<button class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/customercenter/email';" type="button">플래너스 고객센터</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>닫기
						</button>

					</div>
				</div>
			</div>
		</div>


<script>


//페이징
function faqPaging(nowPage, service_srl, category_srl) {
	getHotFAQList(nowPage, service_srl, category_srl);
}

//리스트 가져오기
function getHotFAQList(nowPage, service_srl, category_srl) {
	nowPage = typeof nowPage !== 'undefined' ? nowPage : 1;

	service_srl = typeof service_srl !== 'undefined' ? service_srl : 1;

	var url = "${pageContext.request.contextPath}/customercenter/faq/json/faq_list.json";
	var inHTML = "";

	inHTML += "<div class=\"panel-group panel-accordion dark-accordion\">";
	inHTML += "		<div class=\"row\" >";

	var inHTMLPaging = "";
	$("#FAQInnerUL").empty();
	var params = "category_srl=" + category_srl + "&service_srl=" + service_srl + "&nowPage=" + nowPage;
	$.ajax({
		url : url,
		dataType : "json",
		type : "get",
		data : params,
		contentType : "text/html; charset=utf-8",
		success : function(data) {
			$.each(data.faqLists, function(index, faqList) { // each로 모든 데이터 가져와서 items 배열에 넣고

				inHTML += "<div id=\"faqDiv_" + faqList.faq_srl + "\" class=\"mix category-1 col-lg-12 panel panel-default\" data-value=\"" + (index + 1) + "\" style=\"display: inline-block;\">";
				inHTML += "	<div class=\"panel-heading\">";
				inHTML += "		<h4 class=\"panel-title\">";
				inHTML += "			<a class=\"collapsed\" data-toggle=\"collapse\" data-parent=\"#faqBody\" href=\"#question" + (index + 1) + "\"> <strong class=\"c-gray-light\">" + (index + 1) + ".</strong> " + faqList.title;
				inHTML += "			</a>";
				inHTML += "		</h4>";

				inHTML += "	</div>";
				inHTML += "	<div id=\"question" + (index + 1) + "\" class=\"panel-collapse collapse\" style=\"height: 0px;\">";
				inHTML += "		<div class=\"panel-body\">";
				inHTML += "			<p>" + faqList.contents + "</p>";
				inHTML += "		</div>";
				inHTML += "	</div>";

				inHTML += "</div>";

			});//each끝
			inHTML += "<div class=\"row text-center\">";
			inHTML += "<ul class=\"pagination\" id=\"FAQInnerULPagingDiv\">";
			inHTML += "</ul> </div>";
			inHTML += "		</div>";
			inHTML += "		</div>";
			$("#FAQInnerUL").html(inHTML);
			$("#FAQInnerULPagingDiv").html(data.pagingDiv);
		},
		error : function(e) {
			popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
		}
	});
}
	//레이어 팝업창 (alert 왠만하면 쓰지말자.. 사용자가 짜증나니깐)
	
	var modalVerticalCenterClass = ".modal";

	function popModal(modalSelector) {
		$(modalSelector).modal();
	}

	function centerModals($element) {
		var $modals;
		if ($element.length) {
			$modals = $element;
		} else {
			$modals = $(modalVerticalCenterClass + ':visible');
		}
		$modals.each(function(i) {
			var $clone = $(this).clone().css('display', 'block').appendTo(
					'body');
			var top = Math.round(($clone.height() - $clone.find(
					'.modal-content').height()) / 2);
			top = top > 0 ? top : 0;
			$clone.remove();
			$(this).find('.modal-content').css("margin-top", top);
		});
	}

	function popLayerMsg(msg) {
		$("#layer_msg_content").empty();
		$("#layer_msg_content").append("<p>" + msg + "</p>");
		$("#layer_msg").modal();

	}

	$(modalVerticalCenterClass).on('show.bs.modal', function(e) {
		centerModals($(this));
	});

	$(window).on('resize', centerModals);
</script>

<c:if test="${not empty layer_msg}">

	<c:choose>
		<c:when test="${not empty error_msg}">
			<script>
				$(document).ready(function() {
					popLayerMsg("${layer_msg} <br/> ${error_msg}");
				});
			</script>
		</c:when>

		<c:otherwise>
			<script>
				$(document).ready(function() {
					popLayerMsg("${layer_msg}");
				});
			</script>
		</c:otherwise>
	</c:choose>

</c:if>