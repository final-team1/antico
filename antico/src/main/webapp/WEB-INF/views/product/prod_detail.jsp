<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<% String ctxPath = request.getContextPath(); %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}" />

<%-- 상품 map --%>
<c:set var="product_map" value="${requestScope.product_map}" />

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="fk_member_no" value="${requestScope.fk_member_no}" />

<jsp:include page=".././header/header.jsp"></jsp:include>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<style type="text/css">

div#container {
	width: 60%;
	margin: 0 auto;
} 

div#prod_info_container {
	text-align: center;
	justify-content: space-between;
	width: 100%;
	margin-top: 80px;
}

div.img_div {
    width: 100%; /* 부모에 맞춰 크기 조정 */
    position: relative;
    padding-bottom: 100%; /* 1:1 비율 유지 */
}

img.prod_img {
    object-fit: cover; /* 이미지가 부모의 크기에 맞춰지도록 자르기 */
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    display: block; /* 여백 제거 */
    border-radius: 6px;
}


/* 캐러셀 화살표 아이콘 */
a.carousel-control-prev {
    margin-right: 40px;
   	background: none !important;
    opacity: 1 !important;
}

a.carousel-control-next {
	margin-left: 40px;
	background: none !important;
    opacity: 1 !important;
}


span.carousel-control-prev-icon,
span.carousel-control-next-icon {
    filter: brightness(0.7); /* 밝은 회색 */
}

a.carousel-control-prev:hover span.carousel-control-prev-icon,
a.carousel-control-next:hover span.carousel-control-next-icon {
    filter: brightness(0); /* 검정색 */
}


div#prod_info {
	margin-left: 50px;
}

div#category_info {
	text-align: left;
}

span.prod_category {
	cursor: pointer;
	font-size: 10pt;
}

span.greater {
	font-size: 10pt;
}

div#title_info {
	display: flex;
	margin-top: 10px;
	justify-content: space-between;
	align-items: center;
	
}

span#product_title {
	font-size: 16pt;
	font-weight: 500;
	/* 말줄임 처리 */
	width: 95%;
	display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: left;
}

i#share {
	font-size: 12pt;
	text-align: right;
	cursor: pointer;
}

div#price_info {
	text-align: left;
	font-size: 18pt;
	font-weight: bold;
	margin-top: 10px;
}


div#time_view_info {
	text-align: left;
	margin-top: 10px;
	font-size: 10pt;
	color: #999999;
}

div#status_region_info,
div#buyer_setting {
	margin-top: 20px;
	width: 100%;
	height: 80px;
	border: solid 1px #dee2e6;
	border-radius: 6px;
	display: flex;
	flex-direction: column;
    justify-content: center;
}

div#review_container {
	margin-top: 40px;
	width: 100%;
	height: 80px;
	border: solid 1px #dee2e6;
	border-radius: 6px;
	display: flex;
	flex-direction: column;
    justify-content: center;
}

ul#status_region_info_ul,
ul#buyer_setting_ul,
ul#review_container_ul {
	list-style-type: none;
	padding-left: 0px;
	margin-bottom: 0px;
	display: flex;
}

li.status, li.region, li.sale_status, li.extra,
li.reg_update, li.prod_upate, li.sale_status_upate, li.prod_delete,
li.review_cnt {
	display: flex; 
	flex-direction: column;
	align-items: center;
	width: 100%;
}

li.reg_update, li.prod_upate, li.sale_status_upate, li.prod_delete {
	cursor: pointer;
}

li.sale_status_upate {
	position: relative;
}

li.bar {
	border: solid 1px #dee2e6;
}

span.status_title, span.region_title, span.sale_status_title, span.extra_title {
	font-size: 8pt;
	color: #999999;
}

span.reg_update_title, span.prod_upate_title, span.sale_status_upate_title, span.prod_delete_title,
span.review_cnt_title {
	font-size: 10pt;
	color: #999999;
}

span.status, span.region, span.sale_status, span.extra,
span.reg_update, span.prod_upate, span.sale_status_upate, span.prod_delete,
span.review_cnt {
	font-size: 10pt;
	font-weight: bold;
}

span.sale_status {
	color: #0DCC5A;
}

span.extra {
	color: red;
}


div#button {
	margin-top: 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

i#wish {
	font-size: 20pt;
	margin-right: 20px;
	color: #0DCC5A;
}

button#chat {
	border: solid 1px #cccccc;
	border-radius: 6px;
	background-color: white;
	color: black;
	height: 50px;
	width: 100%;
	margin-right: 20px;
}

button#buy {
	border: none;
	border-radius: 6px;
	background-color: black;
	color: white;
	height: 50px;
	width: 100%;
}


button#booking {
	border: none;
	border-radius: 6px;
	background-color: black;
	color: white;
	height: 50px;
	width: 100%;
}


button#join_bidding {
	border: none;
	border-radius: 6px;
	background-color: black;
	color: white;
	height: 50px;
	width: 100%;
}


div#detail_info_container {
	justify-content: space-between;
	width: 100%;
	margin-top: 80px;
	display: flex;
	gap: 70px; 
}


div#prod_detail {
	height: auto; 	   	   /* 높이 설정 (필요에 따라 조정) */
    overflow-y: auto; 	   /* 세로 스크롤 활성화 */
    word-wrap: break-word; /* 긴 단어 줄바꿈 */
    flex: 1; 			   /* 남은 공간을 차지 */
}

span.detail_title {
	text-align: left;
	font-size: 16pt;
	font-weight: 500;
}

div#prod_contents {
	width: 100%;
	height: 800px;
	overflow: hidden;
}

p.contents {
	white-space: normal;   /* 자동 줄바꿈 허용 */
    word-wrap: break-word; /* 긴 단어 줄바꿈 */
    line-height: 1.5;
}


div#seller_detail {
	flex: 1; /* 남은 공간을 차지 */
}

span.seller_title {
	text-align: left;
	font-size: 16pt;
	font-weight: 500;
}

a#member_name {
	text-decoration: none;
	color: black;
	font-size: 20pt;
	font-weight: bold
}

/* 판매자 이름 및 등급 표시 부분 */
div#member_name_role {
	width: 100%; 
	display: flex; 
	justify-content: space-between; 
	align-items: center;
}

span.member_role {
	font-size: 10pt;
	font-weight: bold;
}

/* 등급 게이지 */
div#bar {
	width: 100%;
	background-color: #ddd;
	height: 8px;
	border-radius: 4px;
	margin: 5px 0;
	text-align: right;
}

div#bar_guage {
	height: 100%;
	border-radius: 4px;
	margin-bottom: 5px;
}

span#score {
	font-size: 10pt;
}

/* 다른 상품 부분 */
div#other_product{
	width: 100%;
	display: flex; 
	margin-top: 20px; 
	gap: 10px;
}

div#other_product_img_container {
	width: 50%;
	display: flex;
}

div#other_product_img_div {
	width: 100%;
	cursor: pointer;
}

img#other_product_img {
	obeject-fit: cover; 
	width: 100%;
	border-radius: 6px;
	aspect-ratio: 1/1;
}

div.ohter_product_title {
	margin-top: 5px;
	height: 50px; 
	text-align: left;
	font-weight: 500;
}


span.ohter_product_title{
	width: 95%;
	display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: left;
}

div.ohter_product_price {
	height: 50px; 
	text-align: left;
	font-weight: bold;
}





/* 상태변경 dropdown 관련 부분 */
ul.sale_status_dropdown {
 	display: none;
    position: absolute;
    background: white;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    padding: 0px 10px;
    list-style: none;
	min-width: 100%;
    margin-top: 50px;
    font-size: 10pt;
    font-weight: bold;
}

li.sale_status_update {
	position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    width: 100%;
}

li.sale_status_upate_li {
    padding: 8px;
    cursor: pointer;
    width: 100%;
}

li.sale_status_upate_li:hover {
    background: #f0f0f0;
}


/* 구매완료 관련 overlay */
div.sold_out_overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.3); /* 반투명한 검은색 */
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    z-index: 5; 	 				/* 다른 요소보다 위에 배치 */
    max-width: 100%; 				/* 최대 크기 제한 */
    border-radius: 6px;
}

span.sold_out_text {
    padding: 10px 20px;
}




/* 모달 관련 부분  */
/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 배경 투명화 */
	justify-content: center;
	align-items: center;
}

.modal_content {
	background: white;
	padding: 20px;
	display: flex;
	flex-direction: column;
	gap: 10px;
	text-align: center;
}

.share_btn_arrow {
	justify-content: center;
	align-items: center;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 8px;
	background: white;
	cursor: pointer;
	font-size: 16px;
	transition: background 0.3s;
}

.share_btn_arrow:hover {
	background: #f0f0f0;
}

.share_option {
	border: solid 0px red;
	background-color: white;
}

.close_btn { /* 공유하기 닫기버튼 */
	width: 100%;
	height: 48px;
	background-color: #000;
	color: #fff;
	border-radius: 3px;
	display: flex;
	justify-content: center;
	align-items: center;
}



</style>


<div id="container">
	<div id="prod_info_container" class="row">
		<div id="sale_stauts_update_data" class="col-md p-0">
			<c:if test="${not empty requestScope.product_img_list and fn:length(requestScope.product_img_list) > 1}">
			   <div id="carouselExampleIndicators" class="carousel slide" data-interval="false">
			        <div class="carousel-inner">
			            <c:set var="is_first_image" value="false"/> <%-- 대표 이미지 활성화 여부 --%>
			            
			            <c:forEach var="img_list" items="${requestScope.product_img_list}">
			                <c:choose>
			                    <%-- 대표 이미지 (첫 번째 슬라이드) --%>
			                    <c:when test="${img_list.prod_img_is_thumbnail == 1}">
			                        <div class="carousel-item active img_div" >
			                            <img src="${img_list.prod_img_name}" class="d-block prod_img" />
			                            		
				                        <%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 1}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">예약중</span>
				                            </div>
				                        </c:if>					                            		
			                            						                            
			                            <%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 2}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">판매완료</span>
				                            </div>
				                        </c:if>
				                        
			                            <%-- 경매시작 전 상품이면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 3}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">경매 시작 전</span>
				                            </div>
				                        </c:if>				                        
				                        
			                            <%-- 경매중 상품이면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 4}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">경매중</span>
				                            </div>
				                        </c:if>					                     			                        									                            
			                        </div>
			                        <c:set var="is_first_image" value="true"/>			                        
			                    </c:when>
			                    
			                    
			                    
			                    <%-- 일반 이미지 (대표 이미지가 이미 설정되었다면 일반 슬라이드) --%>
			                    <c:when test="${img_list.prod_img_is_thumbnail == 0}">
			                        <div class="carousel-item ${is_first_image ? '' : 'active'} img_div">
			                            <img src="${img_list.prod_img_name}" class="d-block prod_img" />

			                            <%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 1}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">예약중</span>
				                            </div>
				                        </c:if>	
			                            
			                            <%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 2}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">판매완료</span>
				                            </div>
				                        </c:if>
				                        
			                            <%-- 경매시작 전 상품이면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 3}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">경매 시작 전</span>
				                            </div>
				                        </c:if>				                        
				                        
			                            <%-- 경매중 상품이면 오버레이 추가 --%>
				                        <c:if test="${product_map.product_sale_status == 4}">
				                            <div class="sold_out_overlay">
				                                <span class="sold_out_text">경매중</span>
				                            </div>
				                        </c:if>					                        
			                        </div>	
			                        <c:set var="is_first_image" value="true"/>                 	
			                    </c:when>     	                    
			                </c:choose>
			            </c:forEach>
			        </div>
			
			        <%-- 이전/다음 버튼 --%>
			        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			        </a>
			        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			            <span class="carousel-control-next-icon" aria-hidden="true"></span>
			        </a>
			   </div>
			</c:if>
			
			<%-- 이미지가 1개일 경우, 캐러셀을 보여주지 않음 --%>
		    <c:if test="${not empty requestScope.product_img_list and fn:length(requestScope.product_img_list) == 1}">
		    	<div class="img_div">
		       		<img src="${requestScope.product_img_list[0].prod_img_name}" class="d-block prod_img" />
		       		
                       <%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
                       <c:if test="${product_map.product_sale_status == 1}">
                           <div class="sold_out_overlay">
                               <span class="sold_out_text">예약중</span>
                           </div>
                       </c:if>				       		
		       		
    					<%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
                       <c:if test="${product_map.product_sale_status == 2}">
                           <div class="sold_out_overlay">
                               <span class="sold_out_text">판매완료</span>
                           </div>
                       </c:if>
                       
                       <%-- 경매시작 전 상품이면 오버레이 추가 --%>
                       <c:if test="${product_map.product_sale_status == 3}">
                           <div class="sold_out_overlay">
                               <span class="sold_out_text">경매 시작 전</span>
                           </div>
                       </c:if>				                        
                       
                       <%-- 경매중 상품이면 오버레이 추가 --%>
                       <c:if test="${product_map.product_sale_status == 4}">
                           <div class="sold_out_overlay">
                               <span class="sold_out_text">경매중</span>
                           </div>
                       </c:if>	                       
		       		
		        </div>
		    </c:if> 
		</div>
	
		
		
		<div id="prod_info" class="col-md p-0">
			<div id="category_info">
				<span class="prod_category" onclick="location.href='<%= ctxPath%>/index'" >홈</span>
				<span class="greater">　>　</span>
				<span class="prod_category" onclick="location.href='<%= ctxPath%>/product/prodlist?category_no=${product_map.fk_category_no}'">${product_map.category_name}</span>
				<span class="greater">　>　</span>
				<span class="prod_category" onclick="location.href='<%= ctxPath%>/product/prodlist?category_no=${product_map.fk_category_no}&category_detail_no=${product_map.fk_category_detail_no}'">${product_map.category_detail_name}</span>
			</div>
			<div id="title_info">
				<span id="product_title">${product_map.product_title}</span>
				<!-- 공유 아이콘 -->
				<span><i id="share" class="fa-solid fa-arrow-up-right-from-square" onclick="openShareModal()"></i></span>
			</div>
			<div id="price_info">	
				<span><fmt:formatNumber value="${product_map.product_price}" pattern="#,###" /> 원</span>
			</div>
			<div id="time_view_info">
				<span class="product_time" data-date="${product_map.product_update_date}"></span>
				<span>·</span>
				<span>조회 <fmt:formatNumber value="${product_map.product_views}" pattern="#,###" /></span>
			</div>
			<div id="status_region_info">
				<ul id="status_region_info_ul">
					<li class="status">
						<span class="status_title">제품상태</span>
						<c:if test="${product_map.product_status == 0}">
							<span class="status">중고</span>
						</c:if>
						<c:if test="${product_map.product_status == 1}">
							<span class="status">새상품</span>
						</c:if>
					</li>
					
					<li class="bar"></li>
					
					<li class="region">
						<span class="region_title">희망거래동네</span>
						<span class="region">${product_map.region_town}</span>
					</li>
					
					<!-- 일반 판매 상품이면 -->
					<c:if test="${product_map.product_sale_type == 0}">
					
						<li class="bar"></li>
					
						<li id="sale_stauts_update_data2" class="sale_status">
							<span class="sale_status_title">판매상태</span>
							<c:if test="${product_map.product_sale_status == 0}">
								<span class="sale_status">판매중</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 1}">
								<span class="sale_status">예약중</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 2}">
								<span class="sale_status">판매완료</span>
							</c:if>
						</li>
						
						<li class="bar"></li>
						
						<li class="extra">
							<span class="extra_title"></span>
							<span class="extra"></span>
						</li>
					</c:if>
					
					
					<!-- 경매 상품이면 -->
					<c:if test="${product_map.product_sale_type == 1}">
					
						<li class="bar"></li>
					
						<li id="sale_stauts_update_data2" class="sale_status">
							<span class="sale_status_title">경매상태</span>
							<c:if test="${product_map.product_sale_status == 3}">
								<span class="sale_status">경매 시작 전</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 4}">
								<span class="sale_status">경매중</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 5}">
								<span class="sale_status">경매완료</span>
							</c:if>
						</li>
						
						<li class="bar"></li>
						
						<li class="extra" >
							<c:if test="${product_map.product_sale_status == 3}">
								<span class="extra_title">경매시작시간</span>
								<span class="extra">${product_map.auction_startdate}</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 4}">
								<span class="extra_title">경매마감시간</span>
								<span class="extra">${product_map.auction_enddate}</span>
							</c:if>
						</li>
						
					</c:if>									
					
				</ul>
			</div>
			
			
			<!-- 판매자 본인의 상품이거나 일반 판매만 보여진다.  -->
			<c:if test="${product_map.fk_member_no == fk_member_no and product_map.product_sale_type == 0}">
				<div id="buyer_setting">
					<ul id="buyer_setting_ul">
						<li class="reg_update" onclick="regUpdate('${product_map.pk_product_no}')">
							<span class="reg_update_title"><i class="fa-solid fa-turn-up"></i></span>
							<span class="reg_update">위로올리기</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="sale_status_upate dropbtn">
							<span class="sale_status_upate_title"><i class="fa-regular fa-circle-check"></i></span>
							<span class="sale_status_upate sale_status_text">상태변경</span>
							
							<!-- 드롭다운 메뉴 -->
					        <ul class="sale_status_dropdown">
					            <li id="on_sale" class="sale_status_upate_li" data-status="0">판매중</li>
					            <li id="booking" class="sale_status_upate_li" data-status="1">예약중</li>
					            <li id="sold_out" class="sale_status_upate_li" data-status="2">판매완료</li>
					        </ul>
							
						</li>
						
						
						<li class="bar"></li>
						
						<li class="prod_upate" onclick="prodUpdate('${product_map.pk_product_no}')">
							<span class="prod_upate_title"><i class="fa-solid fa-pen-to-square"></i></span>
							<span class="prod_upate">상품수정</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="prod_delete" onclick="prodDelete('${product_map.pk_product_no}')">
							<span class="prod_delete_title"><i class="fa-regular fa-trash-can"></i></span>
							<span class="prod_delete">상품삭제</span>
						</li>
						
					</ul>
				</div>
			</c:if>				
				
			<div id="button">
				<!-- 판매자 본인 상품이 아니거나 구매완료 및 경매완료가 아닌 상품이라면 -->
				<c:if test="${(product_map.fk_member_no ne fk_member_no) and (product_map.product_sale_status != 2) and (product_map.product_sale_status != 5)}">
					<c:set var="heartCheck" value="false"/> <%-- 하트 체크 여부 변수 --%>
					<c:if test="${not empty requestScope.wish_list}">
						<c:forEach var="wish_list" items="${requestScope.wish_list}">
							<c:if test="${wish_list.fk_member_no == fk_member_no and wish_list.fk_product_no == product_map.pk_product_no}"> <!-- 회원번호 및 상품 번호 대조 -->
								<c:set var="heartCheck" value="true"/>
							</c:if>
						</c:forEach>
					</c:if>	
					
					<!-- 좋아요 체크된 경우 (채워진 하트) -->				
				    <c:choose>
						 <c:when test="${heartCheck eq 'true'}">
						     <span>
						         <i id="wish" class="fa-solid fa-heart" onclick="wishInsert(this, ${product_map.pk_product_no}, ${product_map.fk_member_no}, ${fk_member_no})"></i>
						     </span>
						 </c:when>
					<c:otherwise>
					<!-- 좋아요가 체크되지 않은 경우 (빈 하트) -->	
					     <span>
					         <i id="wish" class="fa-regular fa-heart" onclick="wishInsert(this, ${product_map.pk_product_no}, ${product_map.fk_member_no}, ${fk_member_no})"></i>
					     </span>
					</c:otherwise>
					</c:choose>
				</c:if>
				
				<!-- 판매자 본인 상품이 아니거나 구매완료 및 경매완료가 아닌 상품이라면 -->
				<c:if test="${(product_map.fk_member_no ne fk_member_no) and (product_map.product_sale_status != 2) and (product_map.product_sale_status != 5)}">
					<!-- 일반 상품이라면  -->
					<c:if test="${product_map.product_sale_type == 0}">
						<!-- 판매중이면 -->
						<c:if test="${product_map.product_sale_status == 0}">
							<button id="chat">채팅하기</button>
							<button id="buy" onclick="payment()">구매하기</button>
						</c:if>
						
						<!-- 예약중이라면 -->
						<c:if test="${product_map.product_sale_status == 1}">
							<button id="booking" disabled>해당 상품은 현재 예약중입니다.</button>
						</c:if>
					</c:if>
					
					<!-- 경매 상품이라면 -->
					<c:if test="${product_map.product_sale_type == 1}">
						<button id="join_bidding" onclick="">경매 참여하기</button>
					</c:if>
				</c:if>
				
			</div>
				
		</div>	
	</div>	
	
	<div id="detail_info_container" class="row">	
		<div id="prod_detail" class="col-md-8 p-0">
			<div>
				<span class="detail_title">상품 정보</span>
				<hr>
			</div>
			
			<div id="prod_contents">
				<p class="contents">${product_map.product_contents}</p>
			</div>
		</div>
		
	    <div id="seller_detail" class="col-md-4 p-0">	    
	    	<div>
				<span class="seller_title">판매자 정보</span>
				<hr>
			</div>
			<div id="member_name_role">
				<%-- 판매자명 --%>
				<a id="member_name" href="${pageContext.request.contextPath}/mypage/mypagemain/${product_map.fk_member_no}">${product_map.member_name}</a>
				
				<%-- 판매자 등급 --%>
				<c:if test="${product_map.member_role == 0}">
					<span class="member_role" style="color: #b87333;">브론즈</span>
				</c:if>
				<c:if test="${product_map.member_role == 1}">
					<span class="member_role" style="color: #c0c0c0;">실버</span>
				</c:if>
				<c:if test="${product_map.member_role == 2}">
					<span class="member_role" style="color: #ffd700;">골드</span>
				</c:if>
				<c:if test="${product_map.member_role == 3 or product_map.member_role ==4}">
					<span class="member_role" style="color: red;" >관리자</span>
				</c:if>						
			</div>
			
			<%-- 게이지 --%>
			<div id="bar">
				<c:if test="${product_map.member_role == 0}">
					<div id="bar_guage" style="width: ${product_map.member_score/10}%; background-color: #b87333;"></div>
				</c:if>
				<c:if test="${product_map.member_role == 1}">
					<div id="bar_guage" style="width: ${product_map.member_score/10}%; background-color: #c0c0c0;"></div>
				</c:if>
				<c:if test="${product_map.member_role == 2}">
					<div id="bar_guage" style="width: ${product_map.member_score/10}%; background-color: #ffd700;"></div>
				</c:if>
				<c:if test="${product_map.member_role == 3 or product_map.member_role ==4}">
					<div id="bar_guage" style="width: ${product_map.member_score/10}%; background-color: red"></div>
				</c:if>
				<div id="score">					
					<span id="score">신뢰도 ${product_map.member_score}</span>
				</div>
			</div>
			
			<div id="review_container">
				<ul id="review_container_ul">
					<li class="review_cnt">
						<span class="review_cnt_title">거래량</span>
						<span class="review_cnt">1</span>
					</li>
					
					<li class="bar"></li>	

					<li class="review_cnt">
						<span class="review_cnt_title">후기</span>
						<span class="review_cnt">1</span>
					</li>
					
					<li class="bar"></li>	
					
					<li class="review_cnt">
						<span class="review_cnt_title">단골</span>
						<span class="review_cnt">1</span>
					</li>												
					
				</ul>
			</div>
			
			<%-- 다른 상품 --%>
			<div id="other_product">
				<c:forEach var="prod_one_member" items="${requestScope.product_list_one_member}" varStatus="status" begin="0" end="1">
					<div id="other_product_img_container">
						<div id="other_product_img_div" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${prod_one_member.pk_product_no}'">
							<img id="other_product_img" src="${prod_one_member.prod_img_name}">
							<div class="ohter_product_title">
								<span class="ohter_product_title">${prod_one_member.product_title}</span> 
							</div>
							<div>
								<c:if test="${prod_one_member.product_sale_status == 0}">
									<span class="sale_status">판매중</span>
								</c:if>
								<c:if test="${prod_one_member.product_sale_status == 1}">
									<span class="sale_status">예약중</span>
								</c:if>
								<c:if test="${prod_one_member.product_sale_status == 2}">
									<span class="sale_status">판매완료</span>
								</c:if>
								<c:if test="${prod_one_member.product_sale_status == 3}">
									<span class="sale_status">경매 시작 전</span>
								</c:if>
								<c:if test="${prod_one_member.product_sale_status == 4}">
									<span class="sale_status">경매중</span>
								</c:if>
								<c:if test="${prod_one_member.product_sale_status == 5}">
									<span class="sale_status">경매완료</span>
								</c:if>
							</div>
							<div class="ohter_product_price"><span><fmt:formatNumber value="${prod_one_member.product_price}" pattern="#,###" /> 원</span></div>
						</div>
					</div>
				</c:forEach>	
			</div> 	
		</div>
	</div>
</div>	


<!-- 상품 수정 페이지 이동을 위한 form -->
<form name="prodUpdateFrm">
   <input type="hidden" name="pk_product_no" />
   <input type="hidden" />
</form>	       



<!-- 공유 모달 -->
<div id="shareModal" class="modal">
	<div class="modal_content" style="width: 25%;">
		<h4 style="font-weight: bold;">공유하기</h4>
		<div style="width: 100%; display: flex; justify-content: center; align-items: center; gap: 20px;">
		    <button class="share_option" onclick="shareToInsta()">
		        <img src="https://dbdzm869oupei.cloudfront.net/img/sticker/preview/26354.png" width="64" height="64" style="border-radius: 50%;">
		    </button>
		    <button class="share_option" onclick="shareToKakao()">
		        <img src="https://blog.kakaocdn.net/dn/dMWSyr/btq5R2rw7Rf/3CyUtcWWWQkKVZDdKiQ46K/img.png" width="64" height="64" style="border-radius: 50%;">
		    </button>
		    <button class="share_option" onclick="copyUrl()">
		        <img src="https://beosyong.com/img/mypage_link.png" width="64" height="64">
		    </button>
		</div>
		<button class="close_btn" onclick="closeShareModal()" style="align-self: center;">닫기</button>
	</div>
</div>



<jsp:include page=".././footer/footer.jsp"></jsp:include>




<script>

	$(document).ready(function(){
		
		// 상품 등록일자 계산 해주기
	    $("span.product_time").each(function() {
	        const product_update_date = $(this).attr('data-date'); // 등록일
	        const time = timeAgo(product_update_date); 	  		   // 함수 통해 시간 형식 변환
	        $(this).text(time);								       // 텍스트로 출력
	    }); // end of $("span.product_time").each(function()	
	    		
	    		
	    // 상태 변경 dropdown 보여주기 관련 시작	
	    $("li.dropbtn").click(function(e) {
	        $("ul.sale_status_dropdown").toggle();  // 토글 기능
	        e.stopPropagation();  					// 이벤트 버블링 방지
	    });

	    $(document).click(function() {
	        $("ul.sale_status_dropdown").hide();  // 다른 곳 클릭 시 닫기
	    });
	 	// 상태 변경 dropdown 보여주기 관련 끝			
	    		
	    
	 	// 상태변경 dropdown 목록 클릭하는 경우
	 	$("li.sale_status_upate_li").click(function(){
	 		let sale_status_no = $(this).data("status"); // data-status 값 가져오기
	 		const pk_product_no ="${product_map.pk_product_no}";
	 		
			$.ajax({
				url:"<%= ctxPath %>/product/sale_status_update",
				type:"post",
				dataType: "json",
				data: {"sale_status_no": sale_status_no,
					   "pk_product_no": pk_product_no},
				success:function(response) {
					
					showAlert('success', '상품 상태가 업데이트 되었습니다.');
					// 해당 id 값 부분만 새로고침
					$('#sale_stauts_update_data').load(location.href + " #sale_stauts_update_data"); 
					$('#sale_stauts_update_data2').load(location.href + " #sale_stauts_update_data2");			    
	
				},
				error: function(request, status, error){ 
					errorHandler(request, status, error); 
	            },
			}); 
	        
	    }); // end of $("li.sale_status_upate_li").click(function()
	    		
	    		
	    		
	   	// 채팅 버튼 이벤트 등록
	   	$("button#chat").click(function() {
	   		const pk_product_no = "${product_map.pk_product_no}";
	   			
   			// 삭제 예정
   			if(pk_product_no == ""){
   				showAlert("error", "상품이 존재하지 않습니다.");
   				return;
   			}
   			
   			// 채팅방 생성 및 입장
   			$.ajax({
   				url : "${ctx_path}/chat/chatroom",
   				type : "post",
   				data : {
   					"pk_product_no" : pk_product_no
   				},
   				success : function(html) {
   					// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
   					openSideTab(html, "채팅");
   				},
   				error: function(request, status, error){
   					errorHandler(request, status, error);
   				}
   			});
	   	});
<<<<<<< HEAD
=======

		// 채팅 버튼 이벤트 등록
		$("button#join_bidding").click(function() {
			const pk_product_no = "${product_map.pk_product_no}";

			// 삭제 예정
			if(pk_product_no == ""){
				showAlert("error", "상품이 존재하지 않습니다.");
				return;
			}

			// 채팅방 생성 및 입장
			$.ajax({
				url : "${ctx_path}/auction/chatroom",
				type : "post",
				data : {
					"pk_product_no" : pk_product_no
				},
				success : function(html) {
					// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
					openSideTab(html, "경매");
				},
				error: function(request, status, error){
					errorHandler(request, status, error);
				}
			});
		});
>>>>>>> 753c43e (Merge branch 'dev' of https://github.com/wogurwogur/antico into dev)
		
		
	}); // end of $(document).ready(function()
	
			
	// Function Declaration---------------------------------
			
	
	// 등록일 계산 해주는 함수
	function timeAgo(update_date) {
	    const now = new Date(); 					 	   // 현재 시간
	    const product_update_date = new Date(update_date); // 상품 등록일
	    
	    // console.log("현재 시간:", now);
	    // console.log("상품 등록일:", product_reg_date);

	    const second = Math.floor((now - product_update_date) / 1000); // 두 날짜 차이를 초 단위로 계산
	    const minute = Math.floor(second / 60);				           // 두 날짜 차이를 분 단위로 계산
	    const hour = Math.floor(minute / 60);				   		   // 두 날짜 차이를 시간 단위로 계산
	    const day = Math.floor(hour / 24);					   		   // 두 날짜 차이를 일 단위로 계산
	
	   
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
	
	
	// 하트 모양(좋아요) 클릭한 경우
	function wishInsert(e, product_no, fk_member_no, member_no) {
		
		if(member_no) { // 로그인한 경우라면
			
			if(fk_member_no != member_no) { // 본인이 등록한 상품이 아닌 경우
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
						errorHandler(request, status, error); 
		            }	
				}); 
			}
			else { // 본인이 등록한 상품인 경우
				showAlert('error', '본인이 등록한 상품은 불가합니다.');
			}
		} 
		else { // 로그인 하지 않은 경우
			showAlert('error', '로그인 후 이용 가능합니다.');
		}
		
	} // end of function wishInsert()
	
	
	// "위로올리기" 클릭 시 상품 등록일자 업데이트 하기
	function regUpdate(product_no) {
		
		const prodcut_sale_status_no ="${product_map.product_sale_status}"; // 상품 상태값 가져오기
		
		if(prodcut_sale_status_no != 2) { // 구매완료된 상품이 아닌 경우만 위로올리기 가능함
			$.ajax({
				url:"<%= ctxPath %>/product/reg_update",
				type:"post",
				data: {"pk_product_no": product_no},
				success:function(response) {
				    
					showAlert('success', '해당 상품의 등록일이 업데이트 되었습니다.');
	
				},
				error: function(request, status, error){ 
					errorHandler(request, status, error); 
	            }	
			}); 
		} else {
			showAlert('error', '해당 상품은 이미 구매 완료된 상품입니다.');
		}
		
	} // end of function regUpdate(product_no)
	
	
	
	// "상품수정" 클릭 시 수정 페이지로 이동
	function prodUpdate(pk_product_no) {
		
		   const frm = document.prodUpdateFrm;
		   frm.pk_product_no.value = pk_product_no;
		   
		   frm.method = "post";
		   frm.action = "<%= ctxPath%>/product/update";
		   frm.submit();	
	} // end of function prodUpdate(product_no)
	

	
	// "상품삭제" 클릭 시 상품 삭제하기
	function prodDelete(product_no) {
	    Swal.fire({
	        title: "해당 상품을 정말로 삭제하시겠습니까?",
	        text: "상품이 삭제됩니다.",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonText: "확인",
	        cancelButtonText: "취소"
	    }).then((result) => {
		        if (result.isConfirmed) {
					$.ajax({
						url:"<%= ctxPath %>/product/delete",
						type:"post",
						data: {"pk_product_no": product_no},
						success:function(response) {
							showAlert('success', '해당 상품이 삭제되었습니다.');
							
							// 3초(3000ms) 후 메인 페이지로 이동
				            setTimeout(function() {
				                location.href = "${ctx_path}/index";
				            }, 3000);
							
						},
						error: function(request, status, error){ 
							 errorHandler(request, status, error); 	
			            }	
					});
		     	}
	    	});  
	} // end of function prodDelete(product_no)
	
	
	
	// --- 공유하기 모달 관련 --- //
	//모달 열기
	function openShareModal() {
		document.getElementById("shareModal").style.display = "flex";
	}

	//모달 닫기
	function closeShareModal() {
		document.getElementById("shareModal").style.display = "none";
	}
	
	// URL 복사
	function copyUrl() {
		let url = '';
		let textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		url = window.document.location.href;
		textarea.value = url;
		textarea.select();
		document.execCommand("copy");
		document.body.removeChild(textarea);
		showAlert('success', 'URL 복사완료');
	}
	
	// 인스타공유
	function shareToInsta() {
		window.open("https://www.instagram.com/accounts/login/", "_blank");
	}
	
	
	// 카카오톡 공유하기 openApi 
    Kakao.init('${requestScope.kakao_api_key}');
    // console.log(Kakao.isInitialized()); // 초기화 확인

    function shareToKakao() {
        let currentURL = window.location.href; // 현재 페이지 URL 가져오기

        Kakao.Link.sendDefault({
            objectType: 'text', // 텍스트 형식
            text: '이 링크를 확인해 보세요!\n' + currentURL, // 공유할 URL
            link: {
                mobileWebUrl: currentURL,
                webUrl: currentURL
            },
        });
    }
	
    
    
 	// 구매하기 클릭시
	function payment() {
		
 		const pk_product_no = "${product_map.pk_product_no}";
 		const fk_member_no = "${fk_member_no}";
 		
 		// 로그인 한 회원이 아닌 경우
 		if(fk_member_no == "") {
 			showAlert('error', '구매하기는 로그인 후 이용가능합니다.');
 			return;
 		}
 		
 		// 상품이 존재하지 않는 경우
 		if(pk_product_no == "") {
 			showAlert('error', '해당 상품이 존재하지 않습니다.');
 			return;
 		}
 		
		const tabTitle = "구매하기";
	      $.ajax({
	         url : "<%=ctxPath%>/trade/show_payment",
	         type: "post",
 			 data: {"pk_product_no":pk_product_no},
	         success : function(html) {
	            openSideTab(html, tabTitle);
	         },
	         error : function(request, status, error) {
	        	errorHandler(request, status, error);
	         }
	      });
		
 			
 		
	}
    
</script>