<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page=".././header/header.jsp" />

<div style="display: flex; width: 70%; margin: 0 auto;" >

	<jsp:include page=".././admin/admin_sidemenu.jsp" />
	
	<div style="width: 80%; margin-left: 5%;">
		<h2>공지사항 작성</h2>
		
		<form name="addFrm" enctype="multipart/form-data">
	   		<table class="table table-bordered">  		     
	   		     <tr>
					<th>제목</th>
					<td>
						<input type="text" name="notice_title" size="110" maxlength="50" style="border-width: 0;"/>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>	
					<td>
						<textarea name="notice_content" id="content" style="width: 100%; height: 200px; resize:none; border-width: 0;"></textarea>
				        <div id="image-preview" style="margin-top: 10px; display: none;">
				            <img id="preview-image" src="" alt="이미지 미리보기" style="max-width: 200px; border: 1px solid #ccc; padding: 5px;" />
				        </div>
					</td>
				</tr>
				
				<tr>
			        <th>파일첨부</th>
			        <td>
				        <label for="file-upload" class="custom-file-upload">
			            	파일 선택
				        </label>
				        <input type="file" name="attach" id="file-upload" />
				        <span id="file-name">선택된 파일 없음</span>				        
			        </td>
		    	</tr>
	
	   		</table>
	  		
	   		<div>
	            <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
	            <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
	        </div>   		
	   </form>
   </div>
</div>

<jsp:include page=".././footer/footer.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		// 파일이 선택될 때마다 파일명 표시 및 이미지 미리보기 처리
		$("#file-upload").change(function() {
			const fileName = $(this).val().split('\\').pop();
			if (fileName) {
				$("#file-name").text(fileName);
			} else {
				$("#file-name").text("선택된 파일 없음");
			}

			// 파일이 이미지인 경우 미리보기
			const file = $(this)[0].files[0];
			if (file && file.type.startsWith("image/")) {
				const reader = new FileReader();
				reader.onload = function(e) {
					$("#preview-image").attr("src", e.target.result);
					$("#image-preview").show(); 
				};
				reader.readAsDataURL(file);
			} else {
				$("#image-preview").hide();
			}
		});

		$("#btnWrite").click(function() {
			// 폼(form)을 전송(submit)
		    const frm = document.addFrm;
		    frm.method = "post";
		    frm.action = "<%= ctxPath %>/admin/admin_notice_write";
		    frm.submit();
		});
	});
</script>

<style>
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
    th {
    	text-align: center;
    	vertical-align: middle;
    	width: 8.5%;
    }
</style>
