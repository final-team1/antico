<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <span class="answer-title">${answer.title}</span>
        <p class="answer-text">${answer.content}</p>
        <span class="answer-date">${answer.regdate}</span>
    </div>
</div>

<div class="answer-form-container">
    <h5>답변 작성</h5>
    <form name="addFrm" action="${pageContext.request.contextPath}/submitAnswer" method="POST" enctype="multipart/form-data">
        <table>
            
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="comment_content" id="comment_content" placeholder="답변을 작성하세요..." class="textarea-field" required style="resize:none;"></textarea>
                    <div id="file-preview-container" style="display: none;">
                        <img id="file-preview" src="" alt="미리보기" style="width: 100%; max-width: 500px; height: auto;">
                    </div>
                </td>
            </tr>

            
            <tr>
                <th style="width: 10%;">파일첨부</th>
                <td>
                    <input type="file" name="attach" id="file-upload"/>
                </td>
            </tr>
        </table>

        
        <button type="button" class="submit-btn">답변 달기</button>
    </form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$("button.submit-btn").click(function(){
			// 폼(form)을 전송(submit)
		    const frm = document.addFrm;
		    frm.method = "post";
		    frm.action = "<%= ctxPath %>/comment/comment_add";
		    frm.submit();
		});
	});
</script>

<style>
    .inquire-container, .answer-container, .reply-container {
        margin-bottom: 20px;
    }

    /* 문의 내용 */
    .inquire-container {
        padding: 15px;
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

    /* 답변 내용 */
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

    /* 답변 폼 */
    .answer-form-container, .reply-form-container {
        margin-top: 20px;
    }

    .textarea-field {
        width: 100%;
        height: 150px;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .submit-btn {
        margin-top: 10px;
        padding: 8px 16px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
    }

    .submit-btn:hover {
        background-color: #0056b3;
    }
</style>
