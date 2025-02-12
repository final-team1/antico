<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page=".././header/header.jsp"></jsp:include>



<style type="text/css">

/* 상품이미지 */
div#prod_img_container {
	margin-top: 70px;
}
 
label#prod_img {
	background-color: #f1f4f6;
	width: 86px;
	height: 80px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
    cursor: pointer;
    margin: 0;
	padding: 0;
}

label#prod_img p {
	font-size: 9pt;
	margin-top: 20px;
    margin-bottom: 0;
}


/* 상품명 */
div#prod_name {
	margin-top: 40px;
}

input#prod_name {
	border: solid 1px #cccccc;
	padding: 10px 20px;
	width: 100%;
	font-size: 10pt;
}

</style>



<div class="container">

	<!-- 상품 등록 시작 -->
	<form name="prod_add_frm" enctype="multipart/form-data">	
		
		<!-- 상품 이미지  -->
		<div id="prod_img_container">
			<div>
				<input id="prod_img" name="prod_img" type="file" accept='image/*' style="display: none;" />
				<div>
					<label id="prod_img" for="prod_img">
						<i class="fa-solid fa-camera fa-xl" style="color: #9ca3af;"></i>
						<p style="color: #9ca3af;">0/10</p>
					</label>
				</div>
			</div>
		</div>
		
		<!-- 상품명  -->
		<div id="prod_name">
			<input id="prod_name" name="prod_name" type="text" placeholder="상품명" />
		</div>
		
		
		<br>
		<br>
		<div>3.카테고리</div>
		<div>
			<input id="prod_price" name="prod_price" type="text" placeholder="판매가격" />
		</div>
		<div>
			<textarea>상품 상세내용</textarea>
		</div>
	
		<div>6.상품상태</div>
		<div>7.희망지역</div>
	
	</form>
	<!-- 상품 등록 끝 -->
		
</div>


<jsp:include page=".././footer/footer.jsp"></jsp:include>