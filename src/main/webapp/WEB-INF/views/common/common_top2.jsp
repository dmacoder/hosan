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
		async : false, //반드시 비동기로 카운트 가져오고 나서 후처리 되어야함
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

function initTopNav(category_srl){
	
 	category_srl = typeof category_srl !== 'undefined' ? category_srl : "";
	
	if (isEmpty(category_srl)) {
		
		category_srl = "";
	} 
	
	
	//$('#CategoryTitle').empty();
	$('#navbar-nav2').empty();
		
	var url = "${pageContext.request.contextPath}/board/json/subcategory_list.json";
	var params = "category_srl=" + category_srl ;
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
			
			if(index==0)
			{
				inHTML+="<li class=\"dropdown\"><a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"javascript:selectCategory("+categoryVO.category_srl+")\" >"+categoryVO.category_name+"</a>";
				inHTML+="<ul class=\"dropdown-menu navbar-nav3\">";		
			}
				//inHTML+="<li><a href=\"javascript:selectSubCategory("+categoryVO.category_srl+","+categoryVO.subcategory_srl+")\"><span>"+index+"</span>"+categoryVO.subcategory_name+"</a></li>";
				
							
				inHTML+="<li><a href=\"javascript:selectSubCategory("+categoryVO.category_srl+","+categoryVO.subcategory_srl+")\">"+categoryVO.subcategory_name+"</a></li>";
				
				if (index === arrLength-1)
				inHTML+="</ul></li>";
				
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

<nav class="navber navbar-fixed-top" id="navbar-fixed-top2">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
			<div class="col-lg-8 col-sm-10 col-xs-12">
				<ul class="nav navbar-nav navbar-left" id="navbar-nav2">
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" >건축</a>
						<ul class="dropdown-menu navbar-nav3">
							<li><a href="#">내부마감</a></li>
							<li><a href="#">싱크대가구</a></li>
							<li><a href="#">화장실</a></li>
							<li><a href="#">타일</a></li>
							<li><a href="#">바닥마감</a></li>
							<li><a href="#">전등설치</a></li>
							<li><a href="#">수도설비</a></li>
							<li><a href="#">보일러&amp;벽난로</a></li>
						</ul></li>
					
				</ul>
			</div>
			<div class="col-lg-2 col-sm-1 col-xs-0"></div>
		</div>
	</div>
</nav>