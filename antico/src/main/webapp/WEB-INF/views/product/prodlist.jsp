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

tr.region_tr {
	border-bottom: solid 1px #dee2e6; /* 부트 스트랩 테두리 색상과 맞추기 */
}

input.price_range {
	border: solid 1px #cccccc;
	border-radius: 6px;
	width: 150px;
	height: 40px;
	font-size: 10pt;
	padding: 10px;
}

button.price_range_button {
	margin-left: 10px;
	background-color: black;
	color: white;
	border: none;
	border-radius: 6px;
	width: 60px;
	height: 40px;
	font-size: 10pt;
	font-weight: bold;
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
	background-color: #F7F9FA;
	vertical-align: middle;
}



/* 카테고리 분류 필터 */
ul#category, ul#category_detail {
	list-style-type: none;
	padding-left: 0px;
	display: grid;
    grid-template-columns: repeat(6, 1fr); /* 한 줄에 6개씩 */
    gap: 10px; /* 간격 조정 */
    margin-bottom: 0;
}

li.category, li.category_detail {
	display: inline-block;
	margin-right: 20px;
	cursor: pointer;
	font-size: 10pt;
}

button.choice_region {
	border: none;
	border-radius: 6px;
	font-size: 10pt;
	background-color: #f1f4f6;
	width: 60px;
	height: 30px;
	color: #5a5a5a;
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
	margin-bottom: 30px;
}

div.card {
	position: relative;
 	border: none;
	margin: 20px 10px;
	cursor: pointer;
	height: 100%;
}

div.card-body {
	padding: 0px;
	display: flex;
	flex-direction: column; 		/* 세로 방향으로 정렬 */
	justify-content: space-between; /* 항목들 간의 공간을 균등하게 배분 */
    height: 100%; 					/* 카드 높이를 꽉 채우도록 설정 */	
}


/* 상품 이미지 */
img#prod_img {
	border-radius: 6px;
	object-fit: cover;
	aspect-ratio: 240/240;
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
    flex-grow: 1;		  /* 제목이 공간을 채울 수 있도록 설정 */
    flex-shrink: 1; 	  /* 제목이 너무 커지지 않도록 설정 */
    overflow: hidden; 	  /* 넘치는 텍스트 숨기기 */
    white-space: normal;  /* 텍스트 줄 바꿈 허용 */
    line-height: 1.2; 	  /* 줄 간격을 조정 */
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


/* 상품 검색 결과 없음 */
div#is_no_product {
	margin-top: 60px;
	text-align: center;
}



</style>

<div id="container">

	<div id="product_wrap">
	
		<!-- 상단 테이블 -->
		<div id="search_table">
			<!-- 검색 결과 텍스트 -->
			<div class="search_result_text">
				<c:if test="${not empty requestScope.search_prod}">
					<span class="search_word">'${requestScope.search_prod}'</span>
					<span class="search_result">검색결과</span>
					<span class="search_amount">총 <fmt:formatNumber value="${requestScope.product_list_cnt}" pattern="#,###" />개</span>
				</c:if>
				<c:if test="${empty requestScope.search_prod}">
					<span class="search_result">전체상품</span>
				</c:if>
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
									<button class="plus_minus"><i class="fa-solid fa-plus plus_minus"></i></button>
								</div>
							</td>	
							<td>
								<span onclick="javascript:location.href='<%= ctxPath%>/product/prodlist'" style="cursor: pointer;">전체</span>
								<span class="selected_category" data-category-no="" style="cursor: pointer;"></span> <!-- 상위 카테고리명 -->
								<span class="selected_category_detail" data-categorydetail-no="" style="cursor: pointer;"></span> <!-- 하위 카테고리명 -->
							</td>
						</tr>
						<tr class="tr_second">
							<td class="td_title td_second_title"></td>
							<td>
								<ul id="category"> <!-- 상위 카테고리 -->
									<c:forEach var="category" items="${requestScope.category_list}" varStatus="status">
										<li class="category" data-category-no="${category.pk_category_no}">${category.category_name}</li></a>
									</c:forEach>
								</ul>
								
								<!-- 모든 하위 카테고리 목록 (처음 숨김 처리) -->
						        <ul id="category_detail">
						            <c:forEach var="category_detail" items="${requestScope.category_detail_list}" varStatus="status">
						                <li class="category_detail" data-categorydetail-no="${category_detail.pk_category_detail_no}" data-parent-no="${category_detail.fk_category_no}" style="display: none;">
						                    ${category_detail.category_detail_name}
						                </li>
						            </c:forEach>
						        </ul>	
							</td>
						</tr>
						<tr>
							<td class="td_title">
								<span>가격</span>
							</td>
							<td>
								<input type="text" class="price_range min_price" placeholder="최소 가격"/>
								<span>~</span>
								<input type="text" class="price_range max_price" placeholder="최대 가격"/>
								<button 
								class="price_range_button" 
								onclick="getProductByfilter($('span.selected_category').data('category-no'), $('span.selected_category_detail').data('category-detail-no'))">적용</button>
							</td>
						</tr>
						<tr class="region_tr">
							<td class="td_title">동네</td>
							<td>
							<button class="choice_region" onclick="showRegionSearchTab()">선택</button>
							<input type="text" class="town_name"/>
							<input type="text" class="lat"/>
							<input type="text" class="lng"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	
		<!-- 상품 현재 시세 --> 
		<c:if test="${not empty requestScope.product_list and not empty requestScope.search_prod}">
		<div id="current_price" class="row">
			<div class="col-sm-4" id="average_price">
				<span class="sort">평균가격</span>
				<span class="price"><fmt:formatNumber value="${requestScope.prodcut_price_info.avg_price}" pattern="#,###" /> 원</span>
			</div>
			<div class="col-sm-4" id="high_price">
				<span class="sort">가장 높은 가격</span>
				<span class="price"><fmt:formatNumber value="${requestScope.prodcut_price_info.max_price}" pattern="#,###" /> 원</span>
			</div>
			<div class="col-sm-4" id="low_price" >
				<span class="sort">가장 낮은 가격</span>
				<span class="price"><fmt:formatNumber value="${requestScope.prodcut_price_info.min_price}" pattern="#,###" /> 원</span>
			</div>		
		</div>
		</c:if>
	
		
		<!-- 상품 정렬 방식 -->
		<div id="product_sort">
			<ul class="sort">
				<li class="sort">
					<button class="recent_sort sort" data-sort-type="recent">최신순</button>
				</li>
				<li class="sort">
					<button class="high_sort sort" data-sort-type="high">높은가격순</button>
				</li>
				<li class="sort">
					<button class="low_sort sort" data-sort-type="low">낮은가격순</button>
				</li>
			</ul> 
		</div>
	
		<c:if test="${not empty requestScope.product_list}">
		<!-- 상품 리스트  -->
		<div id="product_list" class="row">
		<c:forEach var="prod_list" items="${requestScope.product_list}" varStatus="status">
				<div id="card_wrap" class="col-md-6 col-lg-3">
					<div class="card">
						<!-- 상품 이미지 -->
						<img src="${prod_list.prod_img_name}" id="prod_img" class="card-img-top mb-3" onclick="goProductDetail(${prod_list.pk_product_no})" />
						
						
						<!-- 하트아이콘 -->
						<c:set var="heartCheck" value="false"/> <%-- 하트 체크 여부 변수 --%>
						<c:if test="${not empty requestScope.wish_list}">
							<c:forEach var="wish_list" items="${requestScope.wish_list}">
								<c:if test="${wish_list.fk_member_no == requestScope.fk_member_no and wish_list.fk_product_no == prod_list.pk_product_no}"> <!-- 회원번호 및 상품 번호 대조 -->
									<c:set var="heartCheck" value="true"/>
								</c:if>
							</c:forEach>
						</c:if>		
						
						<!-- 좋아요 체크된 경우 (채워진 하트) -->				
					    <c:choose>
							 <c:when test="${heartCheck eq 'true'}">
							     <span>
							         <i id="wish" class="fa-solid fa-heart" onclick="wishInsert(this, ${prod_list.pk_product_no}, ${requestScope.fk_member_no})"></i>
							     </span>
							 </c:when>
						<c:otherwise>
						<!-- 좋아요가 체크되지 않은 경우 (빈 하트) -->	
						     <span>
						         <i id="wish" class="fa-regular fa-heart" onclick="wishInsert(this, ${prod_list.pk_product_no}, ${requestScope.fk_member_no})"></i>
						     </span>
						</c:otherwise>
						</c:choose>
						
						
						<div class="card-body" onclick="goProductDetail(${prod_list.pk_product_no})">
							<!-- 상품 제목 -->
							<div class="product_title">
								<span class="product_title">${prod_list.product_title}</span>
							</div>
							
							<!-- 상품 가격 -->
							<div class="product_price">
								<span class="product_price"><fmt:formatNumber value="${prod_list.product_price}" pattern="#,###" /> 원</span>
							</div>
							
							<!-- 동네 및 등록 일자 -->
							<div class="product_regdate">
								<span class="product_town">${prod_list.region_town}</span>
								<span class="bar">|</span>
								<span class="product_time" data-date="${prod_list.product_regdate}"></span>
							</div>
						</div>			
					</div>
				</div>
		</c:forEach>
		</div>
		</c:if>
		
		<!-- 상품이 없는 경우에 -->
		<c:if test="${empty requestScope.product_list}"> 
			<div id="is_no_product">
				<span>상품 검색 결과가 없습니다.</span>
			</div>
		</c:if>

	</div>
</div>




<jsp:include page="../tab/tab.jsp">
	<jsp:param name="tabTitle" value="" />
</jsp:include>

<jsp:include page=".././footer/footer.jsp"></jsp:include>



<script>
	$(document).ready(function(){
		
		
		$("tr.tr_second").hide(); // 처음에 하위 카테고리 테이블 숨기기
		
		// 상품 등록일자 계산 해주기
	    $("span.product_time").each(function() {
	        const product_reg_date = $(this).attr('data-date'); // 등록일
	        const time = timeAgo(product_reg_date); 	  		// 함수 통해 시간 형식 변환
	        $(this).text(time);								    // 텍스트로 출력
	    }); // end of $("span.product_time").each(function()
		
		
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
		}); // end of $("button.plus_minus").click(function(e)
				
				
		
		// 상위 카테고리 클릭 시	
		$("li.category").click(function(){
			
			const category_no = $(this).data("category-no") // 클릭한 상위 카테고리 번호 가져오기
			getProductByfilter(category_no, "");			// 카테고리에 따른 상품 출력
			
			
		}); // end of category_li.click(function()
		
				

		// 하위 카테고리 클릭 시
		$("li.category_detail").click(function(){
			
			const category_datail_no = $(this).data("categorydetail-no"); // 클릭한 하위 카테고리 번호 가져오기
			const category_no = $(this).data("parent-no")				  // 클릭한 하위 카테고리 번호에 대한 상위 카테고리 번호 가져오기
			getProductByfilter(category_no, category_datail_no); 		  // 카테고리에 따른 상품 출력
			
		}); // end of category_detail_li.click(function()
		
				
		// 상위 카테고리명 텍스트 클릭하는 경우
		$("span.selected_category").click(function(){
			const category_no = $(this).data("category-no") // 클릭한 상위 카테고리 번호 가져오기
			getProductByfilter(category_no, "");			// 카테고리에 따른 상품 출력	
		});	
		
		
		// 하위 카테고리명 텍스트 클릭하는 경우
		$("span.selected_category_detail").click(function(){

			const category_detail_no = $(this).data("category-detail-no"); 			// 클릭한 하위 카테고리 번호 가져오기
		    const category_no = $("span.selected_category").data("category-no"); 	// 상위 카테고리 번호를 data 속성에서 가져오기
			getProductByfilter(category_no, category_detail_no);				    // 카테고리에 따른 상품 출력	
		});	
		
		
	    
	    $("button.sort").click(function() {
	        // 모든 버튼에서 'selected' 클래스 제거
	        $("button.sort").removeClass("selected");

	        // 클릭된 버튼에 'selected' 클래스 추가
	        $(this).addClass("selected");

	        // 필터 함수 호출
	        getProductByfilter($('span.selected_category').data('category-no'), $('span.selected_category_detail').data('category-detail-no'));
	    });
				
								
		// 검색 필터에 값들 유지시키기 위한 //		
	    // URL에서 카테고리 파라미터를 가져오기
	    const url_params = new URLSearchParams(window.location.search);
	    const category_no = url_params.get('category_no'); 				 // 상위 카테고리 번호
	    const category_detail_no = url_params.get('category_detail_no'); // 하위 카테고리 번호
	
	    const min_price = url_params.get('min_price');					 // 최소가격
	    const max_price = url_params.get('max_price');					 // 최대가격

	    const sort_type = url_params.get('sort_type');					 // 정렬 방식
	    
	    // 상위 카테고리 상태 복원
	    if (category_no) {
	        const category_name = $("li.category[data-category-no='" + category_no + "']").text();  	// 상위 카테고리명
	        $("span.selected_category").text(" > " + category_name).data("category-no", category_no);  	// 상위 카테고리명 표시 및 상위 카테고리 번호 데이터 넣어주기

	        $("li.category_detail").hide();  // 전체 하위 카테고리 숨기기
	        $("li.category_detail[data-parent-no='" + category_no + "']").show();  // 해당 상위 카테고리의 하위 카테고리만 보이기
	    	
	        $("li.category").hide(); // 상위 카테고리들 숨기기
	        $("tr.tr_second").show(); // 하위 카테고리 테이블 보여주기
	        $("i.plus_minus").removeClass("fa-plus").addClass("fa-minus"); // 아이콘 - 유지
	    }

	    // 하위 카테고리 상태 복원
	    if (category_detail_no) {
	        const category_detail_name = $("li.category_detail[data-categorydetail-no='" + category_detail_no + "']").text();  	   // 하위 카테고리명
	        $("span.selected_category_detail").text(" > " + category_detail_name).data("category-detail-no", category_detail_no);  // 하위 카테고리명 표시 및 하위 카테고리 번호 데이터 넣어주기
	        $("tr.tr_second").show(); // 하위 카테고리 테이블 보여주기
	        $("i.plus_minus").removeClass("fa-plus").addClass("fa-minus"); // 아이콘 - 유지
	    }
	    
	    
	    // 최소 가격 
	    if (min_price) {
	        $("input.min_price").val(decodeURIComponent(min_price));
	    }
	    // 최대 가격
	    if (max_price) {
	        $("input.max_price").val(decodeURIComponent(max_price));
	    }
	    
	    // 정렬 방식
	    if (sort_type) {
	        // 기존에 선택된 버튼을 제거하고, 새로 선택된 버튼에 클래스를 추가
	        $("button[data-sort-type]").removeClass("selected");
	        $("button[data-sort-type='" + sort_type + "']").addClass("selected");
	    }
	    
	    	
	}); // end of $(document).ready(function(){

		
		
	// Function Declaration---------------------------------
	
	
 	// 필터로 해당 상품 조회해오기 (검색어포함)
	function getProductByfilter(category_no, category_detail_no) {
		
	    let search_prod = encodeURIComponent("${requestScope.search_prod}");     // 검색어
	    let min_price = encodeURIComponent($("input.min_price").val().trim());   // 최소가격
	    let max_price = encodeURIComponent($("input.max_price").val().trim());   // 최소가격
	    
	    let sort_type = $("button.selected").data("sort-type"); 				 // 클릭한 정렬 유형의 값 가져오기

	    
	    let url = "<%= ctxPath %>/product/prodlist";
	   	// + search_prod + "&category_no=" + category_no + "&category_detail_no=" + category_detail_no +"&min_price=" + min_price + "&max_price=" + max_price;
	 	
	   	// 첫 번째 파라미터는 ?로 시작
		let isFirstParam = true;
	   	
	   	// 검색어가 있을 때만 URL에 추가
	    if (search_prod) {
	        url += "?search_prod=" + search_prod;
	        isFirstParam = false;
	    }
			
	    // 각 필터 값이 있으면 url 추가 없으면 공백 처리
	    if (category_no) {
	        url += (isFirstParam ? '?' : '&') + "category_no=" + category_no;
	        isFirstParam = false;
	    }
	    if (category_detail_no) {
	        url += (isFirstParam ? '?' : '&') + "category_detail_no=" + category_detail_no;
	        isFirstParam = false;
	    }
	    if (min_price) {
    		url += (isFirstParam ? '?' : '&') + "min_price=" + min_price;
    		isFirstParam = false;
		} 
	    if (max_price) {
	        url += (isFirstParam ? '?' : '&') + "max_price=" + max_price;
	        isFirstParam = false;
	    }
	    if (sort_type) {
	        url += (isFirstParam ? '?' : '&') + "sort_type=" + sort_type;
	        isFirstParam = false;
	    }
	    
	    location.href = url;
	    
	} // end of function getProductByCategory(category_no, category_detail_no)
	
	
	
	// 상품 상세 페이지로 이동
	function goProductDetail(pk_product_no) {
		location.href = "<%= ctxPath%>/product/prod_detail/" + pk_product_no;
	}
	

	

	// 하트 모양(좋아요) 클릭한 경우
	function wishInsert(e, product_no, member_no) {
		
		if(member_no) { // 로그인한 경우라면
			$.ajax({
				url:"<%= ctxPath %>/product/wish_insert",
				type:"post",
				data: {"fk_product_no": product_no,
					   "fk_member_no": member_no},
				success:function(response) {
					if($(e).hasClass("fa-regular")) {
				        $(e).removeClass("fa-regular").addClass("fa-solid"); // 하트 채우기
				        showAlert('success', '관심상품에 추가하였습니다.');
					} 
					else {
						$(e).removeClass("fa-solid").addClass("fa-regular"); // 하트 비우기
						showAlert('error', '관심상품에서 삭제하였습니다.');
					}	
				},
				error: function(request, status, error){ 
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }	
			}); 
		} 
		else {
			showAlert('error', '로그인 후 이용 가능합니다.');
		}
		
	} // end of function wishInsert()
	
	
	// 등록일 계산 해주는 함수
	function timeAgo(reg_date) {
	    const now = new Date(); 					 // 현재 시간
	    const product_reg_date = new Date(reg_date); // 상품 등록일
	    
	    // console.log("현재 시간:", now);
	    // console.log("상품 등록일:", product_reg_date);

	    const second = Math.floor((now - product_reg_date) / 1000); // 두 날짜 차이를 초 단위로 계산
	    const minute = Math.floor(second / 60);				        // 두 날짜 차이를 분 단위로 계산
	    const hour = Math.floor(minute / 60);				   		// 두 날짜 차이를 시간 단위로 계산
	    const day = Math.floor(hour / 24);					   		// 두 날짜 차이를 일 단위로 계산
	
	   
	    if (minute < 1) {
	        return "방금 전";
	    } 
	    else if (minute < 60) {
	        return minute + "분 전";
	    } 
	    else if (hour < 24) {
	        return hour + "시간 전";
	    } 
	    else if (day < 30) {
	        return day +"일 전";
	    } 
	    else {
	        return "오래 전";
	    }
	} // end of function timeAgo(reg_date)
	
	
	
	// 지역 선택 창 불러오기
	function showRegionSearchTab() {
		$.ajax({
			url : "<%=ctxPath%>/product/regionlist_lat_lng",
			type : "get",
			success : function(html) {
				// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
				openSideTab(html);
			},
			 error: function(request, status, error){
				 console.log(request.responseText);
				 
				 // 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
				 let response = request.responseText;
				 let message = response.substr(0, 4) == "msg/" ? response.substr(4) : "";
				 
			     showAlert("error", message);
			     
			     // 사이드 탭 닫기
			     closeSideTab();
			}
		});
	}
	
	
	

</script>