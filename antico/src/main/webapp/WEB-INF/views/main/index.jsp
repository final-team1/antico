<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
}

.swiper-slide {
    text-align: center;
    font-size: 18px;
     background: #fff;

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

.swiper-slide img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.mainImgContainer{
	height:325px;
}

.menuImgContainer{
	height:250px;
}

.menuImg{
	height: 100%;
	border-radius: 10%;
}

</style>


<jsp:include page=".././header/header.jsp" />

<div class="container mt-5">



<!-- 사이트 탭 테스트용  -->
<button onclick="showReviewTab()">후기확인</button>
<button onclick="showReviewRegisterTab()">후기 등록 확인</button>

<button onclick="showAlert('success', '테스트')">토스트 테스트</button>
	
<!-- Slider main container -->
<div class="mainImgContainer">
	<div class="swiper swiperMain">
	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	    <!-- Slides -->
	    <div class="swiper-slide"><img src="https://img2.joongna.com/banner/1709792928336.webp"></div>
	    <div class="swiper-slide"><img src="https://img2.joongna.com/banner/1737697998356.webp"></div>
	    <div class="swiper-slide"><img src=""></div>
	    <div class="swiper-slide"><img src=""></div>
	    <div class="swiper-slide"><img src=""></div>
	  </div>
	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
	

</div>

<h2 class="mb-4" style="margin-top:15%;">고객님 이런상품은 어때요?</h2>
<div class="menuImgContainer container" style="height:200px;">

	<div class="swiper swiperCategory">

	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	    <!-- Slides -->
	    <div class="swiper-slide menuImg"><img class="menuImg" src="https://img2.joongna.com/banner/1709792928336.webp"></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src="https://img2.joongna.com/banner/1737697998356.webp"></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	  </div>
	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
	
</div>


<h2 class="mb-4" style="margin-top:10%;">브랜드별 상품 이런상품은 어때요?</h2>
<div class="menuImgContainer container" style="height:200px;">

	<div class="swiper swiperCategory">

	  <!-- Additional required wrapper -->
	  <div class="swiper-wrapper">
	    <!-- Slides -->
	    <div class="swiper-slide menuImg"><img class="menuImg" src="https://img2.joongna.com/banner/1709792928336.webp"></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src="https://img2.joongna.com/banner/1737697998356.webp"></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	    <div class="swiper-slide menuImg"><img class="menuImg" src=""></div>
	  </div>
	  <!-- If we need pagination -->
	  <div class="swiper-pagination"></div>
	
	  <!-- If we need navigation buttons -->
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-button-next"></div>
	
	</div>
	
</div>
	<h2>대서리 점심메뉴</h2>
	<div class="table-container">
	    <table class="table">
	        <thead>
	            <tr>
	                <th></th>
	                <th>월요일</th>
	                <th>화요일</th>
	                <th>수요일</th>
	                <th>목요일</th>
	                <th>금요일</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <th scope="row">밥</th>
	                <td>백미<br>흑미</td>
	                <td>백미<br>흑미</td>
	                <td>백미<br>흑미</td>
	                <td>백미<br>흑미</td>
	                <td>백미<br>흑미</td>
	            </tr>
	            <tr>
	                <th scope="row">국</th>
	                <td>순두부찌개</td>
	                <td>미역국<br>김치짜글이(꽁치?)</td>
	                <td>스팸 부대찌개</td>
	                <td>콩나물국</td>
	                <td>하이라이스<br>유부미소국</td>
	            </tr>
	            <tr>
	                <th scope="row">메인메뉴</th>
	                <td>마파두푸<br>생선까스<br>계란말이</td>
	                <td>닭강정<br>연근조림<br>청포묵무침</td>
	                <td>동파육<br>김말이튀김<br>야채 볶음</td>
	                <td>김치참치볶음<br>해물매운볶음<br>두부조림<br>계란곤약장조림</td>
	                <td>돈까스<br>타꼬야끼<br>어묵볶음</td>
	            </tr>
	            <tr>
	                <th scope="row">반찬</th>
	                <td>콩나물무침<br>미역줄기볶음<br>도라지무침<br>콩자반</td>
	                <td>오징어젓갈<br>멸치볶음<br>조미김</td>
	                <td>단무지무침<br>오이고추된장무침<br>조미김</td>
	                <td>깻잎지<br>조미김</td>
	                <td>고추장아찌<br>브로콜리<br>조미김</td>
	            </tr>
	        </tbody>
	    </table>
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


	
	//후기 확인 테스트 함수
	function showReviewTab() {
		$.ajax({
			url : "<%=ctxPath%>/review/",
			data : {
				"pk_member_no" : "1"
			},
			success : function(html) {
				// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
				openSideTab(html);
			},
			error : function(e) {
 				 console.log(request.responseText);
				 
 				 // 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
				 let response = request.responseText;
				 let message = response.substr(0, 4) == "msg/" ? response.substr(4) : "";
				 
				 // 사이드 탭 닫기
			     showAlert("error", message);
			     closeSideTab();
			}
		});
	}
	
	//후기 등록 테스트 함수
	function showReviewRegisterTab() {
		$.ajax({
			url : "<%=ctxPath%>/review/register",
			data : {
				"pk_trade_no" : "1"
			},
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



<jsp:include page=".././footer/footer.jsp" />

<jsp:include page="../tab/tab.jsp">
	<jsp:param name="tabTitle" value="후기" />
</jsp:include>

