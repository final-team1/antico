<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/paging.css">

<%-- 페이징 --%>
<c:set var="paging" value="${requestScope.paging_dto}" />

<nav class="text-center">
   <ul class="pagination">
      <%-- 첫 페이지 --%>
      <div class="pageBtn_box">
         <li><a class="page_button" href="javascript:void(0);" data-page="1"><span class="pageBtn" aria-hidden="true">&laquo;</span></a></li>
         <%-- 이전 페이지 --%>
         <c:if test="${paging.first_page ne 1}">
            <li><a class="page_button" href="javascript:void(0);" data-page="${paging.first_page-1}"><span class="pageBtn" aria-hidden="true">&lsaquo;</span></a></li>
         </c:if>
      </div>
      <div id="pageNo_box">
         <%-- 페이지 넘버링 --%>
         <c:forEach begin="${paging.first_page}" end="${paging.last_page}" var="i">
            <c:if test="${paging.cur_page ne i}">
               <li><a class="page_button pageNo" href="javascript:void(0);" data-page="${i}">${i}</a></li>
            </c:if>
            <c:if test="${paging.cur_page eq i}">
               <li class="active"><a class="pageNo" href="#">${i}</a></li>
            </c:if>

         </c:forEach>
      </div>
      <div class="pageBtn_box">
         <%-- 다음 페이지 --%>
         <c:if test="${paging.last_page ne paging.total_page_count}">
            <li><a class="page_button" href="javascript:void(0);" data-page="${paging.last_page+1}"><span class="pageBtn" aria-hidden="true">&rsaquo;</span></a></li>
         </c:if>

         <%-- 마지막 페이지 --%>
         <li><a class="page_button" href="javascript:void(0);" data-page="${paging.total_page_count}"><span class="pageBtn" aria-hidden="true">&raquo;</span></a></li>
      </div>
   </ul>
</nav>