<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<style>
div.container {
	padding: 10px 50px;
}

.main {
  display: flex;
  width: 70%;   
  margin: 0 auto;
}

.sidebar {
	width: 230px;
	padding: 20px;
	border-radius: 8px;
}

.sidebar h2, .sidebar h3 {
	margin-bottom: 10px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
	font-size: 13px;
	font-weight: 530;
	letter-spacing: -0.5px;
}

.sidebar ul li {
	margin-bottom: 10px;
	padding-top: 2px;
}

.sidebar ul li a {
	text-decoration: none;
	color: #333;
}

.sidebar ul li:hover {
    transform: translateX(5px); /* 오른쪽으로 5px 이동 */
    transition: transform 0.2s ease-in-out; /* 부드러운 애니메이션 */
    font-weight: bold;
}

.content {
	flex: 1;
	padding: 20px;
}

.profile-section {
	padding: 20px 0px 20px 0;
	border-radius: 8px;
}

.stats-section {
	width: 100%;
	display: grid;
	height: 55%;
	margin-top: 37px;
	padding: 20px 30px 0px 30px;
	border-radius: 5px;
	grid-template-columns: 1fr 1fr 1fr;
	border: solid 1px #eee;
}

.stat-box {
	position: relative;
	flex: 1;
	padding: 10px;
	text-align: center;
	align-items: center;
	justify-content: center;
}

.stat-box::after {
	content: "";
	position: absolute;
	top: 50%;
	transform: translate(0px, -50%);
	right: 0px;
	width: 1px;
	height: 40px;
	background-color: #eee;
}

.stat-box:last-child::after {
	content: "";
	position: absolute;
	top: 0px;
	width: 0px;
	height: 0px;
}

.stat-box p {
	color: grey;
	font-size: 10pt;
	margin-bottom: 5px;
}

.stat-box span {
	font-weight: bold;
	font-size: 16pt;
}

.point {
	background: white;
	padding: 5px 0 0 0;
	height: 100px;
	margin-top: 28px;
	border-radius: 5px;
	border: solid 1px #eee;
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

.modal-content {
	background: white;
	padding: 20px;
	display: flex;
	flex-direction: column;
	gap: 10px;
	text-align: center;
}

.share-btn-arrow {
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

.share-btn-arrow:hover {
	background: #f0f0f0;
}

.share-option {
	border: solid 0px red;
	background-color: white;
}

.close-btn { /* 공유하기 닫기버튼 */
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
.score-level {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.trust-bar {
	width: 100%;
	background-color: #ddd;
	height: 8px;
	border-radius: 4px;
	margin: 5px 0;
}

.trust-progress {
	height: 100%;
	background-color: #4CAF50; /* 초록색 */
	border-radius: 4px;
}


.product-nav button{
	position: relative;
	font-size: 12pt;
	padding:12px 16px;
	color: black;
}
.product-nav button:hover{
	 text-decoration-line: none;
	 color: black;
}


@media (min-width: 1280px) {
  .product-nav button {
    font-size: 12pt;
	padding:12px 16px;
  }
}

@media (max-width: 1279px) {
  .product-nav button {
    font-size: 10pt;
	padding:6px 12px;
  }
}


.product-nav button::after{
	width: 0px;
	content: "";
	position: absolute;
	bottom: -18px; 
	left: 0;
	border-top: 2px solid black; 
	transform:translateX(-100%);
}
.product-nav button:hover::after {
	width:100%;
	transform:translateX(0%);
	transition: width 0.45s;

}


.product-nav button{
	background-color: white;
	border: solid 0px red;
	margin-left: 80px;
	padding-top: 20px;
	
}
.product-nav {
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
</script>

<jsp:include page=".././header/header.jsp" />

<div class="container" style="display: flex;">
	<!-- 사이드바 -->
	<aside class="sidebar">
		<h4 style="font-weight: bold;">마이 페이지</h4>
		<br>
		<h5 style="font-weight: bold;">거래 정보</h5>
		<ul>
			<li><a href="#">판매내역</a></li>
			<li><a href="#">구매내역</a></li>
			<li><a href="#">택배</a></li>
			<li><a href="#">찜한 상품</a></li>
		</ul>
		<hr>
		<h5 style="font-weight: bold;">내 정보</h5>
		<ul>
			<li><a href="#">계좌 관리</a></li>
			<li><a href="#">배송지 관리</a></li>
			<li><a href="#">거래 후기</a></li>
			<li><a href="#">탈퇴하기</a></li>
		</ul>
	</aside>

	<!-- 메인 콘텐츠 -->
	<div class="main">
		<!-- div1 -->
		<div style="width: 100%;">
			<!-- div2 -->
			<div
				style="display: flex; justify-content: space-between; width: 100%;">
				<!-- 왼쪽 profile-section -->
				<section class="profile-section" style="flex: 1;">
					<div class="profile-header" style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
						<h4 style="font-weight: bold;">닉네임</h4>
						<button class="share-btn-arrow" onclick="openShareModal()">
							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
                                <path fill="currentColor" d="M18 7l-6-6-6 6h4v6h4V7h4z" />
                            </svg>
						</button>
					</div>
					<p style="font-size: 13px; color: gray; padding-top: 12px; letter-spacing: -0.5px;">
						앱에서 가게 소개 작성하고 신뢰도를 높여 보세요.</p>
					<section class="stats-section">
						<div class="stat-box">
							<p>안전거래</p>
							<span>1</span>
						</div>
						<div class="stat-box">
							<p>거래후기</p>
							<span style="text-decoration: underline;">1</span>
						</div>
						<div class="stat-box">
							<p>단골</p>
							<span>0</span>
						</div>
					</section>
				</section>

				<div style="flex: 1; padding-left: 20px;">

					<!-- 점수 막대기 -->
					<div class="stat-box score-level mt-2">
						<p style="font-weight: bold;">스코어</p>
						<div class="trust-bar">
							<div class="trust-progress" style="width: 75%;"></div>
						</div>
						<span>75%</span>
						<!-- 예시 퍼센트 -->
					</div>

					<!-- auto-register -->
					<section class="point" style=" text-align: right;">
						<h5 style="font-weight: bold; text-align: left; padding-left: 10px; padding-top: 5px;">내 포인트</h5>
						<button class="btn">
						    <fmt:formatNumber value="${pointValue}" pattern="#,###" style="text-align:right;"/>포인트 들어올거임<span style="font-size: 22pt; font-weight: bold; color: #7A9E23;"> P</span>
						</button>
					</section>
				</div>
			</div>

			<!-- div2 아래, div1 내부 -->
			<div>
				<section class="my-products mt-5">
					<h4 style="font-weight: bold;">내 상품</h4>
					<nav class="product-nav">
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
										<img src="/CLARETe/images/${pvoList.p_image}"
											style="width: 100%; display: block;">
									</div>
									<div class="cardname">${pvoList.p_name}</div>
									<div class="cardprice">
										<span><fmt:formatNumber value="${pvoList.p_price}"
												type="number" groupingUsed="true"></fmt:formatNumber> </span><span>원</span>
									</div>
							</a>
							</li>
						</c:forEach>
					</c:if>
				</ul>

				<c:if test="${empty requestScope.pvoList}">
					<div class="mypage_contants_bottom">
						<div class="recent-orders-box">
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
	<div class="modal-content" style="width: 25%;">
		<h4 style="font-weight: bold;">공유하기</h4>
		<div style="width: 100%; display: flex; justify-content: center; align-items: center; gap: 20px;">
		    <button class="share-option" onclick="shareToFacebook()">
		        <img src="https://dbdzm869oupei.cloudfront.net/img/sticker/preview/26354.png" width="64" height="64" style="border-radius: 50%;">
		    </button>
		    <button class="share-option" onclick="copyUrl()">
		        <img src="https://beosyong.com/img/mypage_link.png" width="64" height="64">
		    </button>
		</div>
		<button class="close-btn" onclick="closeShareModal()" style="align-self: center;">닫기</button>
	</div>
</div>

<jsp:include page=".././footer/footer.jsp" />
