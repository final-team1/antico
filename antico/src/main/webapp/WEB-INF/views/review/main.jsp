<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<c:set var="survey_stat_list" value="${requestScope.survey_stat_list}" />
<c:set var="review_count" value="${requestScope.review_count}" />
<c:set var="review_map_list" value="${requestScope.review_map_list}" />
<c:set var="seller_no" value="${requestScope.seller_no}" />

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
	
	button#showAllReviewBtn {
		width : 100%;
		height : 60px;
		border-radius : 15px;
		background-color : transparent;
	}
	
	button#showAllReviewBtn:hover {
		transition : 0.3s ease;
		background-color : black;
		color : white;
	}
	
	img.icon_file {
		filter: invert(69%) sepia(37%) saturate(5887%) hue-rotate(100deg) brightness(99%) contrast(90%);
	}
	
</style>
<div id="review_container">
	<!-- 좋았어요, 최고에요 설문조사 통계 -->
	<div id="like_survey_container">	
		<h4 class="survey_title">이런점이 좋았어요</h4>
		<c:forEach items="${survey_stat_list}" var="survey_stat_map">
				<!-- 좋았어요, 최고에요 설문조사 통계 -->
				<c:if test="${survey_stat_map.pk_survey_no < 5}">
					<div class="survey_item">
						<span>${survey_stat_map.survey_content}</span>
						<div>
							<img src="${ctxPath}/images/icon/user.svg" width=20 />
							<span class="vote_count">${survey_stat_map.count}</span>
						</div>
					</div>
				</c:if>
		</c:forEach>
	</div>
	<!-- 아쉬워요 설문조사 통계 -->
	<div id="dislike_survey_container">	
		<h4 class="survey_title">이런점이 아쉬웠어요</h4>
		<c:forEach items="${survey_stat_list}" var="survey_stat_map">
				<!-- 좋았어요, 최고에요 설문조사 통계 -->
				<c:if test="${survey_stat_map.pk_survey_no >= 5}">
					<div class="survey_item">
						<span>${survey_stat_map.survey_content}</span>
						<div>
							<img src="${ctxPath}/images/icon/user.svg" width=20 />
							<span class="vote_count">${survey_stat_map.count}</span>
						</div>
					</div>
				</c:if>
		</c:forEach>
	</div>
	
	<!-- 최근 5개 후기 내역 -->
	<div id="preview_review_container">
		
		<c:if test="${not empty review_map_list}">
			<h4 style="margin-bottom : 20px;">상세한 후기도 있어요 <span id="total_survey_count">${review_count}</span></h4>
			
			<c:forEach items="${review_map_list}" var="review_map" end="4">			
				<div class="review_item" data-pk_review_no="${review_map.pk_review_no}">
					<div class="reivew_profile">
						<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
						<div class="review_profile_detail">
							<span class="writer_name">${review_map.consumer_name}</span>
							<div style="display : flex; align-items : center;">
								<span>${review_map.review_regdate}</span>
								<c:if test="${not empty review_map.review_img_file_name}">
									<img class="icon_file" src="${ctxPath}/images/icon/file.svg" width="20" />
								</c:if>
							</div>
						</div>
					</div>
					
					<div class="review_content">
						${review_map.review_content}
					</div>
				</div>
			</c:forEach>
			
			<button id="showAllReviewBtn" onclick="showAllReview()">후기 전체 보기</button>
		</c:if>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		// 부정적 후기 설문 문항이 존재하지 않으면 머릿글 지우기
		if($("div#dislike_survey_container div.survey_item").length == 0) {
			$("div#dislike_survey_container h4.survey_title").text("");
		}
		
		// 긍정적 후기 설문 문항이 존재하지 않으면 머릿글 지우기
		if($("div#like_survey_container div.survey_item").length == 0) {
			$("div#like_survey_container h4.survey_title").text("");
		}
		
		// 후기 글 클릭 이벤트
		$(document).on("click", "div.review_item", function(){
			// 리뷰 일련번호
			const pk_review_no = $(this).data("pk_review_no");
			
			// 후기 상세 내역 불러오기
			loadReviewDetails(pk_review_no);
		});
	});

	// 후기 전체 목록 불러오기
	function showAllReview() {		
		$.ajax({
			url : "${pageContext.request.contextPath}/review/all_reviews",
			data : {
				"pk_member_no" : "${seller_no}"
			},
			success : function(html) {
				openSideTab(html);
			},
			error: function(request, status, error){
				errorHandler(request, status, error);
			}
		});
	}
	
	// 후기 상세 내역 불러오기
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
				errorHandler(request, status, error);
			}
		});
	}

</script>