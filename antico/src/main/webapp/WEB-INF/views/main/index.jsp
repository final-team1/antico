<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<!-- CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />


<!-- JS -->

<style type="text/css">


/* 대서리 메뉴용 */
.table th, .table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    word-break: break-word; /* 글자가 길면 자동 줄 바꿈 */
    white-space: normal; /* 기본적으로 줄 바꿈 허용 */
}

.table thead th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.table-container {
    overflow-x: auto; /* 테이블이 너무 길 경우 스크롤 허용 */
    max-width: 100%;
}
/* 대서리 메뉴용 */


.swiperMain {
    width: 100%;
    height: 100%;
}

.swiperCategory {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

div.mainImg_div {
	width: 100%;
	padding-bottom: 30px;
}

img.mainImg {
	display: block;
	width: 100%;
	object-fit: cover;
	border: none;
	border-radius: 6px;
	aspect-ratio: 1/1;
}



.swiper-slide {
    text-align: center;
    font-size: 18px;
    background: #fff;
    margin-top: 5px;
    border: none;
    margin-right: 0px !important;
   	padding: 0px;
    box-sizing: border-box;
    overflow: hidden;
    background-clip: padding-box;
    

  /* Center slide text vertically */
    display: -webkit-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    -webkit-justify-content: center;
    justify-content: center;
    -webkit-box-align: center;
    -ms-flex-align: center;
    -webkit-align-items: center;
    align-items: center;
}

/* swiper 점 모양 */

.swiper-pagination-bullet {
	width: 10px;
	height: 10px;
	background-color: #0DCC5A;
}


.swiper-button-prev,
.swiper-button-next {
    padding: 15px 5px;
    color: black;
}

.swiper-button-prev:after,
.swiper-button-next:after {
    font-size: 16pt;
    font-weight: 900;
}



.mainImgContainer{
	height: 420px;
}

.menuImgContainer{
	height: 325px;
	margin-top: 130px;
}



div.swiper-wrapper {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	border: none;
    transform: translateZ(0); /* 미세한 선 방지 */
    will-change: transform;

}


img.menuImg{
	display: block;
	border-radius: 6px;
	aspect-ratio: 1/1;
	border: none;
	width: 100%;
	object-fit: cover;
	border: none;
}



div.menu_title {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

span.menu_title {
	font-size: 10pt; 
	padding-top: 10px;
	cursor: pointer;
}

div.index_prod_list {
	padding-bottom: 30px;
	cursor: pointer;
	border: none;
}

div.index_prod_list span {
	display: block;
}

div.prod_title {
	margin-top: 5px;
   	overflow: hidden;
  	text-overflow: ellipsis;
  	display: -webkit-box;
  	-webkit-line-clamp: 2;
  	-webkit-box-orient: vertical;
  	height: 50px;
}	

span.prod_title {
	width: 100%;
	font-size: 12pt;
}

span.prod_price {
	margin-top: 5px;
	font-size: 14pt;
	font-weight: bold;
}

div.prod_town_time {
	margin-top: 5px;
	display: flex;
	font-size: 10pt;
	color: #999999;
	justify-content: center;
	gap: 3px;;
}




/* overlay */
div.menuImg_div {
    position: relative;
    display: inline-block;
    border: none;
    overflow: hidden;
    width: 100%;
}

div.sold_out_overlay {
    position: absolute;
    inset: 0;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.3); /* 반투명한 검은색 */
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    z-index: 5; 	 				/* 다른 요소보다 위에 배치 */
    border-radius: 6px;
    border: none !important; /* 혹시라도 border가 생기는 경우 제거 */
    padding: 0 !important; /* padding 문제 방지 */
    box-sizing: border-box;
}

span.sold_out_text {
    padding: 10px 20px;
    font-size: 14pt;
    font-weight: bold;
    color: white;

}

</style>


<jsp:include page=".././header/header.jsp" />

<div class="container mt-5">
	
<!-- Slider main container -->
<div class="mainImgContainer">
	<div class="swiper swiperMain">
	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	    <!-- Slides -->
	    <div class="swiper-slide">
		    <div class="mainImg_div">
		    	<img class="mainImg" src="${pageContext.request.contextPath}/images/main/main1.png">
		    </div>
	    </div>
	    <div class="swiper-slide">
		    <div class="mainImg_div">
		    	<img class="mainImg" src="${pageContext.request.contextPath}/images/main/main2.png">
		    </div>
	    </div>
	   	<div class="swiper-slide">
		    <div class="mainImg_div">
		    	<img class="mainImg" src="${pageContext.request.contextPath}/images/main/main3.png">
		    </div>
	    </div>
	   	<div class="swiper-slide">
		    <div class="mainImg_div">
		    	<img class="mainImg" src="${pageContext.request.contextPath}/images/main/main4.png">
		    </div>
	    </div>	    		    
	  </div>
	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
	

</div>



<div class="menuImgContainer container">
	<div class="menu_title">
 		<h3 style="margin-bottom: 0px;">방금 등록된 상품</h3>
 		<span class="menu_title" onclick="location.href='${pageContext.request.contextPath}/product/prodlist'">전체보기</span>
	</div>
	<div class="swiper swiperCategory"> 
	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	  
	    <!-- Slides -->
	    <c:forEach var="reg_date_list" items="${requestScope.product_list_reg_date}" varStatus="status"  begin="0" end="6">
	    <div class="swiper-slide menuImg">
	    	
	    	<div class="index_prod_list" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	    		<div class="menuImg_div">
		    		<img class="menuImg" src="${reg_date_list.prod_img_name}">
		    		
		    		 <%-- 상품 상태가 예약중이면 오버레이 추가 --%>
	                <c:if test="${reg_date_list.product_sale_status == 1}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">예약중</span>
	                    </div>
	                </c:if>
		    		
					<%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
	                <c:if test="${reg_date_list.product_sale_status == 2}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">판매완료</span>
	                    </div>
	                </c:if>
	                
	                <%-- 상품 상태가 경매 시작 전이면 오버레이 추가 --%>
	                <c:if test="${reg_date_list.product_sale_status == 3}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">경매 시작 전</span>
	                    </div>
	                </c:if>
	                
	                <%-- 상품 상태가 경매중이면 오버레이 추가 --%>
	                <c:if test="${reg_date_list.product_sale_status == 4}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">경매중</span>
	                    </div>
	                </c:if>
					
					<%-- 상품 상태가 경매완료이면 오버레이 추가 --%>
					<c:if test="${reg_date_list.product_sale_status == 5}">
					    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
					        <span class="sold_out_text">경매완료</span>
					    </div>
					</c:if>	
					
                </div>

	    		<div class="prod_info">
	    			<div class="prod_title">
		    			<span class="prod_title">${reg_date_list.product_title}</span>
		    		</div>
		    		<div>
		    			<span class="prod_price"><fmt:formatNumber value="${reg_date_list.product_price}" pattern="#,###" /> 원</span>
		    		</div>
		    		<div class="prod_town_time">
						<span class="prod_town">${reg_date_list.region_town}</span>
						<span class="bar">|</span>
						<span class="prod_time" data-date="${reg_date_list.product_update_date}"></span>
					</div>
	    		</div>
			</div>
			
	    </div>
	    </c:forEach>
	    
	  </div>

	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
</div>


<div class="menuImgContainer container">
	<div class="menu_title">
 		<h3 style="margin-bottom: 0px;">이번 주 인기 급상승 상품!</h3>
	</div>
	<div class="swiper swiperCategory"> 
	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	  
	    <!-- Slides -->
	    <c:forEach var="views_week_list" items="${requestScope.product_list_views_week}" varStatus="status"  begin="0" end="6">
	    <div class="swiper-slide menuImg">
	    	
	    	<div class="index_prod_list" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${views_week_list.pk_product_no}'">
	    		
	    		<div class="menuImg_div">
		    		<img class="menuImg" src="${views_week_list.prod_img_name}">
		    		
		    		 <%-- 상품 상태가 예약중이면 오버레이 추가 --%>
	                <c:if test="${views_week_list.product_sale_status == 1}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${views_week_list.pk_product_no}'">
	                        <span class="sold_out_text">예약중</span>
	                    </div>
	                </c:if>
		    		
					<%-- 상품 상태가 판매 완료면 오버레이 추가 --%>
	                <c:if test="${views_week_list.product_sale_status == 2}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${views_week_list.pk_product_no}'">
	                        <span class="sold_out_text">판매완료</span>
	                    </div>
	                </c:if>
	                
	                <%-- 상품 상태가 경매 시작 전이면 오버레이 추가 --%>
	                <c:if test="${views_week_list.product_sale_status == 3}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">경매 시작 전</span>
	                    </div>
	                </c:if>
	                
	                <%-- 상품 상태가 경매중이면 오버레이 추가 --%>
	                <c:if test="${views_week_list.product_sale_status == 4}">
	                    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
	                        <span class="sold_out_text">경매중</span>
	                    </div>
	                </c:if>	  
					
					<%-- 상품 상태가 경매완료이면 오버레이 추가 --%>
					<c:if test="${views_week_list.product_sale_status == 5}">
					    <div class="sold_out_overlay" onclick="location.href='${pageContext.request.contextPath}/product/prod_detail/${reg_date_list.pk_product_no}'">
					        <span class="sold_out_text">경매완료</span>
					    </div>
					</c:if>					              
                </div>
	    		
	    		<div class="prod_info">
	    			<div class="prod_title">
		    			<span class="prod_title">${views_week_list.product_title}</span>
		    		</div>
		    		<div>
		    			<span class="prod_price"><fmt:formatNumber value="${views_week_list.product_price}" pattern="#,###" /> 원</span>
		    		</div>
		    		<div class="prod_town_time">
						<span class="prod_town">${views_week_list.region_town}</span>
						<span class="bar">|</span>
						<span class="prod_time" data-date="${views_week_list.product_update_date}"></span>
					</div>
	    		</div>
			</div>
			
	    </div>
	    </c:forEach>
	    
	  </div>

	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
</div>

<script type="module">
import Swiper from 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.mjs';

const swiperMain = new Swiper('.swiperMain', {
direction: 'horizontal',
loop: true,
autoplay : { 
  	delay : 3000, 
  	disableOnInteraction : false, 
},
breakpoints: {
  1024: {
      slidesPerView: 3,
      spaceBetween: 20,
      },
      880 : {
        slidesPerView: 2,
        spaceBetween: 40,
      },
      620 : {
        slidesPerView: 1,
        spaceBetween: 50,
  	  },
	},
    pagination: {
      el: '.swiper-pagination',
    },

    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },


});

const swiperCategory = new Swiper('.swiperCategory', {
direction: 'horizontal',
loop: true,
slidesPerView: 6,
spaceBetween: 20,

breakpoints: {
  1024: {
      slidesPerView: 6,
      spaceBetween: 20,
      },
      880 : {
        slidesPerView: 4,
        spaceBetween: 40,
      },
      620 : {
        slidesPerView: 2,
        spaceBetween: 50,
  	  },
	},
    pagination: {
      el: '.swiper-pagination',
    },

    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },


});

</script>


<script>

$(document).ready(function(){
	
	
	if('${sessionScope.member_status}' == 2){
		location.href = "/antico/logout";
	}
	
	// 상품 등록일자 계산 해주기
	$("span.prod_time").each(function() {
	    const prod_town_time = $(this).attr('data-date'); // 등록일
	    const time = timeAgo(prod_town_time); 	  		   // 함수 통해 시간 형식 변환
	    $(this).text(time);								       // 텍스트로 출력
	}); // end of $("span.product_time").each(function()


});

	
	
	
	// 등록일 계산 해주는 함수
	function timeAgo(update_date) {
	    const now = new Date(); 					 	   // 현재 시간
	    const prod_town_time = new Date(update_date); 	   // 상품 등록일
	
	    const second = Math.floor((now - prod_town_time) / 1000); 	// 두 날짜 차이를 초 단위로 계산
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
</script>

<jsp:include page=".././footer/footer.jsp" />

