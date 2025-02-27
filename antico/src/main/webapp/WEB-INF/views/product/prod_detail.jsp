<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<% String ctxPath = request.getContextPath(); %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}" />

<%-- 상품 map --%>
<c:set var="product_map" value="${requestScope.product_map}" />

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="fk_member_no" value="${requestScope.fk_member_no}" />

<jsp:include page=".././header/header.jsp"></jsp:include>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<style type="text/css">

div#container {
	width: 60%;
	margin: 0 auto;
}

div#prod_info_container {
	text-align: center;
	justify-content: space-between;
	width: 100%;
	margin-top: 80px;
}

div.img_div {
    width: 100%; /* 부모에 맞춰 크기 조정 */
    position: relative;
    padding-bottom: 100%; /* 1:1 비율 유지 */
}

img#prod_img {
    object-fit: cover; /* 이미지가 부모의 크기에 맞춰지도록 자르기 */
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    display: block; /* 여백 제거 */
    border-radius: 6px;
}


/* 캐러셀 화살표 아이콘 */
a.carousel-control-prev {
    margin-right: 40px;
}

a.carousel-control-next {
	margin-left: 40px;
}


div#prod_info {
	margin-left: 50px;
}

div#category_info {
	text-align: left;
}

span.prod_category {
	cursor: pointer;
	font-size: 10pt;
}

span.greater {
	font-size: 10pt;
}

div#title_info {
	display: flex;
	margin-top: 10px;
	justify-content: space-between;
	align-items: center;
}

span#product_title {
	font-size: 16pt;
	font-weight: 500;
}

i#share {
	font-size: 12pt;
	text-align: right;
	cursor: pointer;
}

div#price_info {
	text-align: left;
	font-size: 18pt;
	font-weight: bold;
	margin-top: 10px;
}


div#time_view_info {
	text-align: left;
	margin-top: 10px;
	font-size: 10pt;
	color: #999999;
}

div#status_region_info,
div#buyer_setting {
	margin-top: 20px;
	height: 80px;
	border: solid 1px #dee2e6;
	border-radius: 6px;
	display: flex;
	flex-direction: column;
    justify-content: center;
}

ul#status_region_info_ul,
ul#buyer_setting_ul {
	list-style-type: none;
	padding-left: 0px;
	margin-bottom: 0px;
	display: flex;
}

li.status, li.region, li.sale_status,
li.reg_update, li.prod_upate, li.sale_status_upate, li.prod_delete {
	display: flex; 
	flex-direction: column;
	margin-right: 10px;
	align-items: center;
	width: 100px;
}

li.reg_update, li.prod_upate, li.sale_status_upate, li.prod_delete {
	cursor: pointer;
}

li.bar {
	border: solid 1px #dee2e6;
}

span.status_title, span.region_title, span.sale_status_title {
	font-size: 8pt;
	color: #999999;
}

span.reg_update_title, span.prod_upate_title, span.sale_status_upate_title, span.prod_delete_title {
	font-size: 10pt;
	color: #999999;
}

span.status, span.region, span.sale_status,
span.reg_update, span.prod_upate, span.sale_status_upate, span.prod_delete {
	font-size: 10pt;
	font-weight: bold;
}

span.sale_status {
	color: #0DCC5A;
}

div#button {
	margin-top: 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

i#wish {
	font-size: 20pt;
	margin-right: 20px;
	color: #0DCC5A;
}

button#chat {
	border: solid 1px #cccccc;
	border-radius: 6px;
	background-color: white;
	color: black;
	height: 50px;
	width: 100%;
	margin-right: 20px;
}

button#buy {
	border: none;
	border-radius: 6px;
	background-color: black;
	color: white;
	height: 50px;
	width: 100%;
}


div#detail_info_container {
	justify-content: space-between;
	width: 100%;
	margin-top: 80px;
	display: flex;
	gap: 20px; 
}


div#prod_detail {
	height: auto; 	   	   /* 높이 설정 (필요에 따라 조정) */
    overflow-y: auto; 	   /* 세로 스크롤 활성화 */
    word-wrap: break-word; /* 긴 단어 줄바꿈 */
    flex: 1; 			   /* 남은 공간을 차지 */
}

span.detail_title {
	text-align: left;
	font-size: 16pt;
	font-weight: 500;
}

div#prod_contents {
	width: 100%;
	height: 600px;
	overflow: hidden;
}

p.contents {
	white-space: normal;   /* 자동 줄바꿈 허용 */
    word-wrap: break-word; /* 긴 단어 줄바꿈 */
    line-height: 1.5;
}


div#seller_detail {
	flex: 1; /* 남은 공간을 차지 */
}

span.seller_title {
	text-align: left;
	font-size: 16pt;
	font-weight: 500;
}





/* 모달 관련 부분  */
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



</style>


<div id="container">

		<div id="prod_info_container" class="row">
	
			<div class="col-md p-0">
				<c:if test="${not empty requestScope.product_img_list and fn:length(requestScope.product_img_list) > 1}">
				   <div id="carouselExampleIndicators" class="carousel slide">
				        <div class="carousel-inner">
				            <c:set var="is_first_image" value="false"/> <%-- 대표 이미지 활성화 여부 --%>
				            
				            <c:forEach var="img_list" items="${requestScope.product_img_list}">
				                <c:choose>
				                    <%-- 대표 이미지 (첫 번째 슬라이드) --%>
				                    <c:when test="${img_list.prod_img_is_thumbnail == 1}">
				                        <div class="carousel-item active  img_div" >
				                            <img src="${img_list.prod_img_name}" class="d-block" id="prod_img"/>
				                        </div>
				                        <c:set var="is_first_image" value="true"/>
				                    </c:when>
				                    
				                    <%-- 일반 이미지 (대표 이미지가 이미 설정되었다면 일반 슬라이드) --%>
				                    <c:when test="${img_list.prod_img_is_thumbnail == 0}">
				                        <div class="carousel-item ${is_first_image ? '' : 'active'} img_div">
				                            <img src="${img_list.prod_img_name}" class="d-block" id="prod_img"/>
				                        </div>
				                        <c:set var="is_first_image" value="true"/>
				                    </c:when>
				                </c:choose>
				            </c:forEach>
				        </div>
				
				        <%-- 이전/다음 버튼 --%>
				        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
				            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				        </a>
				        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
				            <span class="carousel-control-next-icon" aria-hidden="true"></span>
				        </a>
				   </div>
				</c:if>
				
				<%-- 이미지가 1개일 경우, 캐러셀을 보여주지 않음 --%>
			    <c:if test="${not empty requestScope.product_img_list and fn:length(requestScope.product_img_list) == 1}">
			    	<div class="img_div">
			       		<img src="${requestScope.product_img_list[0].prod_img_name}" class="d-block" id="prod_img"/>
			        </div>
			    </c:if> 
			</div>

			
			
			<div id="prod_info" class="col-md p-0">
				<div id="category_info">
					<span class="prod_category" onclick="location.href='<%= ctxPath%>/index'" >홈</span>
					<span class="greater">　>　</span>
					<span class="prod_category" onclick="location.href='<%= ctxPath%>/product/prodlist?category_no=${product_map.fk_category_no}'">${product_map.category_name}</span>
					<span class="greater">　>　</span>
					<span class="prod_category" onclick="location.href='<%= ctxPath%>/product/prodlist?category_no=${product_map.fk_category_no}&category_detail_no=${product_map.fk_category_detail_no}'">${product_map.category_detail_name}</span>
				</div>
				<div id="title_info">
					<span id="product_title">${product_map.product_title}</span>
					<!-- 공유 아이콘 -->
					<span><i id="share" class="fa-solid fa-arrow-up-right-from-square" onclick="openShareModal()"></i></span>
				</div>
				<div id="price_info">	
					<span><fmt:formatNumber value="${product_map.product_price}" pattern="#,###" /> 원</span>
				</div>
				<div id="time_view_info">
					<span class="product_time" data-date="${product_map.product_regdate}"></span>
					<span>·</span>
					<span>조회 1</span>
				</div>
				<div id="status_region_info">
					<ul id="status_region_info_ul">
						<li class="status">
							<span class="status_title">제품상태</span>
							<c:if test="${product_map.product_status == 0}">
								<span class="status">중고</span>
							</c:if>
							<c:if test="${product_map.product_status == 1}">
								<span class="status">새상품</span>
							</c:if>
						</li>
						
						<li class="bar"></li>
						
						<li class="region">
							<span class="region_title">희망거래동네</span>
							<span class="region">${product_map.region_town}</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="sale_status">
							<span class="sale_status_title">판매상태</span>
							<c:if test="${product_map.product_sale_status == 0}">
								<span class="sale_status">판매중</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 1}">
								<span class="sale_status">예약중</span>
							</c:if>
							<c:if test="${product_map.product_sale_status == 2}">
								<span class="sale_status">판매완료</span>
							</c:if>
						</li>
	
						
					</ul>
				</div>
				
				
				<!-- 판매자 본인의 상품일 경우에만 보여진다.  -->
				<c:if test="${product_map.fk_member_no == fk_member_no}">
				<div id="buyer_setting">
					<ul id="buyer_setting_ul">
						<li class="reg_update" onclick="regUpdate('${product_map.pk_product_no}')">
							<span class="reg_update_title"><i class="fa-solid fa-turn-up"></i></span>
							<span class="reg_update">위로올리기</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="sale_status_upate">
							<span class="sale_status_upate_title"><i class="fa-regular fa-circle-check"></i></span>
							<span class="sale_status_upate">상태변경</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="prod_upate">
							<span class="prod_upate_title"><i class="fa-solid fa-pen-to-square"></i></span>
							<span class="prod_upate">상품수정</span>
						</li>
						
						<li class="bar"></li>
						
						<li class="prod_delete">
							<span class="prod_delete_title"><i class="fa-regular fa-trash-can"></i></span>
							<span class="prod_delete">상품삭제</span>
						</li>
						
					</ul>
				</div>
				</c:if>				
				
				
				<div id="button">
					<c:set var="heartCheck" value="false"/> <%-- 하트 체크 여부 변수 --%>
					<c:if test="${not empty requestScope.wish_list}">
						<c:forEach var="wish_list" items="${requestScope.wish_list}">
							<c:if test="${wish_list.fk_member_no == fk_member_no and wish_list.fk_product_no == product_map.pk_product_no}"> <!-- 회원번호 및 상품 번호 대조 -->
								<c:set var="heartCheck" value="true"/>
							</c:if>
						</c:forEach>
					</c:if>	
					
					<!-- 좋아요 체크된 경우 (채워진 하트) -->				
				    <c:choose>
						 <c:when test="${heartCheck eq 'true'}">
						     <span>
						         <i id="wish" class="fa-solid fa-heart" onclick="wishInsert(this, ${product_map.pk_product_no}, ${fk_member_no})"></i>
						     </span>
						 </c:when>
					<c:otherwise>
					<!-- 좋아요가 체크되지 않은 경우 (빈 하트) -->	
					     <span>
					         <i id="wish" class="fa-regular fa-heart" onclick="wishInsert(this, ${product_map.pk_product_no}, ${fk_member_no})"></i>
					     </span>
					</c:otherwise>
					</c:choose>
					
					<button id="chat">채팅하기</button>
					<button id="buy" onclick="payment()">구매하기</button>
				</div>
			</div>	
		</div>	
		
		<div id="detail_info_container" class="row">	
			<div id="prod_detail" class="col-8 p-0">
				<div>
					<span class="detail_title">상품 정보</span>
					<hr>
				</div>
				
				<div id="prod_contents">
					<p class="contents">${product_map.product_contents}</p>
				</div>
			</div>
			
		    <div id="seller_detail" class="col-4 p-0">	    
		    	<div>
					<span class="seller_title">판매자 정보</span>
					<hr>
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



<jsp:include page=".././footer/footer.jsp"></jsp:include>




<script>

	$(document).ready(function(){
		
		// 상품 등록일자 계산 해주기
	    $("span.product_time").each(function() {
	        const product_reg_date = $(this).attr('data-date'); // 등록일
	        const time = timeAgo(product_reg_date); 	  		// 함수 통해 시간 형식 변환
	        $(this).text(time);								    // 텍스트로 출력
	    }); // end of $("span.product_time").each(function()	
	    		
	    		
	   	// 채팅 버튼 이벤트 등록
	   	$("button#chat").click(function() {
	   		const pk_product_no = "${product_map.pk_product_no}";
	   			
   			// 삭제 예정
   			if(pk_product_no == ""){
   				showAlert("error", "상품이 존재하지 않습니다.");
   				return;
   			}
   			
   			// 채팅방 생성 및 입장
   			$.ajax({
   				url : "${ctx_path}/chat/chatroom",
   				type : "post",
   				data : {
   					"pk_product_no" : pk_product_no
   				},
   				success : function(html) {
   					// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
   					openSideTab(html, "${product_map.member_name}");
   				},
   				error: function(request, status, error){
   					errorHandler(request, status, error);
   				}
   			});
	   	});
		
		
	}); // end of $(document).ready(function()
	
			
	// Function Declaration---------------------------------
			
	
	// 등록일 계산 해주는 함수
	function timeAgo(reg_date) {
	    const now = new Date(); 					 // 현재 시간
	    const product_reg_date = new Date(reg_date); // 상품 등록일
	    
	    // console.log("현재 시간:", now);
	    // console.log("상품 등록일:", product_reg_date);

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
	
	
	// 하트 모양(좋아요) 클릭한 경우
	function wishInsert(e, product_no, member_no) {
		
		if(member_no) { // 로그인한 경우라면
			$.ajax({
				url:"<%= ctxPath %>/product/wish_insert",
				type:"post",
				data: {"fk_product_no": product_no,
					   "fk_member_no": member_no},
				success:function(response) {
					if($(e).hasClass("fa-regular")) {
				        $(e).removeClass("fa-regular").addClass("fa-solid"); // 하트 채우기
				        showAlert('success', '관심상품에 추가하였습니다.');
					} 
					else {
						$(e).removeClass("fa-solid").addClass("fa-regular"); // 하트 비우기
						showAlert('error', '관심상품에서 삭제하였습니다.');
					}	
				},
				error: function(request, status, error){ 
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }	
			}); 
		} 
		else {
			showAlert('error', '로그인 후 이용 가능합니다.');
		}
		
	} // end of function wishInsert()
	
	
	// "위로올리기" 클릭 시 상품 등록일자 업데이트 하기
	function regUpdate(product_no) {
		$.ajax({
			url:"<%= ctxPath %>/product/reg_update",
			type:"post",
			data: {"pk_product_no": product_no},
			success:function(response) {
			    
				showAlert('success', '해당 상품의 등록일이 업데이트 되었습니다.');

			},
			error: function(request, status, error){ 
                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }	
		}); 		
	}
	
	
	
	// --- 공유하기 모달 관련 --- //
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
                webUrl: currentURL
            },
        });
    }
	
    
    
 	// 구매하기 클릭시
	function payment() {
		
 		const pk_product_no = "${product_map.pk_product_no}";
 		const fk_member_no = "${fk_member_no}";
 		
 		// 로그인 한 회원이 아닌 경우
 		if(fk_member_no == "") {
 			showAlert('error', '구매하기는 로그인 후 이용가능합니다.');
 			return;
 		}
 		
 		// 상품이 존재하지 않는 경우
 		if(pk_product_no == "") {
 			showAlert('error', '해당 상품이 존재하지 않습니다.');
 			return;
 		}
 		
		const tabTitle = "구매하기";
	      $.ajax({
	         url : "<%=ctxPath%>/trade/show_payment",
	         type: "post",
 			 data: {"pk_product_no":pk_product_no},
	         success : function(html) {
	            openSideTab(html, tabTitle);
	         },
	         error : function(request, status, error) {
	        	errorHandler(request, status, error);
	         }
	      });
		
 			
 		
	}
    
</script>