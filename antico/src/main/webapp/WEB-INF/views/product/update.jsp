<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>


<%-- 상품 map --%>
<c:set var="product_map" value="${requestScope.product_map}" />

<%-- 이미지 list --%>
<c:set var="img_list" value="${requestScope.product_img_list}" />



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
 
label.prod_img_label {
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

label.prod_img_label p {
	font-size: 9pt;
	margin-top: 20px;
    margin-bottom: 0;
}


/* 상품제목 */
input#prod_title {
	border: solid 1px #cccccc;
	border-radius: 6px;
	padding: 10px 20px;
	width: 100%;
	font-size: 10pt;
}


/* 카테고리 공통 */
div.category_left,
div.category_right {  		
	max-height: 230px;		/* 6개 항목만 보이게 설정 */
    overflow-y: auto;   	/* 내부 스크롤 활성화 */
    scrollbar-width: none;	/* 스크롤 감추기 */
}

/* 카테고리 전체 */
div#category {
    display: flex;
    border: none;
    border-radius: 6px;
    width: 400px;
}

/* 상품 카테고리 (상위) */
div.category_left {
    width: 50%;
    padding: 10px;
    border: 1px solid #ddd;
	border-radius: 6px;
}
div.category_left ul {
    list-style: none;
    padding: 0px;
    margin-bottom: 0px !important;
}
div.category_left li {
    padding: 8px;
    cursor: pointer;
    color: #5a5a5a;
    font-size: 10pt;
}


/* 상품 카테고리 (하위) */
div.category_right {
    width: 50%;
    padding: 10px;
    display: block;
    border: solid 1px #ddd;
    border-radius: 6px;	
}
       	
div.category_right ul {
    list-style: none;
    padding: 0px;
    margin-bottom: 0px !important;
}
div.category_right li {
    padding: 8px;
    cursor: pointer;
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
	padding: 10px 35px;
	width: 100%;
	font-size: 10pt;
}


/* 상품 내용 */
textarea#prod_contents_textarea {
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
input.used, input.general {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: #0dcc5a;
	width: 90px;
	height: 40px;
	font-weight: bold;
	font-size: 10pt;
}

input.new, input.auction {
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

input.add_region {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: #0dcc5a;
	width: 90px;
	height: 40px;
	font-weight: bold;
	font-size: 10pt;
}


/* 동네명 */
input.town_name {
	width: 90px;
	height: 40px;
	margin-left: 10px;
	border: none;
	border-radius: 6px;
	font-weight: bold;
	font-size: 10pt;
	color: #5a5a5a;
	background-color: #f1f4f6;
	text-align: center;
}


/* 수정 버튼 */
button.update {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: black;
	width: 150px;
	height: 50px;
	font-weight: bold;
	font-size: 10pt;
}

/* 취소 버튼 */
button.cancel {
	border: none;
	border-radius: 6px;
	color: white;
	background-color: black;
	width: 150px;
	height: 50px;
	font-weight: bold;
	font-size: 10pt;
	margin-left: 20px;
}



/* 경매 날짜 필드 관련 */
input[type='datetime-local'] {
    width: 185px;
   	height: 40px;
    background-color: white;
    border: solid 1px #cccccc;
	border-radius: 6px;
    padding: 5px;
    margin-left: 10px;
    font-size: 10pt;
    visibility: hidden;
    position: relative; /* position을 relative로 설정 */
    z-index: 1; /* 날짜 입력 필드가 위로 오도록 설정 */
    cursor : pointer;
}

span.auction_warning {
	font-size: 10pt;
	color: red;
	visibility: hidden;
}

</style>



<div id="container">

	<!-- 상품 수정 시작 -->
	<form id="prod_update" name="prod_update_frm" enctype="multipart/form-data">	
		
		
		<!-- 상품 이미지  -->
		<div id="prod_img_container">
			<div style="display: flex;">
				<input id="prod_img" name="attach" type="file" accept='image/*' multiple style="display: none;" />
				<div>
					<label class="prod_img_label" for="prod_img">
						<i class="fa-solid fa-camera fa-xl" style="color: #9ca3af; padding-top: 6px;"></i>
						<p id="img_count" style="color: #9ca3af;"></p> <!-- 업로드 이미지 개수 표시 -->
					</label>
				</div>
				<!-- 상품 이미지 미리보기  -->
				<div id="image_previews" style="margin-left: 10px; width: 100%; display: flex; flex-wrap: wrap;">
				</div>
				
				<!-- 기존 이미지 담아가기 -->
			   	<input id="deleted_img_name" type="hidden" name="prod_img_name">
			</div>
		</div>
		
		
		<!-- 상품제목  -->
		<div id="prod_title" class="cm_margin_top">
			<input id="prod_title" name="product_title" type="text" maxlength="50" placeholder="상품제목" value="${product_map.product_title}"/>
		</div>
		
		
		<!-- 카테고리  -->
		<div id="category" class="cm_margin_top">
		    <!-- 상위카테고리 -->
		    <div class="category_left">
		    	<input id="category" name="fk_category_no" type="hidden" value="${product_map.fk_category_no}" />
		        <ul>
		        	<c:forEach var="category_list" items="${requestScope.category_list}">
		            	<li onclick="loadCategoryDetail('${category_list.pk_category_no}')" class="category_left" data-category-no="${category_list.pk_category_no}">${category_list.category_name}</li>
					</c:forEach>
		        </ul>
		    </div>
		
		
		    <!-- 하위카테고리 (처음엔 숨김) -->
		    <div id="category_detail" class="category_right">
		    	<input id="category_detail" name="fk_category_detail_no" type="hidden" value="${product_map.fk_category_detail_no}" />
		        <ul id="category_detail_list">
		        </ul> 
		    </div>
		</div>
		
		
		<!-- 상품 가격 -->
		<div id="prod_price" class="cm_margin_top">
		  	<span id="won">₩</span>
		  	<input id="prod_price" name="product_price" type="text" maxlength="10" placeholder="상품가격" required value="${product_map.product_price}"/>
		</div>
		
		<!-- 상품 내용 -->
		<div id="prod_contents" class="cm_margin_top">
			<textarea id="prod_contents_textarea" name="product_contents" maxlength="2000" 
			placeholder="- 상품명 &#10;- 구매 시기&#10;- 사용 기간&#10;- 하자 여부&#10;* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.&#10;* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요&#10;안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, ANTICO가 함께합니다." 
			><c:out value="${product_map.product_contents}"/></textarea>
		</div>
		
		<div style="position: relative;">
			<span id="text_count">0 / 2000</span>
		</div>
		
		
		<!-- 상품 상태 -->
		<div id="prod_status" class="cm_margin_top">
			<span class="cm_span_title">상품상태</span>
			<div class="button">
				<input type="button" class="used" value="중고" data-value="0" />
				<input type="button" class="new" value="새상품" data-value="1" />
				<input type="hidden" id="prod_status_value" name="product_status" value="${product_map.product_status}" />
			</div>
		</div>
		
		
		<!-- 판매 유형 -->
		<%-- 
		<div id="prod_sale_type" class="cm_margin_top">
			<span class="cm_span_title">판매 유형</span>
			<div class="button">
				<input type="button" class="general" value="일반판매" data-value="0" />
				<input type="button" class="auction" value="경매" data-value="3" />
				<input type="text" id="prod_sale_type_value" name="product_sale_type" value="${product_map.product_sale_status}" />
				
				<input type="datetime-local" class="auction_start_date" name="auction_start_date" placeholder="경매 시작 날짜" />
				<span class="auction_warning">경매 시작 시간 (시작 시간으로부터 1시간 후가 마감 시간입니다.)</span>
			</div>
		</div>
		--%>

		<!-- 희망 거래 동네 -->
		<div id="prod_region" class="cm_margin_top">
			<span class="cm_span_title">희망 거래 동네</span>
			<div id="region_button" class="button">
				<input type="button" class="add_region" value="선택" />
				<input class="town_name" disabled value="${product_map.region_town}" /> <%-- 동네명 보여주기 위한 --%>
				<input id="fk_region_no" name="fk_region_no" type="hidden" value="${product_map.fk_region_no}"/>
				<%-- <i id="location" class="fa-solid fa-location-dot fa-2xs"></i> 위치 아이콘 --%>
			</div>
		</div>
		
		<!-- 등록 버튼 -->
		<div class="cm_margin_top" style="text-align: center;">
			<button type="button" id="update" class="update">수정</button>
			<button type="button" id="cancel" class="cancel" onclick="history.back()">취소</button>
		</div>
		
		<%-- form 전송용 --%>
		<input type="hidden" id="prod_pk_product_no" name="pk_product_no" value="${product_map.pk_product_no}" /> 

	</form>
	<!-- 상품 등록 끝 -->
			
</div>


<jsp:include page=".././footer/footer.jsp"></jsp:include>


<script>


$(document).ready(function(){
	
	
	// 기존 이미지 파일 미리보기 시작
	let input_file = $("input#prod_img")[0];
	let product_imglist = []; // 기존 이미지 정보
	let fileArr = []; 		  // fileArr 배열을 초기화
	let maxFiles = 10; 		  // 최대 업로드 가능 개수
	let deletedFileArr = [];

	<c:forEach var="img" items="${img_list}">
		product_imglist.push({
			prod_img_name: "${img.prod_img_name}",
	        pk_prod_img_no: "${img.pk_prod_img_no}",
	        prod_img_is_thumbnail: "${img.prod_img_is_thumbnail}"
	    });
	</c:forEach>

	let image_previews = $("#image_previews");
	let img_count_text = $("#img_count");

	// 기존 이미지 미리보기 추가
	product_imglist.forEach(function (imgData, index) {
	    let each_img_preview = $("<div>").attr("data-name", imgData.prod_img_name).css({
	        "position": "relative",
	        "display": "inline-block",
	        "margin-left": "5px",
	        "margin-right": "6px",
	        "border-radius": "6px",
	        "width": "86px",
	        "height": "80px",
	        "overflow": "hidden"
	    });

	    let img = $("<img>").attr("src", imgData.prod_img_name).css({
	        "width": "86px",
	        "height": "80px",
	        "padding-left": "0px",
	        "border-radius": "6px",
	        "object-fit": "cover",
	        "box-sizing": "border-box"
	    });

	    let close_button = $("<button>").attr("type", "button").css({
	        "position": "absolute",
	        "top": "2px",
	        "right": "2px",
	        "border": "solid 1px #cccccc",
	        "background-color": "white",
	        "color": "black",
	        "border-radius": "50%",
	        "width": "20px",
	        "height": "20px",
	        "cursor": "pointer"
	    }).text("X").css({
	        "font-weight": "bold",
	        "font-size": "10px",
	        "color": "#5a5a5a"
	    });

	    each_img_preview.append(img).append(close_button);
	    image_previews.append(each_img_preview);

	    // 기존 이미지를 배열에 추가 (업로드된 파일 배열에는 추가 안 함)
	    fileArr.push({ prod_img_name: imgData.prod_img_name, pk_prod_img_no: imgData.pk_prod_img_no });

	    // 첫 번째 이미지에 테두리 추가
	    if (index === 0) {
	        each_img_preview.css("border", "solid 1px #0dcc5a");
	    }

	    // 삭제 버튼 클릭 이벤트
	    close_button.on("click", function (event) {
	

	        let parentDiv = $(this).closest("div"); // 해당 미리보기 div 찾기
	        let imgName = parentDiv.attr("data-name"); // data-name 속성에서 이미지 이름 가져오기

	        // 배열에서 삭제할 이미지 찾기
	        let index_remove = fileArr.findIndex(f => f.prod_img_name === imgName);
	        if (index_remove !== -1) {
	            let removedItem = fileArr.splice(index_remove, 1)[0]; // 배열에서 삭제

	            // 삭제된 이미지 이름 저장
	            deletedFileArr.push(removedItem.prod_img_name);
	            $("#deleted_img_name").val(deletedFileArr.join(",")); // hidden input 업데이트
	        }

	        parentDiv.remove(); // 미리보기 삭제
	        $("#img_count").text(fileArr.length + "/" + maxFiles); // 이미지 개수 업데이트
		
	        
	        // 첫 번째 이미지가 삭제되면, 새로운 첫 번째 이미지에 테두리 추가
	        $("#image_previews div").first().css("border", "solid 1px #0dcc5a");
	    });
	});
	

	 // 이미지 개수 갱신
	 $("#img_count").text(fileArr.length + "/" + maxFiles); // 서버에서 받은 이미지 개수로 갱신
    	 
    
    // 이미지 미리보기 업로드 처리
    $("input#prod_img").on("change", function(e) {
        let files = Array.from(e.target.files);
        let image_previews = $("#image_previews");
        let img_count_text = $("#img_count");
		
        
        $(this).val("");
        
        // 파일 개수 제한
        if (fileArr.length + files.length > maxFiles) {
            showAlert('error', '최대 10개의 이미지만 업로드 가능합니다.');
            return;
        }
		
        // 파일 형식 제한
        files.forEach(file => {
        	
            if (!(file.type === 'image/jpeg' || file.type === 'image/png')) {
                showAlert('error', 'jpg 또는 png 파일만 업로드 가능합니다.');
                return;
            }
            
            if (file.size > 10 * 1024 * 1024) { // 10MB 제한
                showAlert('error', '각 이미지 파일 크기는 최대 10MB까지 가능합니다.');
                return;
            }

            let reader = new FileReader();
            reader.onload = function(e) {
                
            	// 각 미리보기 이미지에 대한 div
                let each_img_preview = $("<div>").css({
                    "position": "relative",
                    "display": "inline-block",
                    "margin-left": "5px",
                    "margin-right": "6px",
                    "border-radius": "6px",
                    "width": "86px",              
                    "height": "80px",
                    "overflow": "hidden" 
                });
            	     	
            	// 이미지 미리보기 CSS
            	let img = $("<img>").attr("src", e.target.result).css({
                    "width": "86px",
                    "height": "80px",
                    "padding-left": "0px",
                    "border-radius": "6px",
                    "object-fit": "cover",
                    "box-sizing": "border-box"
                });
            	
                
                // 버튼 및 X 텍스트 CSS
                let close_button = $("<button>").css({
                    "position": "absolute",
                    "top": "2px",
                    "right": "2px",
                    "border": "solid 1px #cccccc",
                    "background-color": "white",
                    "color": "black",
                    "border-radius": "50%",
                    "width": "20px",
                    "height": "20px",
                    "cursor": "pointer",
                }).text("X").css({
                    "font-weight": "bold",
                    "font-size": "10px",
                    "color": "#5a5a5a" 
                });
                

                each_img_preview.append(img).append(close_button);
                image_previews.append(each_img_preview);
                
                fileArr.push(file); // 배열에 파일 추가
                
                
                // 첫 번째 이미지에 테두리 추가 (이미지가 올라온 직후)
                if (fileArr.length === 1) {
                    each_img_preview.css("border", "solid 1px #0dcc5a");
                }
                
                img_count_text.text(fileArr.length + "/" + maxFiles); // 이미지 개수 업데이트
                
             	// 파일을 input#prod_img에 추가 (파일명이 고유하도록 처리)
                let dataTransfer = new DataTransfer();
                Array.from(input_file.files).forEach(f => dataTransfer.items.add(f));
                dataTransfer.items.add(file) // 새로 선택된 파일들만 추가
                input_file.files = dataTransfer.files; // input 요소에 파일 업데이트
                
                // 파일 선택 후 input 초기화 (같은 파일 다시 업로드 가능하게)
                e.target.value = '';
                
                // 삭제 버튼 클릭 시 이벤트
                close_button.on("click", function () {
                	
                    let index_remove = fileArr.indexOf(file);
                    if (index_remove !== -1) {
                        fileArr.splice(index_remove, 1);  // 배열에서 해당 파일 제거
                        each_img_preview.remove(); 		  // 미리보기 이미지 삭제
                        img_count_text.text(fileArr.length + "/" + maxFiles); // 이미지 개수 업데이트
                        
	                    // 첫 번째 이미지가 삭제되면, 새로운 첫 번째 이미지에 테두리 추가
	                    $("#image_previews div").first().css("border", "solid 1px #0dcc5a");
                        
	                    // 삭제 후 남은 파일들을 다시 input#prod_img에 추가
	                    let dataTransfer = new DataTransfer();
	                    // 삭제된 파일을 제외한 나머지 파일들만 추가
	                    fileArr.forEach(f => dataTransfer.items.add(f));
	                    input_file.files = dataTransfer.files; // input 요소의 files 업데이트
                    }
                });

            };
            
            reader.readAsDataURL(file);
        });
        
    }); // end of $("input#prod_img").on("change", function(e)
 	// 파일 이미지 미리 보기 끝
 	
 	
 	
    // 페이지 로드시 선택된 카테고리 번호와 하위 카테고리 번호를 가져와서 스타일을 적용
    let selected_category = $("input[name='fk_category_no']").val(); 			   // 선택된 상위 카테고리 번호
    let selected_category_detail = $("input[name='fk_category_detail_no']").val(); // 선택된 하위 카테고리 번호

    // 상위 카테고리 스타일 적용
    if (selected_category) {
        $("li[data-category-no='" + selected_category + "']").css({
            "font-weight": "bold",
            "background-color": "#e9ecef"
        });
    }

    // 하위 카테고리 스타일 적용
    if (selected_category_detail) {
        $("li[data-category-detail-no='" + selected_category_detail + "']").css({
            "font-weight": "bold",
            "background-color": "#e9ecef"
        });
    }

    // 하위 카테고리 로드
    if (selected_category) {
        loadCategoryDetail(selected_category, selected_category_detail);  // 하위 카테고리 로드 함수 호출
    }


 	
	// 상품 내용 text 개수 업데이트 하기
	let product_contents = $("textarea#prod_contents_textarea").val(); // text 값 가져오기
	let text_length = product_contents.length; // 텍스트의 길이를 구함
	$('#text_count').text(text_length + ' / 2000'); // 텍스트 개수 표시를 업데이트
 	

 	// 상품 내용에 텍스트 입력 시 텍스트 글자 수 반영하기 시작 //
 	$("textarea#prod_contents_textarea").on("input", function() {
 		let contents = $(this).val();
 		$("#text_count").html(contents.length+" / 2000"); // 글자 수 실시간 반영
 		// console.log(contents.length);
 		
 		if(contents.length > 2000) {
 			showAlert('error', '상품 내용은 최대 2000자까지 입력 가능합니다.');
 		}
 		
 	}); // end of $("textarea#prod_contents_textarea").keyup(function(e)		
    // 상품 내용에 텍스트 입력 시 텍스트 글자 수 반영하기 시작 끝 //
 	
   
    
    // 페이지 로딩 시 상품상태 및 판매유형 값에 따라 CSS 처리 해준다. 
    // 중고라면
    if($("input#prod_status_value").val() === "0") {
        // 새상품 버튼 스타일 (초록색 배경, 흰색 글씨)
        $("input.used").css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 중고 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.new").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
    }    
    
 	// 새상품이라면
    if($("input#prod_status_value").val() === "1") {
        // 새상품 버튼 스타일 (초록색 배경, 흰색 글씨)
        $("input.new").css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 중고 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.used").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
    }
 	
 	// 일반판매라면
    if($("input#prod_sale_type_value").val() === "0") {
        // 일반판매 버튼 스타일 (초록색 배경, 흰색 글씨)
        $("input.general").css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 경매 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.auction").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
        
        // 경매 종료 날짜 숨기기
        $("input.auction_start_date").css({"visibility": "hidden"});
        
        // 경매 시간 문구 숨기기
        $("span.auction_warning").css({"visibility": "hidden"});
    }
 	
 	
 	// 경매라면
    if($("input#prod_sale_type_value").val() === "3") {
        // 일반판매 버튼 스타일 (초록색 배경, 흰색 글씨)
        $("input.auction").css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 경매 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.general").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
        
        // 경매 종료 날짜 보이기
        $("input.auction_start_date").css({"visibility" : "visible"});
        
        // 경매 시간 문구 보이기
        $("span.auction_warning").css({"visibility": "visible"});
    }
    
 	
	
    // 중고 버튼 클릭 시
    $("input.used").click(function(){
		
    	// 중고버튼 스타일 (초록색 배경, 흰색 글씨)
        $(this).css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 새상품 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.new").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
        
        // 선택한 상품 상태 값 변경
        $("#prod_status_value").val($(this).data("value"));
        
        // console.log($("#prod_status_value").val());
    
    }); // end of $("input.used").click(function()
       
    		
    // 새상품 버튼 클릭 시
    $("input.new").click(function () {
    	
        // 새상품 버튼 스타일 (초록색 배경, 흰색 글씨)
        $(this).css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 중고 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.used").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });

        // 선택한 상품 상태 값 변경
        $("#prod_status_value").val($(this).data("value"));
        
        // console.log($("#prod_status_value").val());
        
    }); // end of $("input.new").click(function ()
    		
    		
    // 일반판매 버튼 클릭 시
    $("input.general").click(function(){
    	
    	// 일반버튼 스타일 (초록색 배경, 흰색 글씨)
        $(this).css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });

        // 경매 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.auction").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
        
        // 경매 종료 날짜 숨기기
        $("input.auction_start_date").css({"visibility": "hidden"});
        
        // 경매 시간 문구 숨기기
        $("span.auction_warning").css({"visibility": "hidden"});
        
        // 선택한 상품 상태 값 변경
        $("#prod_sale_type_value").val($(this).data("value"));
        
        // console.log($("#prod_sale_type_value").val());
    
    }); // end of $("input.general").click(function()
    		
    		
    // 경매 버튼 클릭 시
    $("input.auction").click(function(){
		
    	// 경매 버튼 스타일 (초록색 배경, 흰색 글씨)
        $(this).css({
            "color": "white",
            "background-color": "#0dcc5a",
            "border": "none"
        });
    	
        // 경매 종료 날짜 보이기
        $("input.auction_start_date").css({"visibility" : "visible"});
        
        // 경매 시간 문구 보이기
        $("span.auction_warning").css({"visibility": "visible"});

        // 일반 판매 버튼 스타일 (흰색 배경, 검은색 글씨)
        $("input.general").css({
            "color": "black",
            "background-color": "white",
            "border": "1px solid black"
        });
        
        // 선택한 상품 상태 값 변경
        $("#prod_sale_type_value").val($(this).data("value"));
        
        // console.log($("#prod_sale_type_value").val());
    
    }); // end of $("input.auction").click(function()			
    		
    				
    
   	// 희망 거래 지역 '선택' 버튼 클릭 시
    $("input.add_region").click(function(){
    	showRegionSearchTab();
    });		
    
    
    
    // 상품 수정 하러가기
    $("button#update").click(function(){
    		
    	let prod_infoData_OK = true; // 유효성 여부 확인하는 용도
    	
    	// 이미지 유효성 검사
    	/*
    	const prod_img = $("input#prod_img").val();
    	if (prod_img == "") {
    		showAlert('error', '이미지는 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	*/
    	if (fileArr.length === 0) {
    		showAlert('error', '이미지는 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	
    	// 상품 제목 유효성 검사
    	const prod_title = $("input#prod_title").val().trim();
    	if(prod_title == "") {
    		showAlert('error', '상품제목은 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	
    	
    	// 카테고리 유효성 검사
    	const category = $("input#category").val();
    	const category_detail = $("input#category_detail").val();
    	if(category == "" || category_detail == "") {
    		showAlert('error', '카테고리는 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	
    	
    	// 판매가격 유효성 검사
    	if($("input#prod_price").val() == "") {
    		showAlert('error', '판매가격은 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	else { // 입력 후 숫자 유효성 검사
        	const regExp_prod_price = /^[0-9]+$/g;
        	const prod_price = regExp_prod_price.test($("input#prod_price").val())
        	if(!prod_price) {
        		showAlert('error', '판매가격은 숫자로만 입력가능합니다.');
        		prod_infoData_OK = false;
        		return false;
        	}
    	}
    	
    	
    	// 상품 내용 유효성 검사
    	const prod_contents = $("textarea#prod_contents_textarea").val();
    	if(prod_contents == "") {
    		showAlert('error', '상품내용은 필수 입력사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	
    	
    	// 상품 상태 유효성 검사
    	const prod_status_ = $("input#prod_status_value").val();
    	if(prod_status_ == "") {
    		showAlert('error', '상품상태는 필수 선택사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	
    	
    	// 판매 유형 유효성 검사
    	const prod_sale_type_value = $("input#prod_sale_type_value").val();
    	if(prod_sale_type_value == "") {
    		showAlert('error', '판매유형은 필수 선택사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}
    	

    	// 경매 시작 시간 유효성 검사
    	const auction_start_date_value = $("input.auction_start_date").val();
    	if(prod_sale_type_value == 1) { 
    		// 경매 시작 시간이 존재하지 않는 경우
    		if(auction_start_date_value == "") {
    			showAlert('error', '경매 시작 시간은 필수 선택사항입니다.');
        		prod_infoData_OK = false;
        		return false;
    		}
    		
      		// 현재 시간
    		const now = new Date();
    		now.setSeconds(0, 0); // 초와 밀리초 제거
      		
      		// 입력된 경매 시작 날짜 및 시간을 Date 객체로 변환
      		const auction_start_date = new Date(auction_start_date_value.replace("T", " ") + ":00"); // 초까지 맞춰서 변환
    		
    		// 경매 시작 시간이 현재 시간 이전인 경우
    		if (now >= auction_start_date){
    			showAlert('error', '경매 시작 시간은 현재 시간보다 이후여야 합니다.');
        		prod_infoData_OK = false;
        		return false;
    		}
    	}
    	
    	
    	
    	
    	// 희망 거래 동네 유효성 검사
    	const fk_region_no = $("input#fk_region_no").val();
    	if(fk_region_no == "") {
    		showAlert('error', '희망 거래 동네는 필수 선택사항입니다.');
    		prod_infoData_OK = false;
    		return false;
    	}	
    	
    	
    	if(prod_infoData_OK) { // 유효성 검사 통과했으면 상품 수정 시작한다.
      	  // 경매상품 등록
      	  if($("input#prod_sale_type_value").val() == 1)	 {
      		// 폼(form)을 전송(submit)
       	    const frm = document.prod_update_frm;
       	    frm.method = "post";
       	    frm.action = "<%= ctxPath%>/auction/update_end";
       	    frm.submit();
      	  }
      	  // 일반상품 등록
      	  else {
      		// 폼(form)을 전송(submit)
     	        const frm = document.prod_update_frm;
     	        frm.method = "post";
     	        frm.action = "<%= ctxPath%>/product/update_end";
     	        frm.submit();  
      	  }
    	      
      	} // end of if(prod_infoData_OK)
    	
    }); // end of $("button#update").click(function() ---> 상품 수정 하러가기 끝 
    
 	
}); // end of $(document).ready(function()


// Function Declaration---------------------------------		


// 상위 카테고리 클릭하면 하위 카테고리 나타내주기 시작 //
// JSP에서 하위 카테고리 데이터를 자바스크립트 객체로 변환
let sub_category_list = [
    <c:forEach var="sub_category" items="${requestScope.category_detail_list}">
        {
            pk_category_detail_no: "${sub_category.pk_category_detail_no}",
            fk_category_no: "${sub_category.fk_category_no}",
            category_detail_name: "${sub_category.category_detail_name}"
        },
    </c:forEach>
];

function loadCategoryDetail(category_no, category_detail_no) {
    let category_detail_list = $("ul#category_detail_list");
    category_detail_list.empty(); // 기존 목록 초기화 (innerHTML -> empty)

    // 상위 카테고리에 해당하는 하위 카테고리 필터링
    let filtered_sub_category_list = sub_category_list.filter(sub => sub.fk_category_no === category_no);

    // 상위 카테고리 기본 스타일로 초기화
    $("li.category_left").css({
        "font-weight": "normal",        // 기본 폰트 굵기
        "background-color": "transparent" // 기본 배경색
    });

    // 상위 카테고리 스타일 변경
    $("li[data-category-no='" + category_no + "']").css({
        "font-weight": "bold",         // 클릭한 상위 카테고리 폰트 굵기
        "background-color": "#e9ecef"  // 클릭한 상위 카테고리 배경색
    });

    if (filtered_sub_category_list.length > 0) {
        // 하위 카테고리 항목 추가
        filtered_sub_category_list.forEach(sub_category => {
            let li = $("<li></li>").text(sub_category.category_detail_name).addClass("category_right");
            li.attr("data-category-detail-no", sub_category.pk_category_detail_no);  // 데이터 속성 추가

            // 하위 카테고리 항목 클릭 이벤트 추가
            li.on("click", function(event) {
                // 모든 하위 카테고리 스타일 초기화
                $("li.category_right").css({
                    "font-weight": "normal",    // 기본 폰트 굵기
                    "background-color": "transparent" // 기본 배경색
                });

                // 클릭한 하위 카테고리 스타일 변경
                $(event.target).css({
                    "font-weight": "bold",       // 클릭한 하위 카테고리 폰트 굵게
                    "background-color": "#e9ecef"  // 클릭한 하위 카테고리 배경색
                });

                $("input#category_detail").val(sub_category.pk_category_detail_no); // 클릭한 하위 카테고리 번호 값
            });

            // 하위 카테고리 목록에 추가
            category_detail_list.append(li);

            // 하위 카테고리 스타일 적용
            if (sub_category.pk_category_detail_no === category_detail_no) {
                li.css({
                    "font-weight": "bold",
                    "background-color": "#e9ecef"
                });
            }
        });

        // 하위 카테고리 표시
        $("div#category_detail").css({
            "display": "block",
            "border": "solid 1px #ddd",
            "border-radius": "6px"
        });

        $("input#category").val(category_no);  // input에 category 번호 담기
    } else {
        // 하위 카테고리 없으면 숨김
        category_detail_list.empty();
    }

    
}; // end of function loadCategoryDetail(category_no)  
// 상위 카테고리 클릭하면 하위 카테고리 나타내주기 끝 //	



// 희망 지역 검색 사이드 바 불러오기
function showRegionSearchTab() {
	$.ajax({
		url : "<%=ctxPath%>/product/regionlist",
		type : "get",
		success : function(html) {
			// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기
			openSideTab(html, "");
		},
		 error: function(request, status, error){
			 console.log(request.responseText);
			 
			 // 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
			 errorHandler(request, status, error); 
		     
		     // 사이드 탭 닫기
		     closeSideTab();
		}
	});
}


</script>