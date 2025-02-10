<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<style>
div.container {
    padding: 10px 50px;
}

.main {
    display: flex;
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
.content {
    flex: 1;
    padding: 20px;
}
.profile-section {
    padding: 20px 20px 20px 0;
    border-radius: 8px;
}
.stats-section {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}
.stat-box {
    flex: 1;
    background: #f1f3f5;
    padding: 15px;
    text-align: center;
    border-radius: 8px;
}
.auto-register {
    background: #e9f7ef;
    padding: 20px;
    margin-top: 20px;
    border-radius: 8px;
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
}

.modal-content {
    background: white;
    padding: 12px;
    border-radius: 50%;
    display: flex;
    flex-direction: column;
    gap: 10px;
    text-align: center;
    display: flex;
    justify-content: center; /* 수평 중앙 */
    align-items: center; /* 수직 중앙 */
}
.share-btn-arrow {
        display: flex;
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

    <div class="main">
        <main>
            <section class="profile-section">
                <h4 style="font-weight: bold;">닉네임</h4>
                <p style="font-size: 13px; color: gray; padding-top: 12px; letter-spacing: -0.5px;">앱에서 가게 소개 작성하고 신뢰도를 높여 보세요.</p>
                
                <!-- 공유 버튼 -->
				<button class="share-btn-arrow" onclick="openShareModal()">
				    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
				        <path fill="currentColor" d="M18 7l-6-6-6 6h4v6h4V7h4z"/>
				    </svg>
				</button>
                
                <!-- 공유 모달 -->
                <div id="shareModal" class="modal" style="width: 25%; height: 25%; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                    <div class="modal-content" style="border-radius: 6%;">
                        <button class="share-option" onclick="shareToFacebook()">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg" width="32" height="32" alt="Facebook">
                            페이스북
                        </button>
                        <button class="share-option" onclick="copyUrl()">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24">
                                <path fill="currentColor" d="M16 1H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h2v2H4v2h4v-4H4V3h12v5h2V3a2 2 0 0 0-2-2Zm-3 6v2h2V7h-2ZM6 7v2h2V7H6Zm10 10H10a2 2 0 0 0-2 2v4h2v-4h6v4h2v-4a2 2 0 0 0-2-2Zm-4-8v2h2V9h-2Z"/>
                            </svg>
                            URL 복사
                        </button>
                        <button class="close-btn" onclick="closeShareModal()">닫기</button>
                    </div>
                </div>

            </section>

            <section class="stats-section">
                <div class="stat-box">
                    <p>안전거래</p>
                    <span>1</span>
                </div>
                <div class="stat-box">
                    <p>거래후기</p>
                    <span>1</span>
                </div>
                <div class="stat-box">
                    <p>단골</p>
                    <span>0</span>
                </div>
                <div class="stat-box">
                    <p>에코마일</p>
                    <span>0M</span>
                </div>
            </section>

            <section class="auto-register">
                <h3>카페에 상품 자동 등록하기</h3>
                <p>웹에서 상품 등록시 카페에도 자동 등록이 가능해요</p>
                <button class="btn">등록하기</button>
            </section>

            <section class="my-products">
                <h2>내 상품</h2>
                <nav class="product-nav">
                    <a href="#">전체</a>
                    <a href="#">판매중</a>
                    <a href="#">예약중</a>
                    <a href="#">판매완료</a>
                </nav>
                <p>총 2개</p>
            </section>
        </main>
    </div>
</div>

<jsp:include page=".././footer/footer.jsp" />
