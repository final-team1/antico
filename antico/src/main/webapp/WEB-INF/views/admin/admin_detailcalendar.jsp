<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
%>

<jsp:include page=".././header/header.jsp" />

<div id="container">
    <jsp:include page=".././admin/admin_sidemenu.jsp" />
    
    <div style="margin-left: 3%;">
	    <h3 style="display: inline-block;">일정 상세보기</h3>&nbsp;&nbsp;<a href="<%= ctxPath%>/admin/admin_page"><span>◀캘린더로 돌아가기</span></a> 
	
		<table id="schedule" class="table table-bordered">
			<tr>
				<th style="width: 160px; vertical-align: middle;">일자</th>
				<td>
					<span id="startdate">${requestScope.map.calendar_startdate}</span>&nbsp;~&nbsp;<span id="enddate">${requestScope.map.calendar_enddate}</span>&nbsp;&nbsp;  
					<input type="checkbox" id="allDay" disabled/>&nbsp;종일
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">제목</th>
				<td>${requestScope.map.calendar_title}</td>
			</tr>
	
			<tr>
				<th style="vertical-align: middle;">장소</th>
				<td>${requestScope.map.calendar_place}</td>
			</tr>
	
			<tr>
				<th style="vertical-align: middle;">내용</th>
				<td><textarea id="content" rows="10" cols="100" style="height: 200px; border: none;" readonly>${requestScope.map.calendar_content}</textarea></td>
			</tr>
	
		</table>
	
		<div style="float: right;">
			<c:if test="${not empty requestScope.listgobackURL_schedule}">
				<button type="button" id="edit" class="btn_normal" onclick="editcalendar('${requestScope.map.pk_calendar_no}')">수정</button>
				<button type="button" class="btn_normal" onclick="delcalendar('${requestScope.map.pk_calendar_no}')">삭제</button>
			
				<button type="button" id="cancel" class="btn_normal" style="margin-right: 0px;" onclick="javascript:location.href='<%= ctxPath%>${requestScope.listgobackURL_schedule}'">취소</button> 
			</c:if>
			
			<c:if test="${empty requestScope.listgobackURL_schedule}">
				<button type="button" id="edit" class="btn_normal" onclick="editcalendar('${requestScope.map.pk_calendar_no}')">수정</button>
				<button type="button" class="btn_normal" onclick="delcalendar('${requestScope.map.pk_calendar_no}')">삭제</button>
			
				<button type="button" id="cancel" class="btn_normal" style="margin-right: 0px;" onclick="javascript:location.href='<%= ctxPath%>/admin/admin_page'">취소</button> 
			</c:if>
			
		</div>
	</div>
</div>

<form name="goEditFrm">
	<input type="hidden" name="pk_calendar_no"/>
	<input type="hidden" name="gobackURL_detailSchedule" value="${requestScope.gobackURL_detailSchedule}"/>
</form>

<jsp:include page=".././footer/footer.jsp" />

<script type="text/javascript">
	$(document).ready(function(){
		// 종일체크박스에 체크 유무 판단
		var str_startdate = $("span#startdate").text();

		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);

		var start_hour = str_startdate.substring(target-2,target);

		var str_enddate = $("span#enddate").text();

		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);

		var end_hour = str_enddate.substring(target-2,target);
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}		
	});
	
	// 일정 삭제하기
	function delcalendar(pk_calendar_no){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/admin/admin_deletecalendar",
				type: "post",
				data: {"pk_calendar_no":pk_calendar_no},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						showAlert("success", "일정을 삭제하였습니다.");
					}
					else {
						showAlert("success", "일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/admin/admin_page";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	};

	// 일정 수정하기
	function editcalendar(pk_calendar_no){
		var frm = document.goEditFrm;
		frm.pk_calendar_no.value = pk_calendar_no;
		frm.action = "<%= ctxPath%>/admin/admin_editcalendar";
		frm.method = "post";
		frm.submit();
	};
</script>

<style>
 	#container {
        display: flex;
        width: 70%;
        margin: 0 auto;
    }
</style>