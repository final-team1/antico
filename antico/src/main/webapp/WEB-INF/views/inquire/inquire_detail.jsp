<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container inquire-container">
    <h5>Q.</h5>
    <div class="inquire-content">
        <span class="inquire-label">문의 내용 :</span>
        <span class="inquire-text">${requestScope.inquirevo.inquire_content}</span>
        <span class="inquire-date">${requestScope.inquirevo.inquire_regdate}</span>
    </div>
</div>

<c:forEach var="comment" items="${requestScope.comment_list}" varStatus="status">
		<div class="container answer-container">	
			<c:if test="${comment.member_name.equals('관리자')}">
		    	<h5>A.</h5>
		    </c:if>
		    <c:if test="${comment.fk_member_no == requestScope.inquirevo.fk_member_no}">
		    	<h5>Q.</h5>
		    </c:if>
		    <div class="answer-box">
		        <p class="answer-text">${comment.comment_content}</p>
		        <span class="answer-date">${comment.comment_regdate}</span>
		        &nbsp;|&nbsp;
		        <span class="answer-date">${comment.member_name}</span>
		    </div>    
		</div>
</c:forEach>

<c:if test="${requestScope.member_name.equals('관리자') || requestScope.member_no.equals(requestScope.inquirevo.fk_member_no)}">
	<div class="answer-form-container">
	    <h5>답변 작성</h5>
	    <form name="addFrm" enctype="multipart/form-data">
	        <input type="hidden" name="pk_inquire_no" value="${requestScope.inquirevo.pk_inquire_no}" />
	        <input type="hidden" name="fk_parent_no" value="${requestScope.fk_parent_no}" />
	        <input type="hidden" name="comment_depth_no" value="${requestScope.comment_depth_no}" />

	        <div class="form-group">
	            <label for="comment_content">내용</label>
	            <textarea name="comment_content" id="comment_content" class="textarea-field" placeholder="답변을 작성하세요..." required></textarea>
	        </div>

	        <div class="form-group">
	            <label for="file-upload">파일첨부</label>
	            <input type="file" name="attach" id="file-upload" />
	        </div>

	        <button type="button" class="submit-btn">답변 달기</button>
	    </form>
	</div>
</c:if>

<script type="text/javascript">
	$(document).ready(function() {
	    $("button.submit-btn").click(function() {
	        const frm = document.addFrm;
	        const pk_inquire_no = $("input[name='pk_inquire_no']").val();
	        const fk_parent_no = $("input[name='fk_parent_no']").val();
	        frm.method = "post";
	        frm.action = "<%= ctxPath %>/comment/comment_add?pk_inquire_no=" + pk_inquire_no + "&fk_parent_no=" + fk_parent_no;
	        frm.submit();
	    });
	});
</script>

<style>
    .inquire-container, .answer-container {
        margin-bottom: 30px;
    }

    .inquire-container {
        padding: 20px;
        border-bottom: 2px solid #ccc;
    }

    .inquire-label {
        font-weight: bold;
    }

    .inquire-text {
        font-size: 14px;
        display: block;
        margin: 5px 0;
    }

    .inquire-date {
        font-size: 12px;
        color: #999;
    }

    .answer-container {
        padding: 15px;
        border: 2px solid #eee;
        background-color: #fafafa;
        border-radius: 5px;
    }

    .answer-title {
        font-size: 16px;
        font-weight: bold;
    }

    .answer-text {
        font-size: 14px;
        margin-top: 10px;
    }

    .answer-date {
        font-size: 12px;
        color: #999;
        margin-top: 10px;
    }

    /* 답변 작성 폼 스타일 */
    .answer-form-container {
        margin-top: 30px;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        background-color: #f9f9f9;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        font-size: 14px;
        font-weight: bold;
    }

    .textarea-field {
        width: 100%;
        height: 150px;
        padding: 12px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: none;
    }

    .submit-btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
    }

    .submit-btn:hover {
        background-color: #0056b3;
    }

    .submit-btn:focus {
        outline: none;
    }

    input[type="file"] {
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 5px;
        width: 100%;
    }

    input[type="file"]:focus {
        outline: none;
        border-color: #007bff;
    }
</style>
