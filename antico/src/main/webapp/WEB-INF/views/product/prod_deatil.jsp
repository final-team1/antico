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

div#detail_container {
	text-align: center;
	justify-content: center;
	width: 100%;
	margin-top: 80px;
}

img#prod_img {
	object-fit: cover;
}


</style>


<div id="container">
	<div id="detail_container" class="row" style="border: solid 1px red;">
	
		<div class="col-md p-0" style="border: solid 1px blue;">
			<img src='<%= ctxPath%>/resources/productImages/20250219104353434697302867500.png' id="prod_img" class="w-100 h-100" />
		</div>
		
		<div class="col-md p-0" style="border: solid 1px green;">
			<span>상품 정보</span>
		</div>	
	
	</div>
</div>



<jsp:include page=".././footer/footer.jsp"></jsp:include>