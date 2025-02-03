<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

   String ctxPath = request.getContextPath();
   //     /myspring 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>히히</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
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

  <%-- 스피너 및 datepicker 를 사용하기 위해 jQueryUI CSS 및 JS --%>
  <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
  <script type="text/javascript" src="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <%-- === jQuery 에서 ajax로 파일을 업로드 할때 가장 널리 사용하는 방법 : ajaxForm === --%> 

<style>

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
	border-radius: 5%; 
}

.searchBar {
	border: none;
	background-color: #F1F4F6;
	border-radius: 5%; 
}


/* 서치바 끝 */

#userManu{
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

</style>

</head>
<body>

<!-- 데스크톱 버전 -->
<div class="container-fluid fixed sticky-top" style="padding-left: 0px; padding-right: 0px;">


<div class="content desktop">

	<div style="width: 100% ;">
	
	<div class="d-flex" style="height:100px; width:70%; margin:0 auto;">
		
		<div class="" style="vertical-align: middle;">
			<img class="mt-4" src="https://web.joongna.com/main-web/assets/images/custom-logo.svg" width="200"/>
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
					<li class="">판매하기</li>
					<li style="color: gray" class="">|</li>
					<li class="">마이</li>	
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
			<a class="menuStyle">내폰팔기</a>
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
		<img class="mt-4" src="https://web.joongna.com/main-web/assets/images/custom-logo.svg" width="100"/>
	</div>
	
	<div style="vertical-align: middle; margin:25px 10px 0 0;">
		<span>검색</span>
	</div>

</div>
	

<div id="mySidenav" class="scrollMenu">

	<img class="scrollImg" src="https://web.joongna.com/main-web/assets/images/custom-logo.svg" width="200"/>
		
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
	

	
});

</script>

