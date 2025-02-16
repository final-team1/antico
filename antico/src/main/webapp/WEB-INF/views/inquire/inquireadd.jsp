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
				<input type="text" name="subject" size="65" maxlength="50" style="border-width: 0;"/>
			</td>
		</tr>
		
		<tr>
			<th style="text-align: center; vertical-align: middle;">내용</th>	
			<td>
				<textarea name="content" id="content" style="width: 100%; height: 400px; resize:none; border-width: 0;"></textarea>
			</td>
		</tr>
		
		<tr>
	        <th>파일첨부</th>
	        <td>
		        <label for="file-upload" class="custom-file-upload">
	            	파일 선택
		        </label>
		        <input type="file" name="attach" id="file-upload" onchange="displayFileName()" />
		        <span id="file-name">선택된 파일 없음</span>
	        </td>
    	</tr>
	</table>
	
	<button class="inquire-list-btn" type="button" style="background-color: #fff; border-radius: 5px; padding: 10px 5px;">제출하기</button>
	
</form>

<style>
	th {
        width: 75px; /* th 태그의 너비를 고정시키거나 늘림 */
        text-align: center;
        vertical-align: middle;
    }
    td {
        width: 450px; /* td 태그의 너비를 줄임 */
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
    .inquire-list-btn {
    	margin-left: 83%;
    }   
    .inquire-list-btn:hover {
        background-color: #eee !important;
    }
    input:focus {
        outline: none;
    }
    textarea:focus {
    	outline: none;
    }
</style>


<script type="text/javascript">
	function displayFileName() {
	    var fileInput = document.getElementById("file-upload");
	    var fileNameDisplay = document.getElementById("file-name");
	    
	    // 선택된 파일이 있을 경우 파일명 표시
	    if (fileInput.files.length > 0) {
	        fileNameDisplay.textContent = fileInput.files[0].name;
	    } else {
	        fileNameDisplay.textContent = "선택된 파일 없음";
	    }
	}
</script>
