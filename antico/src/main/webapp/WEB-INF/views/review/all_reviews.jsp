<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />

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
</style>
<div id="review_container">
	<!-- 최근 5개 후기 내역 -->
	<div id="preview_review_container">
		<h4 style="margin-bottom : 20px;">상세한 후기도 있어요 <span id="total_survey_count">21</span></h4>
		
		<div class="review_item">
			<div class="reivew_profile">
				<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
				<div class="review_profile_detail">
					<span class="writer_name">사용자11</span>
					<span>구매자 &nbsp; 2025-02-08</span>
				</div>
			</div>
			
			<div class="review_content">
				Antico 첫 거래인데 좋은 판매자분 만나서 좋았어요
			</div>
		</div>
		
		<div class="review_item">
			<div class="reivew_profile">
				<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
				<div class="review_profile_detail">
					<span class="writer_name">사용자11</span>
					<span>구매자 &nbsp; 2025-02-08</span>
				</div>
			</div>
			
			<div class="review_content">
				Antico 첫 거래인데 좋은 판매자분 만나서 좋았어요
			</div>
		</div>
		
		<div class="review_item">
			<div class="reivew_profile">
				<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
				<div class="review_profile_detail">
					<span class="writer_name">사용자11</span>
					<span>구매자 &nbsp; 2025-02-08</span>
				</div>
			</div>
			
			<div class="review_content">
				Antico 첫 거래인데 좋은 판매자분 만나서 좋았어요
			</div>
		</div>
		
		<div class="review_item">
			<div class="reivew_profile">
				<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
				<div class="review_profile_detail">
					<span class="writer_name">사용자11</span>
					<span>구매자 &nbsp; 2025-02-08</span>
				</div>
			</div>
			
			<div class="review_content">
				Antico 첫 거래인데 좋은 판매자분 만나서 좋았어요
			</div>
		</div>
		
		<div class="review_item">
			<div class="reivew_profile">
				<img src="${ctxPath}/images/icon/user_circle.svg" width="40" />
				<div class="review_profile_detail">
					<span class="writer_name">사용자11</span>
					<span>구매자 &nbsp; 2025-02-08</span>
				</div>
			</div>
			
			<div class="review_content">
				Antico 첫 거래인데 좋은 판매자분 만나서 좋았어요
			</div>
		</div>
		
		<button id="showAllReviewBtn" onclick="showAllReview()">후기 전체 보기</button>
	</div>
</div>

<script>


</script>