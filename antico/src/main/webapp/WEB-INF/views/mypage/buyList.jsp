<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="ctx_Path" value="${pageContext.request.contextPath}" />

<script type="text/javascript" src="<%= ctx_Path%>/js/pointcharge.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<style>
/* 검색창 스타일 */
.sell_search_container {
    display: flex;
    align-items: center;
    gap: 8px;
    width: 100%;
}
.search_sell {
    flex: 1;
    padding: 10px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 16px;
    outline: none;
}
.search_sell:focus {
    border-color: #0F7D00;
    box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);
}
.filter_btn {
    padding: 10px 12px;
    background-color: white;
    color: black;
    border: solid 2px #eee;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    height: 46px;
}

/* 상세 필터 모달 스타일 */
.filter_modal {
    position: absolute;
    bottom: -100%; /* 초기에는 숨김 */
    left: 0;
    width: 100%;
    background: #f8f9fa;
    border-radius: 12px 12px 0 0;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
    transition: bottom 0.3s ease-in-out;
    padding: 16px;
    box-sizing: border-box;
}
.filter_content {
    text-align: center;
}
.filter_modal.show {
    bottom: 0; /* 나타날 때 위로 올라옴 */
}
.filter_apply {
    width: 100%;
    padding: 12px;
    background-color: black;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
}


.filter {
	border: solid 0px red;
	list-style-type: none;
	display: flex;
}

.filter > li > button {
	background-color: white;
	border: solid 1px black;
	border-radius: 5px;
	margin-right: 20px;
	height: 40px;
	width: 100px;
}



.sell_history {
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 12px;
    border-bottom: 1px solid #ddd;
}

.sell_date {
    font-size: 14px;
    color: #888;
}

.sell_info {
    display: flex;
    gap: 10px;
    font-size: 14px;
    font-weight: bold;
}

.sell_status {
    color: rgb(13, 204, 90);
    font-size: 16pt;
}

.sell_item {
    margin-top: 4px;
}

.sell_title {
    font-size: 16px;
    font-weight: bold;
    padding: 7px 20px 10px 20px;
    color: #aaa;
}

.sell_desc {
    font-size: 14px;
    color: #666;
}

.sell_price {
    font-size: 16px;
    font-weight: bold;
    padding: 0px 20px 20px 20px;
    color: rgb(51, 51, 51);
}

.review_btn {
    padding: 8px 12px;
    background-color: white;
    color: black;
    border: solid 2px rgb(13, 204, 90);
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}
.review_btn:hover {
    background-color: rgb(13, 204, 90);
    color: white;
}


</style>


<script>

$(document).ready(function () {
    $(".filter > li > button").click(function () {
        // 모든 버튼의 배경색을 원래대로 변경
        $(".filter > li > button").css({
            "background-color": "white",
            "color": "black",
            "border": "solid 1px black"
        });

        // 클릭한 버튼에 색상 적용
        $(this).css({
            "background-color": "rgb(13, 204, 90)",
            "color": "white",
            "border": "solid 1px rgb(13, 204, 90)"
        });
    });
});
	


document.querySelector(".filter_btn").addEventListener("click", function() {
    document.querySelector(".filter_modal").classList.toggle("show");
});

// 상품 검색 창에서 엔터 키 입력 시 검색 실행
$("input:text[name='search_sell']").on("keyup", function(e) {
    if (e.keyCode == 13) { // 엔터 키 입력 시
        goSearch();
    }
});

// 상품 검색 함수
function goSearch() {
    const frm = document.searchFrm;
    frm.method = "get";
    frm.action = "<%= ctx_Path%>/product/prodlist";
    frm.submit();
}

// 상세 필터 열기/닫기
function toggleFilter() {
    $(".filter_modal").toggleClass("active");
}

// 필터 적용하기
function applyFilter() {
    const selectedPeriod = $("input[name='filter_period']:checked").val();
    if (!selectedPeriod) {
        alert("조회 기간을 선택해주세요.");
        return;
    }

    // 필터 값 전송 (예제에서는 alert로 확인)
    alert("선택한 조회 기간: " + selectedPeriod);
    
    // 상세 필터 닫기
    $(".filter_modal").removeClass("active");
}

</script>


<!-- 검색 폼 -->
<form name="searchFrm" class="searchFrm">
    <div class="sell_search_container">
        <i class="fas fa-search"></i>
        <input type="text" name="search_sell" class="search_sell" placeholder="상품명을 입력해주세요.">
        <button type="button" class="filter_btn">상세필터</button>
    </div>
</form>

<div class="sell_history">
    <div class="sell_date">2025.02.03</div>
    <div class="sell_info">
        <span class="sell_status">구매완료</span>
    </div>
    <div class="sell_item" style="display: flex;">
        <img style="width: 100px; height: 90px;" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKCArbr29NHQngi50AsC43HYLsVrSiLfb5jA&s"/>
        <div>
	        <p class="sell_title">이모티콘 팔아요</p>
	        <strong class="sell_price">원</strong>
        </div>
    </div>
    <button class="review_btn">보낸 후기</button>
</div>

<!-- 상세 필터 모달 -->
<div class="filter_modal">
    <div class="filter_content">
        <h5>상세필터</h5>
        <h6>조회기간</h6>
        <ul class="filter">
            <li><button type="button" data-period="1year">최근 1년</button></li>
            <li><button type="button" data-period="1week">1주일</button></li>
            <li><button type="button" data-period="1month">1개월</button></li>
            <li><button type="button" data-period="3months">3개월</button></li>
            <li><button type="button" data-period="6months">6개월</button></li>
        </ul>
        <p style="color: #bbb;">▪︎ 최근 1년 이내의 거래내역만 노출됩니다</p>
        <button type="button" class="filter_apply">조회하기</button>
    </div>
</div>
