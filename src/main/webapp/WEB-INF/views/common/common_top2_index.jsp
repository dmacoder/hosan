<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	var isEmpty = function(value) {
		if (value == "" || value == null || value == undefined || (value != null && typeof value == "object" && !Object.keys(value).length)) {
			return true
		} else {
			return false
		}
	};

	function keyExists(key, search) {
		if (!search || (search.constructor !== Array && search.constructor !== Object)) {
			return false;
		}
		for (var i = 0; i < search.length; i++) {
			if (search[i] === key) {
				return true;
			}
		}
		return key in search;
	}

	$(document).ready(function() {
		maxCategoryCount = getCategoryCount();
		for (var i = 1; i <= maxCategoryCount; i++) {
			initTopNav(i);
		}
	});

	function getCategoryCount() {
		var url = "${pageContext.request.contextPath}/board/json/subcategory_list.json";
		
		var returnVal = 0;
		$.ajax({
			async : false,
			cache : false, // 캐시 사용 없애기
			type : 'get',
			url : url,
			//data : params,
			//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(data) {

				
				var items = [];
				
				$.each(data.subCategoryList, function(index, categoryVO) { // each로 모든 데이터 가져와서 items 배열에 넣고

					if (!keyExists(categoryVO.category_srl, items)) {
						returnVal++;
						items.push(categoryVO.category_srl);
						
					}

				});

			},

			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}

		});
		
		return returnVal;
	}

	function initTopNav(category_srl) {

		category_srl = typeof category_srl !== 'undefined' ? category_srl : "";

		if (isEmpty(category_srl)) {

			category_srl = "";
		}

		//$('#CategoryTitle').empty();
		$('#navbar-nav2').empty();

		var url = "${pageContext.request.contextPath}/board/json/subcategory_list.json";
		var params = "category_srl=" + category_srl;
		//alert(params);
		$.ajax({
			cache : false, // 캐시 사용 없애기
			type : 'get',
			url : url,
			data : params,
			//data : JSON.stringify({ board_type: 'E', pageSize: '3', blockPage: '1'}),
			//contentType: 'application/json; charset=utf-8',
			dataType : 'json',
			//contentType: "application/x-www-form-urlencoded; charset=utf-8",				
			//dataType: "text",	
			success : function(data) {

				var inHTML = "";

				var listInHTML = "";

				var arrLength = data.subCategoryList.length;

				$.each(data.subCategoryList, function(index, categoryVO) { // each로 모든 데이터 가져와서 items 배열에 넣고

					if (index == 0) {
						inHTML += "<li class=\"dropdown\"><a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"javascript:selectCategory(" + categoryVO.category_srl + ")\" >" + categoryVO.category_name + "</a>";
						inHTML += "<ul class=\"dropdown-menu navbar-nav3\">";
					}
					//inHTML+="<li><a href=\"javascript:selectSubCategory("+categoryVO.category_srl+","+categoryVO.subcategory_srl+")\"><span>"+index+"</span>"+categoryVO.subcategory_name+"</a></li>";

					inHTML += "<li><a href=\"javascript:selectSubCategory(" + categoryVO.category_srl + "," + categoryVO.subcategory_srl + ")\">" + categoryVO.subcategory_name + "</a></li>";

					if (index === arrLength - 1)
						inHTML += "</ul></li>";

				});//each끝

				//alert(inHTML);

				if (jQuery.isEmptyObject(data.subCategoryList)) {
					//$('#navbar-nav2').html("<li><a href=\"#\">서브 카테고리 없음</a></li>");
				} else {
					$('#navbar-nav2').append(inHTML);
				}

			},

			error : function(e) {
				popLayerMsg("AJAX Error 발생" + e.status + ":" + e.statusText);
			}

		});
	}
</script>
<nav class="navber navbar-fixed-top hide" id="navbar-fixed-top2">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<ul class="nav navbar-nav navbar-left" id="navbar-nav2">
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">건축</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">내부마감</a></li>
							<li><a href="#">싱크대가구</a></li>
							<li><a href="#">화장실</a></li>
							<li><a href="#">타일</a></li>
							<li><a href="#">바닥마감</a></li>
							<li><a href="#">전등설치</a></li>
							<li><a href="#">수도설비</a></li>
							<li><a href="#">보일러&벽난로</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">디자인</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">로고디자인</a></li>
							<li><a href="#">명함&인쇄물</a></li>
							<li><a href="#">패키지&북커버</a></li>
							<li><a href="#">현수막&POP</a></li>
							<li><a href="#">웹&모바일 디자인</a></li>
							<li><a href="#">SNS&커뮤니티</a></li>
							<li><a href="#">배너&상세페이지</a></li>
							<li><a href="#">포토샵편집</a></li>
							<li><a href="#">캐치커쳐&인물</a></li>
							<li><a href="#">웹툰&캐릭터</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">IT&프로그래밍</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">워드프레스</a></li>
							<li><a href="#">웹사이트개발</a></li>
							<li><a href="#">웹사이트유지보수</a></li>
							<li><a href="#">모바일앱&웹</a></li>
							<li><a href="#">커머스&쇼핑몰</a></li>
							<li><a href="#">프로그램개발</a></li>
							<li><a href="#">기술지원</a></li>
							<li><a href="#">파일변환</a></li>
							<li><a href="#">데이터베이스</a></li>
							<li><a href="#">데이터분석&리포트</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">번역&통역</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">영어</a></li>
							<li><a href="#">일본어</a></li>
							<li><a href="#">중국어</a></li>
							<li><a href="#">프랑스어</a></li>
							<li><a href="#">독일어</a></li>
							<li><a href="#">스페인어</a></li>
							<li><a href="#">포르투갈어</a></li>
							<li><a href="#">러시아어</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">컨텐츠제작</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">영상제작</a></li>
							<li><a href="#">사진&영상촬영</a></li>
							<li><a href="#">더빙&녹음</a></li>
							<li><a href="#">음악제작</a></li>
							<li><a href="#">연주&제작</a></li>
							<li><a href="#">BGM&사운드</a></li>
							<li><a href="#">모델&아나운서</a></li>
							<li><a href="#">기타</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">핸드메이드</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">리빙&인테리어</a></li>
							<li><a href="#">음식</a></li>
							<li><a href="#">패션&뷰티</a></li>
							<li><a href="#">육아&아동</a></li>
							<li><a href="#">반려동물</a></li>
							<li><a href="#">아트&공예</a></li>
							<li><a href="#">기타</a></li>
						</ul></li>
				</ul>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>
	</div>
</nav>