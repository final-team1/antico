<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
    
<jsp:include page=".././header/header.jsp" />    


<form action="${ctxPath}/auth/login" method="post">
	
	<input type="text" name="mem_user_id"/>
	
	<input type="text" name="mem_passwd"/>
	
	<input type="submit"/>
	
</form>



<jsp:include page=".././footer/footer.jsp" />