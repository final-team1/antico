<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="./header/header.jsp" />

<c:forEach items="${RequestScope.list}" var="str">
	${str}	
</c:forEach>
	
<jsp:include page="./footer/footer.jsp" />
