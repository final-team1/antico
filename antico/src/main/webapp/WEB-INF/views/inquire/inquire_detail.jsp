<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<div class="container inquire-container">
	<h5>Q.</h5>
	<div class="inquire-content">
		<span class="inquire-label">문의 내용 :</span>
		<span class="inquire-text">${requestScope.inquirevo.inquire_content}</span>
		<span class="inquire-date">${requestScope.inquirevo.inquire_regdate}</span>
	</div>
</div>

<div class="container answer-container">
	<h5>A.</h5>
	<div class="answer-box">
		<span class="answer-title">제목</span>
		<p class="answer-text">aaaaa</p>
		<span class="answer-date">2025-12-12</span>
	</div>
</div>

<style>
	/* 문의 내용 컨테이너 */
	.inquire-container {
	    padding: 15px;
	    border-bottom: 2px solid #000;
	}
	
	/* 문의 내용 섹션 */
	.inquire-content {
	    flex-direction: column;
	    display: flex;
	}
	
	/* 문의 내용 제목 */
	.inquire-label {
	    font-size: 13pt;
	    padding-bottom: 1%;
	}
	
	/* 문의 내용 텍스트 */
	.inquire-text {
	    font-size: 12pt;
	    padding-bottom: 1%;
	}
	
	/* 문의 날짜 */
	.inquire-date {
	    font-size: 8pt;
	}
	
	/* 답변 내용 컨테이너 */
	.answer-container {
	    padding: 15px;
	}
	
	/* 답변 박스 */
	.answer-box {
	    padding: 20px;
	    border: 2px solid #eee;
	    background-color: #eee;
	    border-radius: 10px;
	}
	
	/* 답변 제목 */
	.answer-title {
	    font-size: 13pt;
	}
	
	/* 답변 텍스트 */
	.answer-text {
	    font-size: 12pt;
	    padding: 2% 0 1% 0;
	}
	
	/* 답변 날짜 */
	.answer-date {
	    font-size: 8pt;
	}

</style>

