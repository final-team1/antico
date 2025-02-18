<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<c:set var="pk_member_no" value="${requestScope.pk_member_no}" />
<c:set var="review_count" value="${requestScope.review_count}" />

<style>
	div#review_container {
		padding-right : 20px;
	}
	
	div.survey_item {
		margin : 10px 0;
		width : 100%;
		display : flex;
		justify-content : space-between;
		align-items : center;
	}
	
	div.survey_item > div {
		display : flex;
		justify-content : space-between;
		align-items : center;
	}
	
	div#like_survey_container, div#dislike_survey_container {
		margin : 30px 0;
	}
	
	span#total_survey_count {
		color : #0DCC5A;
	}
	
	div.review_item {
		margin : 20px 0;
		padding : 10px;
		cursor : pointer;
	}
	
	div.review_item:hover {
		border-radius : 15px;
		background-color : #eee;
		transition : 0.3s ease;
	}	
	
	div.reivew_profile {
		margin : 10px 0;
		width : 100%;
		display : flex;
	}
	
	div.review_profile_detail {
		margin-left : 10px;
		display : flex;
		flex-direction : column;
	}
	
	span.writer_name {
		font-weight: bold;
	}
	
	div.review_content {
		width : 100%;
		padding : 20px;
		border-radius : 15px;
		background-color : #F1F4F6;
	}
	
	button#loadReviewBtn {
		width : 100%;
		height : 60px;
		border-radius : 15px;
		background-color : transparent;
	}
	
	button#loadReviewBtn:hover {
		transition : 0.3s ease;
		background-color : black;
		color : white;
	}
	
	img.icon_file {
		filter: invert(69%) sepia(37%) saturate(5887%) hue-rotate(100deg) brightness(99%) contrast(90%);
	}
</style>
<div id="review_container">
	<!-- 최근 5개 후기 내역 -->
	<h4 style="margin-bottom : 20px;">전체후기 <span id="total_survey_count"></span></h4>
	<div id="preview_review_container">	</div>
	
	<button id="loadReviewBtn" onclick="loadReviewList()">더보기</button>
</div>

<script>
	// 현재 페이지 카운트
	var cur_page = 1;
	
	$(document).ready(function() {
		// 초기 1번 후기 목록 불러오기 		
		loadReviewList();
		
		// 후기 클릭 이벤트
		$(document).on("click", "div.review_item", function(){
			const pk_review_no = $(this).data("pk_review_no");
			// 후기 상세 내역 불러오기
			loadReviewDetails(pk_review_no);
		});
	});

	// 더보기 버튼으로 후기 목록 불러오기
	function loadReviewList(){
		if((cur_page - 1) * 5 < ${review_count}) {

			$.ajax({
				url:`${ctxPath}/review/reviews/${pk_member_no}/\${cur_page}`,
				dataType : "json",
				success : function(json) {
					let v_html = ``;
					
					$.each(json, function(index, item) {
						v_html += `
							<div class="review_item" data-pk_review_no=\${item.pk_review_no}>
								<div class="reivew_profile">
									<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
									<div class="review_profile_detail">
										<span class="writer_name">\${item.consumer_name}</span>
										<div style="display:flex; align-items:center">
										<span>\${item.review_regdate}`;
										
											if(item.review_img_file_name) {
												v_html += `<img class="icon_file" src="${ctxPath}/images/icon/file.svg" width="20" />`
											}
											
											v_html += `
											</div>
										</span>
									</div>
								</div>
								
								<div class="review_content">
									\${item.review_content}
								</div>
							</div>
						`;
					});
					
					// 정해진 개수의 후기 목록 요소
					let review_html = $("div#preview_review_container").html();
					
					// 기존의 요소에 더하여 추가
					$("div#preview_review_container").html(review_html + v_html);
					
					// 모든 목록을 불러오면 더보기 버튼 비활성화
					if(cur_page * 5 >= ${review_count}){
						$("button#loadReviewBtn").hide();
					}
					
					// 현재 페이지 증가
					cur_page += 1;
					
				},
				error: function(request, status, error){
					console.log(request.responseText);
					 
					 // 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
					 let response = request.responseText;
					 let message = response.substr(0, 4) == "msg/" ? response.substr(4) : "";
					 
				     showAlert("error", message);
				     
				     // 사이드 탭 닫기
				     closeSideTab();
				}
			});	
		}	
	}

	// 후기 상세 불러오기
	function loadReviewDetails(pk_review_no){
		$.ajax({
			url : `${ctxPath}/review/details/\${pk_review_no}`,
			dataType : "json",
			success : function(json) {
				// 후기 아이콘
				const icon_url = "${ctxPath}/images/icon/review.svg";
				showReviewModal(json, icon_url);
			},
			error: function(request, status, error){
				 console.log(request.responseText);
				 
				 // 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
				 let response = request.responseText;
				 let message = response.substr(0, 4) == "msg/" ? response.substr(4) : "";
				 
			     showAlert("error", message);
			     
			     // 사이드 탭 닫기
			     closeSideTab();
			}
		});
	}
</script>