<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<c:if test="${not empty requestScope.inquire_list}">
	<c:forEach var="InquireVO" items="${requestScope.inquire_list}" varStatus="status">
		<div class="container" style="padding: 15px; border-bottom: 2px solid #000;">
		
			<div style="display: flex; width: 100%;">
				<div>			
					<span style="display:inline-block; font-size:10pt; background-color:black; color:white; padding: 1% 1%;  border: 1px solid; text-align: center; border-radius: 4px; margin: 0 0 8% 0;">
						<c:choose>
						    <c:when test="${InquireVO.inquire_status == 0}">
						        미답변
						    </c:when>
						    <c:when test="${InquireVO.inquire_status == 1}">
						        답변완료
						    </c:when>
					    </c:choose>
					</span>
					
					<p>${InquireVO.inquire_title}</p>
					<span style="display: flex; font-size: 8pt;">
						<span>${InquireVO.fk_member_no}</span>
						&nbsp;
						|
						&nbsp;
						<span>${InquireVO.inquire_regdate}</span>
						&nbsp;
						|
						&nbsp;
						<span>
							<c:choose>
							    <c:when test="${InquireVO.inquire_secret == 0}">
							        공개
							    </c:when>
							    <c:when test="${InquireVO.inquire_secret == 1}">
							        비공개
							    </c:when>
						    </c:choose>
						</span>
					</span>		
				</div>
				<i class="fa-solid fa-chevron-right" id="btn-inquirelist" style="margin-left: 50%; margin-top: 5.5%; cursor: pointer;"></i>
			</div>
		</div>
	</c:forEach>
</c:if>

<script>

	$(document).ready(function() {
		
		$("i#btn-inquirelist").on("click", function() {
            showinquiredetailTab();
        });
		
	});
	
	// 1:1 문의 상세보기 함수
	function showinquiredetailTab() {
		var tabTitle = "문의내역 상세";
		
		$.ajax({
			url : "<%=ctxPath%>/inquire/inquire_detail",
			success : function(html) {
				openSideTab(html, tabTitle);
			},
			error : function(e) {
				console.log(e);
				// 예외처리 필요
				alert("불러오기 실패");
				closeSideTab();
			}
		});
	}

</script>












