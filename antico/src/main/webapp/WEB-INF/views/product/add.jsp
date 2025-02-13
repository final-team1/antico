<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page=".././header/header.jsp"></jsp:include>



<style type="text/css">

/* 공통 */
.cm_margin_top { /* 각 입력 값에 대한 margin-top */
	margin-top: 30px;
}

.cm_span_title { /* 상품상태 / 판매유형 / 희망지역 타이틀 텍스트 */
	color: #5a5a5a;
	font-size: 12pt;
	font-weight: bold;
}


/* div 전체 틀 */
div#container {
	width: 50%;
	margin: 0 auto;
}

/* 상품이미지 */
div#prod_img_container {
	margin-top: 70px;
}
 
label#prod_img {
	background-color: #f1f4f6;
	border-radius: 6px;
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
input#prod_name {
	border: solid 1px #cccccc;
	border-radius: 6px;
	padding: 10px 20px;
	width: 100%;
	font-size: 10pt;
}


/* 카테고리 공통 */
div.category_left,
div.category_right {  		
	max-height: 230px;			/* 6개 항목만 보이게 설정 */
    overflow-y: auto;   		/* 내부 스크롤 활성화 */
    scrollbar-width: none;		/* 스크롤 감추기 */
}


/* 상품 카테고리 (상위) */
div#category {
    display: flex;
    border: 1px solid #ddd;
    border-radius: 6px;
    width: 400px;
}
div.category_left {
    width: 50%;
    padding: 10px;
    border-right: 1px solid #ddd;
}
div.category_left ul {
    list-style: none;
    padding: 0;
    margin-bottom: 0px !important;
}
div.category_left li {
    padding: 8px;
    cursor: pointer;
    color: #5a5a5a;
    font-size: 10pt;
}
div.category_left li:hover {
    background-color: #e9ecef;
}


/* 상품 카테고리 (하위) */
div.category_right {
    width: 50%;
    padding: 10px;
    display: none; 
}
div.category_right ul {
    list-style: none;
    padding: 0;
}
div.category_right li {
    padding: 8px;
    color: #5a5a5a;
    font-size: 10pt;
}


/* 상품 가격 */
div#prod_price {
	position: relative;
}

span#won {
	position: absolute; 
	left: 10px; 
	top: 50%; 
	transform: translateY(-50%); 
	pointer-events: none;
	font-size: 10pt;
	padding-left: 10px;
}

input#prod_price {
	border: solid 1px #cccccc;
	border-radius: 6px;
	padding: 10px 32px;
	width: 100%;
	font-size: 10pt;
}


/* 상품 내용 */
textarea#prod_contents {
	border: solid 1px #cccccc;
	border-radius: 6px;
	padding: 10px 22px;
	width: 100%;
	height: 220px;
	font-size: 10pt;
	resize: none;
	scrollbar-width: none;
}

span#text_count {
	position: absolute; 
	right: 0;
	font-size: 10pt;
}


/* 상품상태, 판매유형, 희망지역 */
div.button {
	margin-top: 10px;
}


/* 상품상태, 판매유형, 희망지역 버튼*/
button.used, button.general {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: #0dcc5a;
	width: 90px;
	height: 40px;
	font-weight: bold;
	font-size: 10pt;
}

button.new, button.action {
	border: solid 1px black;
	border-radius: 6px;
	margin-left: 10px;
	color: black;
	background-color: white;
	width: 90px;
	height: 40px;
	font-weight: bold;
	font-size: 10pt;
}

button.add_region {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: #0dcc5a;
	width: 90px;
	height: 40px;
	font-weight: bold;
	font-size: 10pt;
}


/* 등록 버튼 */
button.add {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: black;
	width: 150px;
	height: 50px;
	font-weight: bold;
	font-size: 10pt;
}




</style>



<div id="container">

	<!-- 상품 등록 시작 -->
	<form name="prod_add_frm" enctype="multipart/form-data">	
		
		<!-- 상품 이미지  -->
		<div id="prod_img_container">
			<div style="display: flex;">
				<input id="prod_img" name="prod_img" type="file" accept='image/*' style="display: none;" />
				<div>
					<label id="prod_img" for="prod_img">
						<i class="fa-solid fa-camera fa-xl" style="color: #9ca3af; padding-top: 6px;"></i>
						<p style="color: #9ca3af;">0/10</p>
					</label>
				</div>
				<!-- 상품 이미지 미리보기  -->
				<div id="imagePreviews" style="border: solid 1px green; margin-left: 10px; width: 100%;">
					이미지 미리 보기 들어옵니다
    				<ul id="imagePreviews-ul" style="display: none;"></ul>
				</div>
			</div>
		</div>
		
		<!-- 상품명  -->
		<div id="prod_name" class="cm_margin_top">
			<input id="prod_name" name="prod_name" type="text" placeholder="상품명" />
		</div>
		
		
		<!-- 카테고리  -->
		<div id="category" class="cm_margin_top">
		    <!-- 상위카테고리 -->
		    <div class="category_left">
		        <ul>
		            <li onclick="loadSubcategories('패션의류')">패션의류</li>
		            <li onclick="loadSubcategories('패션잡화')">패션잡화</li>
		            <li onclick="loadSubcategories('뷰티')">뷰티</li>
		            <li onclick="loadSubcategories('출산/유아동')">출산/유아동</li>
		            <li onclick="loadSubcategories('모바일/태블릿')">모바일/태블릿</li>
		            <li onclick="loadSubcategories('모바일/태블릿')">티켓/쿠폰</li>
		            <li onclick="loadSubcategories('모바일/태블릿')">가나</li>
		            <li onclick="loadSubcategories('모바일/태블릿')">다라</li>
		            <li onclick="loadSubcategories('모바일/태블릿')">마바</li>
		        </ul>
		    </div>
		
		    <!-- 하위카테고리 (처음엔 숨김) -->
		    <div id="category_detail" class="category_right">
		        <ul id="category_detail_list"></ul>
		    </div>
		</div>
		
		
		<!-- 상품 가격 -->
		<div id="prod_price" class="cm_margin_top">
		  	<span id="won">₩</span>
		  	<input id="prod_price" name="prod_price" type="text" placeholder="판매가격" />
		</div>
		
		<!-- 상품 내용 -->
		<div id="prod_contents" class="cm_margin_top">
			<textarea id="prod_contents" maxlength="1000" placeholder="- 상품명 &#10;- 구매 시기&#10;- 사용 기간&#10;- 하자 여부&#10;* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.&#10;* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요&#10;안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, Antico가 함께합니다." ></textarea>
		</div>
		
		<div style="position: relative;">
			<span id="text_count">0 / 1000</span>
		</div>
		
		
		<!-- 상품 상태 -->
		<div id="prod_status" class="cm_margin_top">
			<span class="cm_span_title">상품상태</span>
			<div class="button">
				<button class="used">중고</button>
				<button class="new">새상품</button>
			</div>
		</div>
		
		
		<!-- 판매 유형 -->
		<div id="prod_sale_type" class="cm_margin_top">
			<span class="cm_span_title">판매유형</span>
			<div class="button">
				<button class="general">일반판매</button>
				<button class="action">경매</button>
			</div>
		</div>
		
		
		<!-- 희망 지역 -->
		<div id="prod_region" class="cm_margin_top">
			<span class="cm_span_title">희망지역</span>
			<div class="button">
				<button class="add_region">+추가하기</button>
			</div>
		</div>
		
		<!-- 등록 버튼 -->
		<div class="cm_margin_top" style="text-align: center;">
			<button class="add">등록</button>
		</div>
	
	</form>
	<!-- 상품 등록 끝 -->
			
</div>


<jsp:include page=".././footer/footer.jsp"></jsp:include>



<script>


const category_detail = {
	    "패션의류": ["남성신발", "가방/핸드백", "지갑/벨트"],
	    "패션잡화": ["여성의류", "남성의류", "패션잡화"],
	    "뷰티": ["화장품", "스킨케어", "향수"],
	    "출산/유아동": ["유아의류", "장난감", "아기용품"],
	    "모바일/태블릿": ["스마트폰", "태블릿", "악세서리"]
};

function loadSubcategories(category_name) {
    let category_detail_div = document.getElementById("category_detail");
    let category_detail_list = document.getElementById("category_detail_list");

    category_detail_div.style.display = "block"; // 하위 카테고리 표시
    category_detail_list.innerHTML = ""; // 기존 목록 초기화

    if (category_detail[category_name]) {
        category_detail[category_name].forEach(item => {
            let li = document.createElement("li");
            li.textContent = item;
            category_detail_list.appendChild(li);
        });
    }
}


</script>