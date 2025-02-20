<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<% String ctxPath = request.getContextPath(); %>

<jsp:include page=".././header/header.jsp"></jsp:include>


<style type="text/css">

div#container {
	width: 70%;
	margin: 0 auto;
}

div#product_wrap {
	width: 100%;
}

/* 검색 텍스트 div */
div.search_result_text {
	display: flex;
	margin-bottom: 20px;
	align-items: center;
}

span.search_word {
	font-weight: bold;
	font-size: 20pt;
}

span.search_result {
	font-size: 20pt;
	margin-left: 5px;
}

span.search_amount {
	margin-left: 5px;
}

/* 필터 테이블 */
div#search_table {
	margin-top: 80px;
	padding: 0 10px;
}

tr.tr_title {
	border-top: solid 2px black;
}

/* 플러스, 마이너스 버튼 */
button.plus_minus {
	border: none;
	background-color: transparent;
}

i.plus_minus {
	color: #cccccc;
}


td.td_title {
	background-color: #F7F9FA
}


/* 상품 시세 관련 */
div#current_price {
	display: flex;
	justify-content: center;
	margin-top: 40px;
	width: 100%;
	padding: 0 10px;
}

div#average_price, 
div#high_price,
div#low_price	{
	width: 100%;
	display: flex;
	padding: 0 80px;
	flex: 1;
	height: 76px;
	background-color: #F7F9FA;
	justify-content: space-between;
	align-items: center;
	border-radius: 6px;
}

span.sort {
	font-size: 12pt
}

span.price {
	font-size: 15pt;
	font-weight: bold;
}


/* 상품 정렬 방식 관련 */
div#product_sort {
	padding: 0 10px;
}

li.sort {
	list-style: none;
	display: inline-block;
}

ul.sort {
	margin-top: 20px;
	margin-bottom: 0px;
	text-align: right;
}

button.recent_sort,
button.high_sort,
button.low_sort {
	border: none;
	background-color: white;
	font-size: 10pt;
	color: #5a5a5a;
	padding: 1px 3px;
}


/* 상품 리스트 관련 */
div#product_list {
	margin: 0 auto;
}

div.row {
  	margin-left: 0px;
  	margin-right: 0px;
}

div#card_wrap {
	padding: 0;
	width: 100%;
}

div.card {
	position: relative;
	border: none;
	widht: 100%;
	margin: 20px 10px;
	cursor: pointer;
}

div.card-body {
	padding: 0px;	
}


/* 상품 이미지 */
img.card-img-top {
	width: 100%;
	height: 100%;
	border-radius: 6px;
}

/* 하트아이콘 */
i#wish {
	 position: absolute; 
	 top: 10px; 
	 right: 10px; 
	 color: #0DCC5A;
	 font-size: 16pt;
}

/* 상품 제목 */
div.product_title {
	margin-bottom: 20px;
}

span.product_title {
	font-size: 12pt;
}


/* 상품 가격 */
div.product_price {
	margin-bottom: 10px;
}

span.product_price {
	font-size: 15pt;
	font-weight: bold;
}


/* 동네 및 등록일자 정보 */
div.product_regdate {
	font-size: 10pt;
	color: #999999;
}


</style>

<div id="container">

	<div id="product_wrap">
		
		<!-- 상단 테이블 -->
		<div id="search_table">
			
			<!-- 검색 결과 텍스트 -->
			<div class="search_result_text">
				<span class="search_word">'뉴발란스'</span>
				<span class="search_result">검색결과</span>
				<span class="search_amount">총 10개</span>
			</div>
			
			<!-- 필터메뉴 -->
			<div class="filter_table">
				<table class="table">
				<colgroup> <%-- 테이블 간 간격 설정 --%>
		    	<col style="width: 15%;">
		    	<col style="width: 85%;">
	    		</colgroup>
					<tbody>
						<tr class="tr_title">
							<td class="td_title td_first_title">
								<div style="display: flex; justify-content: space-between;">
									<span>카테고리</span>
									<button class="plus_minus"><i class="fa-solid fa-plus plus_minus"></i></button></td>
								</div>
							<td >전체</td>
						</tr>
						<tr class="tr_second">
							<td class="td_title td_second_title"><span>카테고리상세</span></td>
							<td>패션잡화</td>
						</tr>
						<tr>
							<td class="td_title">가격</td>
							<td>최소가격~최대가격 적용</td>
						</tr>
						<tr>
							<td class="td_title">근처동네</td>
							<td>서교동</td>
						</tr>
					</tbody>
				</table>
			</div>	
		</div>
	
		<!-- 상품 현재 시세 --> 
		<div id="current_price" class="row">
			<div class="col-sm-4" id="average_price">
				<span class="sort">평균가격</span>
				<span class="price"><fmt:formatNumber value="1000" pattern="#,###" /> 원</span>
			</div>
			<div class="col-sm-4" id="high_price">
				<span class="sort">가장 높은 가격</span>
				<span class="price"><fmt:formatNumber value="1000" pattern="#,###" /> 원</span>
			</div>
			<div class="col-sm-4" id="low_price" >
				<span class="sort">가장 낮은 가격</span>
				<span class="price"><fmt:formatNumber value="1000" pattern="#,###" /> 원</span>
			</div>		
		</div>
		
		
		<!-- 상품 정렬 방식 -->
		<div id="product_sort">
			<ul class="sort">
				<li class="sort">
					<button class="recent_sort">최신순</button>
				</li>
				<li class="sort">
					<button class="high_sort">높은가격순</button>
				</li>
				<li class="sort">
					<button class="low_sort">낮은가격순</button>
				</li>
			</ul> 
		</div>
		
		
		<!-- 상품 리스트  -->
		
		<div id="product_list" class="row">
		<c:forEach var="i" begin="1" end="30" varStatus="status">
				<div id="card_wrap" class="col-md-6 col-lg-3">
					<div class="card">
						
						<!-- 상품 이미지 및 하트 아이콘 -->
						<div class="card-head">
							<img src='<%= ctxPath%>/resources/productImages/20250219160551584091671131800.jpg' class="card-img-top mb-3 zoom"/>
							<span><i id="wish" class="fa-regular fa-heart" onclick="wishInsert(this)" ></i></span>
						</div>
						
						<div class="card-body">
							<!-- 상품 제목 -->
							<div class="product_title">
								<span class="product_title">뉴발란스991v2</span>
							</div>
							
							<!-- 상품 가격 -->
							<div class="product_price">
								<span class="product_price"><fmt:formatNumber value="1000" pattern="#,###" /> 원</span>
							</div>
							
							<!-- 동네 및 등록 일자 -->
							<div class="product_regdate">
								<span class="product_town">서교동</span>
								<span class="bar">|</span>
								<span class="product_time">45분 전</span>
							</div>
						</div>
						
					</div>
				</div>
		</c:forEach>
		</div>
	
		
	</div>
</div>


<jsp:include page=".././footer/footer.jsp"></jsp:include>



<script>


	$(document).ready(function(){
		
		// 하위 카테고리 테이블 숨겨놓기
		$("tr.tr_second").hide();
		
		
		// 카테고리 + 및 - 버튼을 클릭한 경우
		$("button.plus_minus").click(function(e){
			if($(e.target).hasClass("fa-plus")) { // + 버튼을 누르면
				$("tr.tr_second").show(); // 하위 카테고리 펼치기
				$("i.plus_minus").removeClass("fa-plus").addClass("fa-minus"); // 마이너스 아이콘으로 변경하기
			} 
			else { // - 버튼을 누르면
				$("tr.tr_second").hide(); // 하위 카테고리 접기
				$("i.plus_minus").removeClass("fa-minus").addClass("fa-plus"); // 플러스 아이콘으로 변경하기
			}
		});
		
	}); // end of $(document).ready(function(){

		
		
	// Function Declaration---------------------------------	
	
	// 하트 모양(좋아요) 클릭한 경우
	function wishInsert(e) {
		if($(e).hasClass("fa-regular")) {
	        $(e).removeClass("fa-regular").addClass("fa-solid"); // 하트 채우기
	        alert("찜 추가");
		} 
		else {
			$(e).removeClass("fa-solid").addClass("fa-regular"); // 하트 비우기
			alert("찜 제거");
		}
		
	} // end of function wishInsert()
	
	
	
	

</script>