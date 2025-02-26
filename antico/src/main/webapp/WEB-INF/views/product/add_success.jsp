<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>


<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


<%-- font cdn --%>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />

<style type="text/css">
*{
font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
}

div#container {
	width: 70%;
	margin: 0 auto;
	text-align: center;
}

div#contents_container {
    display: flex;
    flex-direction: column;  /* 요소들을 세로로 정렬 */
    align-items: center;    
    justify-content: center; 
    height: 100%; 
}

i.custom-bounce {
	animation: fa-bounce 1s ease-in-out 1;
	font-size: 50px;
}


div#add_success_text_wrap {
	margin-top: 20px;
	margin-bottom: 20px;
}

span#add_success_text {
	font-weight: bold;
	font-size: 16pt;
}

div#main_back, div#check_product {
	margin-top: 10px;
}

button.main_btn, button.check_btn {
	border: solid 1px #cccccc;
	color: black;
	background-color: white;
	width: 350px;
	height: 50px;
	font-weight: bold;
	font-size: 10pt;
	cursor: pointer;
}

</style>
    
    
    
<div id="container">
	
	<div id="contents_container">
		<!-- check 아이콘 -->
		<div id="icon_wrap">
			<i class="fa-regular fa-circle-check custom-bounce" style="color: #0dcc5a;"></i> 
		</div>
		
		<div id="add_success_text_wrap">
			<span id="add_success_text">상품 등록 완료!</span>
		</div>
		
		<div id="main_back">
			<button class="main_btn" onclick="location.href='<%= ctxPath%>/index'">메인 페이지</button>	
		</div>
		
		<div id="check_product">
			<button class="check_btn" onclick="location.href='<%= ctxPath%>/product/prod_detail/' + '${requestScope.pk_product_no}';">등록 상품 확인</button>	
		</div>
	</div>

</div>


