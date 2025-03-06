<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="ctx_Path" value="${pageContext.request.contextPath}" />

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

.sell_item:hover {
	cursor: pointer;
}

</style>


<script>
$(document).ready(function () {
    // 상세 필터 모달 열기/닫기
    function toggleFilterModal() {
        $(".filter_modal").toggleClass("show");
    }
    $(".filter_btn").on("click", toggleFilterModal);

    // 필터 버튼 선택
    $(".filter button").on("click", function () {
        $(".filter button").removeClass("selected"); // 기존 선택 해제
        $(this).addClass("selected"); // 현재 버튼 활성화

        // 스타일 적용
        $(".filter button").css({
            "background-color": "white",
            "color": "black",
            "border": "solid 1px black"
        });
        $(this).css({
            "background-color": "rgb(13, 204, 90)",
            "color": "white",
            "border": "solid 1px rgb(13, 204, 90)"
        });
    });

    // 필터 적용 (조회 버튼 클릭)
    $(".filter_apply").on("click", function () {
        let isSelected = $(".filter button.selected").length > 0;
        if (!isSelected) {
            showAlert("error", "조회 기간을 선택해주세요."); // 선택 안 하면 알림
            return;
        } else {
        	$(".filter_modal").removeClass("show"); // 필터 모달 닫기
        	Search();
        }
    });

    // 상품 검색 엔터 키 이벤트
    $("input:text[name='search_sell']").on("keyup", function (e) {
        if (e.keyCode == 13) {
            Search();
        }
    });
    
});


    
// 상품 검색 함수
function Search() {
	
    const search_sell = $("input:text[name='search_sell']").val();
    let search_date = $(".filter button.selected").data("period");
    $.ajax({
        url: "<%= ctx_Path %>/mypage/search_list",
        type: "post",
        data: { "search_sell": search_sell,
        		"search_date": search_date},
        dataType: "json",
        success: function (json) {
            let v_html = "";
            $.each(json, function (index, item) {
                let formattedPrice = item.product_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
                v_html += `
                    <div class="sell_history">
                        <div class="sell_date">\${item.trade_confirm_date}<span style="float: right;"></span></div>
                        <div class="sell_info">
                            <span class="sell_status">판매완료</span>
                        </div>
                        <div class="sell_item" style="display: flex;" onclick="sell_list_info(this)">
                        <input type="hidden" name="pk_trade_no" value="\${item.pk_trade_no}"/>
                            <img style="width: 100px; height: 90px;" src="\${item.prod_img_name}"/>
                            <div>
                                <p class="sell_title">\${item.product_title}</p>
                                
                                <strong class="sell_price">\${formattedPrice}</strong>
                            </div>
                        </div>
                        <button class="review_btn">받은 후기</button>
                    </div>`;
            });
            $("div.search_sell_list").html(v_html); // 한 번만 업데이트
        },
        error: function () {
            showAlert("error", "해당 검색의 판매내역이 없습니다.");
        }
    });
}


// 판매 상세 조회 함수
function sell_list_info(element) {
    let pk_trade_no = $(element).closest(".sell_history").find("input:hidden[name='pk_trade_no']").val();

    console.log("pk_trade_no:", pk_trade_no);

    if (!pk_trade_no) {
        showAlert("error", "거래 번호가 없습니다.");
        return;
    }

    	var tabTitle = "판매내역 상세";
    $.ajax({
        url: "<%= ctx_Path %>/mypage/sell_list_info",
        type: "post",
        data: { "pk_trade_no": pk_trade_no },
        success: function (html) {
        	openSideTab(html, tabTitle);
        },
        error: function (xhr) {
            showAlert("error", "실패");
        }
    });
}


</script>


<div class="sell_search_container">
    <i class="fas fa-search"></i>
    <input type="text" name="search_sell" class="search_sell" placeholder="상품명을 입력해주세요.">
    <button type="button" class="filter_btn">상세필터</button>
</div>
<div class="search_sell_list">
	<c:if test="${not empty requestScope.sell_list}">
	   <c:forEach var="sell_list" items="${requestScope.sell_list}">
	    	
			<div class="sell_history">
			    <div class="sell_date">${sell_list.trade_confirm_date}<span style="float: right;"></span></div>
			    <div class="sell_info">
			        <span class="sell_status">판매완료</span>
			    </div>
			    <div class="sell_item" style="display: flex;" onclick="sell_list_info(this)">
			    <input type="hidden" name="pk_trade_no" value="${sell_list.pk_trade_no}"/>
			        <img style="width: 100px; height: 90px;" src="${sell_list.prod_img_name}"/>
			        <div>
				        <p class="sell_title">${sell_list.product_title}</p>
				        <strong class="sell_price">
						    <fmt:formatNumber value="${sell_list.product_price}" type="number" pattern="#,###" />원
						</strong>
			        </div>
			    </div>
			    <button class="review_btn">받은 후기</button>
			</div>
		</c:forEach>
	</c:if>
</div>

<c:if test="${empty requestScope.sell_list}">
	<div>판매된 상품이 없습니다.</div>
</c:if>
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
