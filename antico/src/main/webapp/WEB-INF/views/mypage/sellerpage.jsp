<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="ctx_Path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<c:set var="review_count" value="${requestScope.review_count}" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="<%= ctx_Path%>/js/pointcharge.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>

div.container {
	padding: 10px 50px;
}

.main {
  display: flex;
  width: 100%;   
  margin: 0 auto;
}

.content {
	flex: 1;
	padding: 20px;
}

.profile_section {
	padding: 20px 0px 20px 0;
	border-radius: 8px;
}

.stats_section {
	width: 100%;
	display: grid;
	height: 55%;
	margin-top: 37px;
	padding: 20px 30px 0px 30px;
	border-radius: 5px;
	grid-template-columns: 1fr 1fr 1fr;
	border: solid 1px #eee;
}

.stat_box {
	position: relative;
	flex: 1;
	padding: 10px;
	text-align: center;
	align-items: center;
	justify-content: center;
}

.stat_box::after {
	content: "";
	position: absolute;
	top: 50%;
	transform: translate(0px, -50%);
	right: 0px;
	width: 1px;
	height: 40px;
	background-color: #eee;
}

.stat_box:last-child::after {
	content: "";
	position: absolute;
	top: 0px;
	width: 0px;
	height: 0px;
}

.stat_box p {
	color: grey;
	font-size: 10pt;
	margin-bottom: 5px;
}

.stat_box span {
	font-weight: bold;
	font-size: 16pt;
}
.stat_box a {
	font-weight: bold;
	font-size: 16pt;
	color: black;
}
.stat_box a:hover {
	color: green;
}



hr {
	border: none;
	border-top: 1px solid #ddd; /* 연한 회색 실선 */
	margin: 10px 0;
	width: 80%;
}


/* 공유 버튼 스타일 */
.share-btn {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 10px 16px;
	border: 1px solid #ccc;
	border-radius: 25px;
	background: white;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.3s;
}

.share-btn:hover {
	background: #f0f0f0;
}

/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 배경 투명화 */
	justify-content: center;
	align-items: center;
}

.modal_content {
	background: white;
	padding: 20px;
	display: flex;
	flex-direction: column;
	gap: 10px;
	text-align: center;
}

.share_btn_arrow {
	justify-content: center;
	align-items: center;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 8px;
	background: white;
	cursor: pointer;
	font-size: 16px;
	transition: background 0.3s;
}

.share_btn_arrow:hover {
	background: #f0f0f0;
}

.share_option {
	border: solid 0px red;
	background-color: white;
}

.close_btn { /* 공유하기 닫기버튼 */
	width: 100%;
	height: 48px;
	background-color: #000;
	color: #fff;
	border-radius: 3px;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 내 상품 */
.cardcontainer {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	gap: calc(2vw);
}

.cardbox {
	width: 100%;
	height: auto;
	/* background-color: #dbdbdb; */
	transition: all 0.5s;
}

.cardbox:hover {
	transform: translateY(-0.5208vw);
}

.cardimg {
	width: 100%;
	aspect-ratio: 1/1;
	object-fit: cover;
	background-color: #f1f1f1;
}

.cardname {
	font-size: clamp(16px, 0.8333vw, 200px);
	text-align: center;
}

.cardprice {
	font-size: clamp(16px, 0.8333vw, 200px);
	text-align: center;
}

.cartgo {
	width: clamp(180px, 10.4167vw, 1000px);
	height: clamp(50px, 3.1250vw, 1000px);
	font-size: clamp(16px, 0.8333vw, 200px);
	border-radius: 8px;
	background-color: #000;
	color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	box-sizing: border-box;
	transition: all 0.5s;
}

.cartgo:hover {
	border: 1px solid #000;
	background-color: #fff;
	color: #000;
	box-sizing: border-box;
}

.cartbox {
	width: 100%;
	min-width: 600px;
	height: auto;
	border: 0px solid green;
	margin: 5.2083vw auto;
	display: flex;
}

.cartbox>div {
	margin: auto;
}

.leftdiv {
	display: block;
	width: 16%;
}

@media ( max-width : 1279px) {
	.cardcontainer {
		grid-template-columns: 1fr 1fr;
	}
	.leftdiv {
		display: none;
	}
	.cartbox {
		width: 100%;
	}
	.cartbox>div:nth-child(2) {
		width: 100%;
		margin: auto;
	}
}

@media ( min-width : 1280px) {
	.cardcontainer {
		grid-template-columns: 1fr;
	}
}

/* 신뢰지수 막대기 */
.score_level {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.trust_bar {
	width: 100%;
	background-color: #ddd;
	height: 8px;
	border-radius: 4px;
	margin: 5px 0;
}

.trust_progress {
	height: 100%;
	border-radius: 4px;
}


.product_nav button{
	position: relative;
	font-size: 12pt;
	padding:12px 16px;
	color: black;
}
.product_nav button:hover{
	 text-decoration-line: none;
	 color: black;
}


@media (min-width: 1280px) {
  .product_nav button {
    font-size: 12pt;
	padding:12px 16px;
  }
}

@media (max-width: 1279px) {
  .product_nav button {
    font-size: 10pt;
	padding:6px 12px;
  }
}


.product_nav button::after{
	width: 0px;
	content: "";
	position: absolute;
	bottom: -18px; 
	left: 0;
	border-top: 2px solid black; 
	transform:translateX(-100%);
}
.product_nav button:hover::after {
	width:100%;
	transform:translateX(0%);
	transition: width 0.45s;

}


.product_nav button{
	background-color: white;
	border: solid 0px red;
	margin-left: 80px;
	padding-top: 20px;
	
}
.product_nav {
    border-bottom: 2px solid #eee;
    padding-bottom: 17px;
}

.orderby button {
	background-color: white;
	float: right;
	border: solid 0px;
	text-align: center;
	border-right: solid 1px #E0E0E0;
	margin-left: 4px;
	font-size: 10pt;
	color: gray;
}
.orderby button:hover {
	color: black;
}
.orderby button:first-child {
	border: solid 0px;
}



.product_list {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
 }
 .product_item {
     width: calc(25% - 10px);
     box-sizing: border-box;
     position: relative;
 }
 .product_link {
     color: black;
     text-decoration: none;
     display: block;
     padding: 8px;
 }
 .cardimg {
     width: 100%;
     height: 50%;
     overflow: hidden;
     display: flex;
     justify-content: center;
     align-items: center;
 }
 .product_img {
     width: 100%;
     height: 100%;
     object-fit: cover;
     display: block;
 }
 .product_date {
     font-size: 10pt;
     color: #aaa;
 }
 
.overlay {
    position: absolute;
    top: 8px;
    bottom: 0;
    left: 8px;
    width: 90%;  /* 이미지 크기만큼 */
    height: 50%;  /* 이미지 크기만큼 */
    background-color: rgba(128, 128, 128, 0.5);  /* 기본 회색 오버레이 */
    display: none;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 18px;
    font-weight: bold;
}

.overlay.reservation {
    background-color: rgba(128, 128, 128, 0.7);  /* 예약중 상태 오버레이 */
}

.overlay.soldout {
    background-color: rgba(169, 169, 169, 0.7);  /* 판매완료 상태 오버레이 */
}
 
 .cardname:hover {
 	color: green;
 }


</style>



<script>
$(document).ready(function() {
	// 상품 등록일자 계산 해주기
    $("span.product_date").each(function() {
        const product_reg_date = $(this).attr('data-date'); // 등록일
        const time = timeAgo(product_reg_date); 	  		// 함수 통해 시간 형식 변환
        $(this).text(time);								    // 텍스트로 출력
    }); // end of $("span.product_time").each(function()
});

    
//등록일 계산 해주는 함수
function timeAgo(reg_date) {
    const now = new Date(); 					 // 현재 시간
    const product_reg_date = new Date(reg_date); // 상품 등록일
    
    const second = Math.floor((now - product_reg_date) / 1000); // 두 날짜 차이를 초 단위로 계산
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


	//모달 열기
	function openShareModal() {
		document.getElementById("shareModal").style.display = "flex";
	}

	//모달 닫기
	function closeShareModal() {
		document.getElementById("shareModal").style.display = "none";
	}
	
	// URL 복사
	function copyUrl() {
		let url = '';
		let textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		url = window.document.location.href;
		textarea.value = url;
		textarea.select();
		document.execCommand("copy");
		document.body.removeChild(textarea);
		showAlert('success', 'URL 복사완료');
	}
	
	// 인스타공유
	function shareToInsta() {
		window.open("https://www.instagram.com/accounts/login/", "_blank");
	}
	
	
	// 카카오톡 공유하기 openApi 
    Kakao.init('${requestScope.kakao_api_key}');
    console.log(Kakao.isInitialized()); // 초기화 확인

    function shareToKakao() {
        let currentURL = window.location.href; // 현재 페이지 URL 가져오기

        Kakao.Link.sendDefault({
            objectType: 'text', // 텍스트 형식
            text: '이 링크를 확인해 보세요!\n' + currentURL, // 공유할 URL
            link: {
                mobileWebUrl: currentURL,
                webUrl: currentURL,
            },
        });
    }
	
    
    function filterProducts(status) {
        const productItems = document.querySelectorAll('.product_item');
        
        productItems.forEach(item => {
        	const saleStatus = item.querySelector('input[type="hidden"]').value;
            const sale = ${sale_count.sale}; 
            const reserved = ${sale_count.reserved}; 
            const submit = ${sale_count.submit}; 
            const total_count = ${requestScope.list_size};
            let count = 0; // 필터링된 개수            
            // 전체 버튼(0)은 모든 항목을 보여줌
            if (status == 0) {
                item.style.display = 'block';
                count = total_count;
            }
            // 판매중 버튼(0)일 경우, sale_status가 0인 항목만 표시
            else if (status == 1 && saleStatus == 0) {
                item.style.display = 'block';
                count = sale;
            }
            // 예약중 버튼(1)일 경우, sale_status가 1인 항목만 표시
            else if (status == 2 && saleStatus == 1) {
                item.style.display = 'block';
                count = reserved;
            }
            // 판매완료 버튼(2)일 경우, sale_status가 2인 항목만 표시
            else if (status == 3 && saleStatus == 2) {
                item.style.display = 'block';
				count = submit;
            }
            // 조건에 맞지 않으면 숨김
            else {
                item.style.display = 'none';
            }
            $("span#list_count").html(count);
        });
    }

    
    
 // 정렬하기
    document.addEventListener('DOMContentLoaded', function() {
        const buttonDesc = document.querySelector('button#desc');  // 최신순 버튼
        const buttonPrice = document.querySelector('button#highPrice');  // 높은가격순 버튼
        const buttonLowPrice = document.querySelector('button#lowPrice');  // 낮은가격순 버튼
        
        if (buttonDesc) {
            buttonDesc.addEventListener('click', desc);
        }
        if (buttonPrice) {
            buttonPrice.addEventListener('click', highPrice);
        }
        if (buttonLowPrice) {
            buttonLowPrice.addEventListener('click', lowPrice);
        }
    });

    function desc() {
        const product_list = document.getElementById('product_list');
        if (!product_list) {
            console.error('product_list 요소를 찾을 수 없습니다.');
            return;
        }

        const items = Array.from(product_list.getElementsByClassName('product_item'));
        
        // 날짜를 기준으로 내림차순 정렬
        items.sort((a, b) => {
            const dateA = new Date(a.querySelector('.product_date').getAttribute('data-date'));
            const dateB = new Date(b.querySelector('.product_date').getAttribute('data-date'));
            return dateB - dateA;
        });

        // 정렬된 항목들을 다시 리스트에 추가
        items.forEach(item => product_list.appendChild(item));
    }


    function highPrice() {
        const product_list = document.getElementById('product_list');
        if (!product_list) {
            console.error('product_list 요소를 찾을 수 없습니다.');
            return;
        }

        const items = Array.from(product_list.getElementsByClassName('product_item'));
        
        // 가격을 기준으로 내림차순 정렬
        items.sort((a, b) => {
            const priceA = parseInt(a.querySelector('.cardprice span').textContent.replace(/[^0-9]/g, ''), 10);
            const priceB = parseInt(b.querySelector('.cardprice span').textContent.replace(/[^0-9]/g, ''), 10);
            return priceB - priceA;  // 높은 가격순으로 정렬
        });
        
        // 정렬된 항목들을 다시 리스트에 추가
        items.forEach(item => product_list.appendChild(item));
    }

    function lowPrice() {
        const product_list = document.getElementById('product_list');
        if (!product_list) {
            console.error('product_list 요소를 찾을 수 없습니다.');
            return;
        }

        const items = Array.from(product_list.getElementsByClassName('product_item'));
        
        // 가격을 기준으로 오름차순 정렬
        items.sort((a, b) => {
            const priceA = parseInt(a.querySelector('.cardprice span').textContent.replace(/[^0-9]/g, ''), 10);
            const priceB = parseInt(b.querySelector('.cardprice span').textContent.replace(/[^0-9]/g, ''), 10);
            return priceA - priceB;  // 낮은 가격순으로 정렬
        });
        
        // 정렬된 항목들을 다시 리스트에 추가
        items.forEach(item => product_list.appendChild(item));
    }
    
    
    
    document.addEventListener("DOMContentLoaded", function() {
        const productItems = document.querySelectorAll('.product_item');
        
        productItems.forEach(item => {
            const saleStatus = item.querySelector('.sale_status').value;
            const overlay = item.querySelector('.overlay');

            if (saleStatus == '1') {  // 예약중
                overlay.classList.add('reservation');
                overlay.style.display = 'flex'; // 예약중 오버레이 표시
                overlay.textContent = '예약중';
            } else if (saleStatus == '2') {  // 판매완료
                overlay.classList.add('soldout');
                overlay.style.display = 'flex'; // 판매완료 오버레이 표시
                overlay.textContent = '판매완료';
            }
        });
    });

	// 거래 후기 클릭시
	function sellerReview() {
		$.ajax({
			url : "<%=ctx_Path%>/review/",
			data : {
				"pk_member_no" : "${requestScope.mvo}"
			},
			success : function(html) {
				openSideTab(html, "거래 후기");
			},
			error : function(request, status, error) {
				errorHandler(request, status, error);
			}
		});
	}

</script>

<jsp:include page=".././header/header.jsp" />

<div class="container" style="display: flex;">

	<!-- 메인 콘텐츠 -->
	<div class="main">
		<!-- div1 -->
		<div style="width: 100%;">
			<!-- div2 -->
				<div style="display: flex; justify-content: space-between; width: 100%;">
					<!-- 왼쪽 profile_section -->
					<section class="profile_section" style="flex: 1;">
						<div class="profile_header" style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
							<h4 class="name" style="font-weight: bold;">${requestScope.seller_name}</h4>
							<button class="share_btn_arrow" onclick="openShareModal()">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
	                                <path fill="currentColor" d="M18 7l-6-6-6 6h4v6h4V7h4z" />
	                            </svg>
							</button>
						</div>
						<p style="font-size: 13px; color: gray; padding-top: 12px; letter-spacing: -0.5px;">
							앱에서 가게 소개 작성하고 신뢰도를 높여 보세요.</p>
						<section class="stats_section">
							<div class="stat_box">
								<p>거래횟수</p>
								<span>${requestScope.trade_map.trade_cnt}</span>
							</div>
							<div class="stat_box">
								<p>거래후기</p>
								<a href="#" onclick="sellerReview()" style="text-decoration: underline;">${review_count}</a>
							</div>
							<div class="stat_box">
								<p>단골</p>
								<span>${requestScope.trade_map.vip_consumber}</span>
							</div>
						</section>
					</section>
	
					<div style="flex: 1; padding-left: 20px;">
	
						<!-- 점수 막대기 -->
						<div class="stat_box score_level mt-2">
							<p style="font-weight: bold; color: ${requestScope.seller_role_color};">${requestScope.seller_role}</p>
							<div class="trust_bar">
								<div class="trust_progress" style="width: ${seller_info.member_score > 3000 ? 100 : seller_info.member_score / 30}%; background-color:${requestScope.seller_role_color};"></div>
							</div>
							<span>${seller_info.member_score}</span>
						</div>
					</div>
				</div>
			<!-- div2 아래, div1 내부 -->
			<div>
				<section class="my_products mt-5">
					<h4 style="font-weight: bold;">판매상품</h4>
					<nav class="product_nav">
						<button class="all_prod" onclick="filterProducts(0)">전체</button>
						<button class="on_sale" onclick="filterProducts(1)">판매중</button>
						<button class="reservation" onclick="filterProducts(2)">예약중</button>
						<button class="soldout" onclick="filterProducts(3)">판매완료</button>
					</nav>
					<br>
					<span>총 <span id="list_count">${requestScope.list_size}</span>개</span><span class="orderby"><span class="orderby"><button id="highPrice" onclick="highPrice()">높은가격순</button><button id="lowPrice" onclick="lowPrice()">낮은가격순</button><button id="desc" onclick="desc()">최신순</button></span>
				</section>

				<!-- 상품 목록 -->
				<div style="width: 100%;">
				    <c:if test="${not empty requestScope.myproduct_list}">
				         <ul id="product_list" class="product_list">
				            <c:forEach var="pvoList" items="${requestScope.myproduct_list}">
				               <li class="product_item">
								    <a href="<%= ctx_Path%>/product/prod_detail/${pvoList.pk_product_no}" class="product_link">
								        <div class="cardimg">
								            <img src="${pvoList.prod_img_name}" alt="상품 이미지" class="product_img">
								            <div class="overlay"></div>
								        </div>
								        <div class="cardname">${pvoList.product_title}</div>
								        <div class="cardprice">
								            <span><fmt:formatNumber value="${pvoList.product_price}" type="number" groupingUsed="true"/></span>
								            <span class="money"></span>원
								        </div>
								        <span class="product_date" data-date="${pvoList.product_update_date}"></span>
								        <input type="hidden" value="${pvoList.product_sale_status}" class="sale_status"/>
								    </a>
								</li>
				                        <input type="hidden" name="prod_orderby" value="${pvoList.fk_member_no}"/>
				            </c:forEach>
				        </ul>
				    </c:if>
				</div>
				<c:if test="${empty requestScope.myproduct_list}">
					<div class="mypage_contants_bottom">
						<div class="none_product">
							<div>선택된 조건에 해당하는 상품이 없습니다.</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>

<!-- 공유 모달 -->
<div id="shareModal" class="modal">
	<div class="modal_content" style="width: 25%;">
		<h4 style="font-weight: bold;">공유하기</h4>
		<div style="width: 100%; display: flex; justify-content: center; align-items: center; gap: 20px;">
		    <button class="share_option" onclick="shareToInsta()">
		        <img src="https://dbdzm869oupei.cloudfront.net/img/sticker/preview/26354.png" width="64" height="64" style="border-radius: 50%;">
		    </button>
		    <button class="share_option" onclick="shareToKakao()">
		        <img src="https://blog.kakaocdn.net/dn/dMWSyr/btq5R2rw7Rf/3CyUtcWWWQkKVZDdKiQ46K/img.png" width="64" height="64" style="border-radius: 50%;">
		    </button>
		    <button class="share_option" onclick="copyUrl()">
		        <img src="https://beosyong.com/img/mypage_link.png" width="64" height="64">
		    </button>
		</div>
		<button class="close_btn" onclick="closeShareModal()" style="align-self: center;">닫기</button>
	</div>
</div>

<jsp:include page=".././footer/footer.jsp" />

