<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<div class="container" style="padding: 15px; border-bottom: 2px solid #000;">
	
	<div style="display: flex; width: 100%;">
		<div>
			<span style="display:inline-block; font-size:10pt; background-color:black; color:white; padding: 1% 1%;  border: 1px solid; text-align: center; border-radius: 4px; margin: 0 0 5% 0;">답변완료</span>
			
			<p>팀장님 놀러갈게요 집비워놓으세요</p>
			<span style="display: flex; font-size: 8pt;">
				<span>아이디</span>
				&nbsp;
				|
				&nbsp;
				<span>문의날짜</span>
				&nbsp;
				|
				&nbsp;
				<span>공개</span>
			</span>
		</div>		
		<i class="fa-solid fa-chevron-right" style="margin-left: 50%; margin-top: 5.5%;"></i>
	</div>
	

</div>