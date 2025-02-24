<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="ctx_Path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="<%= ctx_Path%>/js/pointcharge.js"></script>

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

</style>



<script>
	
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
	
</script>

<jsp:include page=".././header/header.jsp" />

<div class="container" style="display: flex;">

	<!-- 메인 콘텐츠 -->
	<div class="main">
		<!-- div1 -->
		<div style="width: 100%;">
			<!-- div2 -->
			<div
				style="display: flex; justify-content: space-between; width: 100%;">
				<!-- 왼쪽 profile_section -->
				<section class="profile_section" style="flex: 1;">
					<div class="profile_header" style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
						<h4 class="name" style="font-weight: bold;">${requestScope.member_name}</h4>
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
							<p>안전거래</p>
							<span>1</span>
						</div>
						<div class="stat_box">
							<p>거래후기</p>
							<a href="#" onclick="myreview()" style="text-decoration: underline;">1</a>
						</div>
						<div class="stat_box">
							<p>단골</p>
							<span>0</span>
						</div>
					</section>
				</section>

				<div style="flex: 1; padding-left: 20px;">

					<!-- 점수 막대기 -->
					<div class="stat_box score_level mt-2">
						<p style="font-weight: bold; color: ${requestScope.role_color};">${requestScope.member_role}</p>
						<div class="trust_bar">
							<div class="trust_progress" style="width: ${requestScope.data/10}%; background-color:${requestScope.role_color};"></div>
						</div>
						<span>${requestScope.data}</span>
					</div>
				</div>
			</div>

			<!-- div2 아래, div1 내부 -->
			<div>
				<section class="my_products mt-5">
					<h4 style="font-weight: bold;">내 상품</h4>
					<nav class="product_nav">
						<button>전체</button> <button>판매중</button> <button>예약중</button><button>판매완료</button>
					</nav>
					<br>
					<span>총 2개</span><span class="orderby"><button>최신순</button><button>낮은가격순</button><button>높은가격순</button></span>
				</section>

				<!-- 상품 목록 -->
				<ul class="cardcontainer">
					<c:if test="${not empty requestScope.pvoList}">
						<c:forEach var="pvoList" items="${requestScope.pvoList}">
							<li class="cardbox" style="width: 100%; list-style: none;">
								<a href="/CLARETe/shop/prodView.cl?p_num=${pvoList.p_num}">
									<div class="cardimg">
										<img src="/CLARETe/images/${pvoList.p_image}" style="width: 100%; display: block;">
									</div>
									<div class="cardname">${pvoList.p_name}</div>
									<div class="cardprice">
										<span><fmt:formatNumber value="${pvoList.p_price}" type="number" groupingUsed="true"></fmt:formatNumber> </span><span>원</span>
									</div>
								</a>
							</li>
						</c:forEach>
					</c:if>
				</ul>

				<c:if test="${empty requestScope.pvoList}">
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


<jsp:include page="../tab/tab.jsp"></jsp:include>
