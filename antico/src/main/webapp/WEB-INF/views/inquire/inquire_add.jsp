<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>
<i class="fa-solid fa-bell" style="margin-bottom: 3%;">&nbsp;&nbsp;문의하신 사항은 확인 후 영업일 2~5일 이내 순차적으로 답변 드리겠습니다.</i>
<form name="addFrm" enctype="multipart/form-data">
	<table style="width: 625px; table-layout: fixed;" class="table table-bordered">	
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="inquire_title" size="65" maxlength="50" style="border-width: 0;"/>
			</td>
		</tr>
		
		<tr>
			<th style="text-align: center; vertical-align: middle;">내용</th>	
			<td>
				<textarea name="inquire_content" id="content" style="width: 100%; height: 400px; resize:none; border-width: 0;"></textarea>

				<div id="file-preview-container" style="display: none;"> 
				    <img id="file-preview" src="" alt="미리보기" style="width: 500px; height: 185px; display: block;">
				</div>
			</td>
		</tr>
		
		<tr>
	        <th>파일첨부</th>
	        <td>
		        <label for="file-upload" class="custom-file-upload">
	            	파일 선택
		        </label>
		        <input type="file" name="attach" id="file-upload" onchange="displayFilePreview()" />
		        <span id="file-name">선택된 파일 없음</span>
	        </td>
    	</tr>
	</table>
	
	
	
	<div class="btns">
		<div class="toggle-btn" onclick="toggleVisibility()">
	        <i id="toggle-icon" class="fa-solid fa-toggle-off"></i>
	        <span id="toggle-text">&nbsp;&nbsp;공개</span>
	    </div>
	    <input type="hidden" name="inquire_secret" id="inquire_secret" value="0"> <!-- 초기값을 '0'으로 설정 -->	     
	    <button class="inquire-add-btn" type="button" style="background-color: #fff; border-radius: 5px; padding: 10px 5px;">제출하기</button>
	</div>
</form>

<script type="text/javascript">

	let isPublic = true;

	// 파일 선택 후 미리보기
	function displayFilePreview() {
	    var fileInput = $("#file-upload")[0];
	    var fileNameDisplay = $("#file-name");
	    var previewContainer = $("#file-preview-container");
	    var previewImage = $("#file-preview");
	    
	    if (fileInput.files.length > 0) {
	        var file = fileInput.files[0];
	        fileNameDisplay.text(file.name);
	        
	        if (file.type.startsWith("image/")) {
	            var fileReader = new FileReader();
	            fileReader.onload = function(e) {
	                previewImage.attr("src", e.target.result);
	                previewContainer.show();
	            };
	            
	            fileReader.readAsDataURL(file);
	        } 
	        else {
	            previewContainer.hide();
	        }
	    } 
	    else {
	        fileNameDisplay.text("선택된 파일 없음");
	        previewContainer.hide();
	    }
	}

	function toggleVisibility() {
	    const icon = $("#toggle-icon");
	    const text = $("#toggle-text");
	    const secret = $("#inquire_secret");

	    if (isPublic) {
	        icon.removeClass("fa-toggle-off").addClass("fa-toggle-off fa-flip-horizontal");
	        text.html("&nbsp;&nbsp;비공개");
	        secret.val("1");  // 비공개일 때는 '1'
	    } 
	    else {
	        icon.removeClass("fa-toggle-off fa-flip-horizontal").addClass("fa-toggle-off");
	        text.html("&nbsp;&nbsp;공개");
	        secret.val("0");  // 공개일 때는 '0'
	    }
	    isPublic = !isPublic; // 상태를 반전
	}

	$(document).ready(function(){
		// 글쓰기 버튼
		$("button.inquire-add-btn").click(function(){
			// === 글제목 유효성 검사 === 
	        const title = $("input[name='inquire_title']").val().trim();	  
	        if(title == "") {
	    	    alert("글제목을 입력하세요!!");
	    	    $("input[name='inquire_title']").val("");
	    	    return; // 종료
	        }
	        
	        const content = $("textarea[name='inquire_content']").val().trim();
	        if(content.length == 0) {
	    	    alert("글내용을 입력하세요!!");
	    	    return; // 종료
	        }
	        
/* 	        const attach = $(e.target)[0].files[0];
			// 이미지 파일 크기 제한 최대 5MB
			if(attach.size > 1024 * 1024 * 5) {
				showAlert("warning", "업로드 이미지는 최대 5MB까지 가능합니다.");
				return;
			} */
	        
	        // 폼(form)을 전송(submit)
		    const frm = document.addFrm;
		    frm.method = "post";
		    frm.action = "<%= ctxPath %>/inquire/inquire_add";
		    frm.submit();
		});
	});
</script>


<style>
	th {
        width: 75px;
        text-align: center;
        vertical-align: middle;
    }
    td {
        width: 450px;
    }    
    input[type="file"] {
        display: none;
    }
    .custom-file-upload {
        display: inline-block;
        padding: 5px 5px;
        background-color: #fff;
        border: solid 1px black;
        color: black;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }  
    .custom-file-upload:hover {
        background-color: #eee;
    }
    .inquire-add-btn {
    	
    }   
    .inquire-add-btn:hover {
        background-color: #eee !important;
    }
    input:focus {
        outline: none;
    }
    textarea:focus {
    	outline: none;
    }
    
    .btns {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 95%;
    }
    .toggle-btn {
        cursor: pointer;
        display: flex;
        align-items: center;
    }
    .fa-toggle-off {
        font-size: 40px;
    }
    .inquire-add-btn {
        background-color: #fff;
        border-radius: 5px;
        padding: 10px 20px;
        border: 1px solid #ccc;
    }
</style>

