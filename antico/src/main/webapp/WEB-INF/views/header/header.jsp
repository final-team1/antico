<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

   String ctxPath = request.getContextPath();
   //     /myspring 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Antico</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <%-- favicon.ico 적용 --%>
  <link rel="icon" href="favicon.ico" type="image/x-icon">
  
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
 
  <%-- Font Awesome 6 Icons --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uicons/css/uicons-regular-rounded.css">
  

  <%-- Optional JavaScript --%>

  <script type="text/javascript" src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%=ctxPath%>/jquery-ui-1.13.1.custom/external/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="<%=ctxPath%>/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 

	<%-- 카카오 api --%>
  <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js" integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>

  <%-- 스피너 및 datepicker 를 사용하기 위해 jQueryUI CSS 및 JS --%>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
  <script type="text/javascript" src="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <%-- === jQuery 에서 ajax로 파일을 업로드 할때 가장 널리 사용하는 방법 : ajaxForm === --%>
  
  <%-- toast 알림을 위한 CDN --%>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> 
  <script src="<%=ctxPath%>/js/custom_toast.js"></script>
  <link rel="stylesheet" href="<%=ctxPath%>/css/custom_toast.css">


  <%-- font cdn --%>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
<style>
*{
font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
}

.fixed {
    left:16px;
    top:0;
    background-color: white;
    margin-bottom: 1%;
    z-index: 10;
}

input.searchBar {
    min-width: 200px; /* 최소 너비 제한 */
    font-size: 16px;
    height:40px;
    flex: 1; /* 공간을 채우도록 설정 */
	box-sizing: border-box;
}

.inputContainer {
	display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: center;
    padding: 20px 20px 0 20px;
}

.searchBest{
	display: flex;
    align-items: center;
    padding-left: 20px;
}

.btnBest{
	background-color: white;
	border: solid 1px #F1F4F6;
	border-radius: 15%;
}

    
.content {
  display: none;
}  

@media (max-width: 1023px) {
  .mobile {
    display: block;
  }
}

@media (min-width: 1024px) {
  .desktop {
    display: block;
  }
}

@media (max-width: 1023px) {
  .mobile {
    display: block;
  }
}

/* 서치바 */

.search_bar_container{
	background-color: #F1F4F6;
	border-radius: 8px; 
}

.searchBar {
	border: none;
	background-color: #F1F4F6;
	border-radius: 7px; 
}


/* 서치바 끝 */

#userManu{
	position: relative;
	list-style-type: none;
	
}

#userManu > li{
	display:inline-block;
	
}

#userManu > li > p{
	font-size: 12pt;
	margin: 0 auto;
}

.bestMenu{
	list-style-type: decimal;
}
.bestMenu > li {
	display:inline-block;
	font-size: 8pt;
}

.menuStyle{
	position: relative;
	font-size: 12pt;
	padding:12px 16px;
	color: black;
}
.menuStyle:hover{
	 text-decoration-line: none;
	 color: black;
}


@media (min-width: 1280px) {
  .menuStyle {
    font-size: 12pt;
	padding:12px 16px;
  }
}

@media (max-width: 1279px) {
  .menuStyle {
    font-size: 10pt;
	padding:6px 12px;
  }
}


div > a.menuStyle::after{
	width: 0px;
	content: "";
	position: absolute;
	bottom: -18px; 
	left: 0;
	border-top: 2px solid black; 
	transform:translateX(-100%);
}
a.menuStyle:hover::after {
	width:100%;
	transform:translateX(0%);
	transition: width 0.45s;

}

.menuItem{
	padding: 4px 0;
}

.category:hover{
	
}

.categoryIcon{
  width: 25px;
  height: 2px;
  background-color: black;
  margin: 5px 0;
}




/* 모바일버전 카테고리 시작 */

/* The side navigation menu */
.scrollMenu {
  height: 100%; /* 100% Full-height */
  width: 0; /* 0 width - change this with JavaScript */
  position: fixed; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0; /* Stay at the top */
  left: 0;
  background-color: white; /* Black*/
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
}

/* The navigation menu links */
.scrollMenu a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 16pt;
  color: black;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.scrollMenu a:hover {
  color: #f1f1f1;
}

/* Position and style the close button (top right corner) */
.scrollMenu .closebtn {
  position: absolute;
  top: 0;
  right: 16px;
  font-size: 36px;
  margin-left: 50px;
}

.scrollImg {
  position: absolute;
  top: 20;
  left: 32px;
}

/* Style page content - use this if you want to push the page content to the right when you open the side navigation */
#main {
  transition: margin-left .5s;
  padding: 20px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .scrollMenu {padding-top: 15px;}
  .scrollMenu a {font-size: 18px;}
}

/* 모바일버전 카테고리 끝 */


div.categoreIcon {
  width: 35px;
  height: 3px;
  background-color: black;
  border-radius: 15%;
  margin: 6px 0;
}

li > a{
	color: black;
	text-decoration: none;
}

li > a:hover{
	color: black;
	text-decoration: none;
}

img.main_logo {
	cursor : pointer;
}


.my_header{
	position: absolute;
	list-style: none;
	height: 50px; 
    width: 70px;
    left: 114px;
    top: 30px;
    padding: 0;
    text-align: center;
    border: solid 1px #F1F4F6;
    border-radius: 5px;
    font-size: 12px;
    display:none;
}

</style>

</head>
<body>

<!-- 데스크톱 버전 -->
<div class="container-fluid fixed sticky-top" style="padding-left: 0px; padding-right: 0px;">


<div class="content desktop">

	<div style="width: 100% ;">
	
	<div class="d-flex" style="height:100px; width:70%; margin:0 auto;">
		
		<div class="" style="vertical-align: middle;">
			<img class="mt-4 main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
		</div>
		<div class="flex-fill">
			<div>
				<div class="inputContainer" style="">
		        	<input type="text" class="searchBar">
		        </div>
		        <div class="searchBest mt-1 he-3 d-inline-block w-100" style="display:inline;">
		        		<button type="button" class="btnBest mr-1"><span style="font-size: 8pt; vertical-align: middle;">&lt;</span></button>
		        		<button type="button" class="btnBest mr-1"><span style="font-size: 8pt;">&gt;</span></button>
		        		<ol type="1" start="1" class="bestMenu" style="padding-inline-start: 0px; margin-block-end: 0em; width: 50%; display:inline;">
		        			<li>컴퓨터</li>
		        			<li>키보드</li>
		        			<li>가면라이더</li>
		        			<li>아이폰16</li>
		        			<li>볼링공</li>
		        		</ol>
		        </div>
			</div>  
		</div>
		
		<div class="" style="display: flex; align-items: center; height: 80px; margin-left:auto;">
			<div style="">
				<ul id="userManu" class="" style="padding-inline-start: 0px; margin-block-end: 0em;">
					<li class="">채팅하기</li>
					<li style="color: gray" class="">|</li>
					<li class=""><a href="<%=ctxPath%>/product/add">판매하기</a></li>
					<li style="color: gray" class="">|</li>
					<li class="">
						
						<c:if test="${pageContext.request.userPrincipal.name == null}"><a href="<%=ctxPath%>/member/login">마이</a></c:if>
						<c:if test="${pageContext.request.userPrincipal.name != null}"><p class="my_manu">마이</p></c:if>
					
					<ul class="my_header">
					
						<li style="margin-top:2px;"><a href="<%=ctxPath%>/mypage/mypagemain">마이페이지</a></li>
						<li><hr style="margin: 4px;"></li>
						<li style="margin-top:8px;"><p>로그아웃</p></li>
						
					</ul>
					</li>	
				</ul>
			</div>
		</div>
		
	</div>
	
	<div style="width:70%; margin:0 auto;">
	
	<div style="display:flex;">
	
		<div>
		<span class="btn btn-dark mr-4 category">카테고리</span>
		</div>
	
		<div class="menuItem">
			<a class="menuStyle">이벤트</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">닌텐도</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">J쿠폰</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">사기조회</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">시세조회</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">읽을거리</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle">찜한상품</a>
		</div>
		<div class="menuItem">
			<a class="menuStyle" href="<%= ctxPath%>/notice/notice_list">고객센터</a>
		</div>
		
		</div>
		
	</div>
	
</div>

<hr style="margin-bottom: 0px;">
<div style="display:none" class="categoryView">
	<ul>
		<li>전자제품</li>
		<li>머시기</li>
		<li>다른머시기</li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
	</ul>
</div>

</div>
</div>
<!-- 데스크톱 버전 끝 -->



<!-- 모바일 버전 -->



<div class="content container-fluid mobile fixed sticky-top" style=" padding-left: 0px;">


<div class="d-flex" style="vertical-align: middle;  height:80px;">

	<div style="vertical-align: middle; padding:0 16px;" onclick="openNav()">
		
		<div class="mt-4">
			<div class="categoreIcon"></div>
			<div class="categoreIcon"></div>
			<div class="categoreIcon"></div>
		</div>
		
	</div>
	
	<div class="flex-fill">
		<img class="mt-4 main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="100"/>
	</div>
	
	<div style="vertical-align: middle; margin:25px 10px 0 0;">
		<span>검색</span>
	</div>

</div>
	

<div id="mySidenav" class="scrollMenu">

	<img class="scrollImg" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
		
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	

	
	<a href="#">카테고리</a>
	<a href="#">이벤트</a>
	<a href="#">닌텐도</a>
	<a href="#">J쿠폰</a>
	<a href="#">사기조회</a>
	<a href="#">시세조회</a>
	<a href="#">읽을거리</a>
	<a href="#">찜한상품</a>
	<a href="#">내폰팔기</a>
	<a href="#">로그인</a>
</div>

<hr style="margin:0;">
</div>



<script type="text/javascript">

/* Set the width of the side navigation to 250px */
function openNav() {
  document.getElementById("mySidenav").style.width = "100%";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

$(document).ready(function(){
	
	$("ul.my_header").css("display", "none");
	
	$("img.main_logo").click(function(e){
		location.href = "<%=ctxPath%>/index";
	});	
	
	
	$("p.my_manu").bind("click", function(){
		
		if($("ul.my_header").css("display") == "none"){
			$("ul.my_header").css("display", "block");
		}else{
			$("ul.my_header").css("display", "none");
		}
		
	});
	
	
});

</script>

