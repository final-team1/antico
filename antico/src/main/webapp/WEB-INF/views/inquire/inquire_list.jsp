<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<c:if test="${not empty requestScope.inquire_list}">
	<c:forEach var="InquireVO" items="${requestScope.inquire_list}" varStatus="status">
		<div class="container inquire-container">
		
			<div class="inquire-header">
				<div>			
					<span class="inquire-status">
						<c:choose>
						    <c:when test="${InquireVO.inquire_status == 0}">
						        미답변
						    </c:when>
						    <c:when test="${InquireVO.inquire_status == 1}">
						        답변완료
						    </c:when>
					    </c:choose>
					</span>
					
					<p class="inquire-title">${InquireVO.inquire_title}</p>
					<span class="inquire-details">
						<span>${InquireVO.fk_member_no}</span>
						&nbsp;|&nbsp;
						<span>${InquireVO.inquire_regdate}</span>
						&nbsp;|&nbsp;
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
	            <div class="detail-icon">
	                <i class="fa-solid fa-chevron-right" onclick="showinquiredetailTab('${InquireVO.pk_inquire_no}')"></i>                
	            </div>
			</div>
		</div>
	</c:forEach>
</c:if>


<script>

	// 1:1 문의 상세보기 함수
	function showinquiredetailTab(pk_inquire_no) {
		var tabTitle = "문의내역 상세";
		
		$.ajax({
			url : "<%= ctxPath%>/inquire/inquire_detail",
			data : {"pk_inquire_no": pk_inquire_no},
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

<style>
	/* 문의 항목 컨테이너 */
	.inquire-container {
	    padding: 15px;
	    border-bottom: 2px solid #000;
	}
	
	/* 문의 항목 헤더 */
	.inquire-header {
	    display: flex;
	    width: 100%;
	    justify-content: space-between;
	}
	
	/* 문의 상태 스타일 */
	.inquire-status {
	    display: inline-block;
	    font-size: 10pt;
	    background-color: black;
	    color: white;
	    padding: 1% 1%;
	    border: 1px solid;
	    text-align: center;
	    border-radius: 4px;
	    margin-bottom: 8%;
	}
	
	/* 문의 제목 스타일 */
	.inquire-title {
	    font-size: 12pt;
	    margin: 0;
	}
	
	/* 문의 세부 사항 (회원 번호, 등록 날짜, 공개 여부) */
	.inquire-details {
	    display: flex;
	    font-size: 8pt;
	}
	
	/* 세부 아이콘 (상세보기 버튼) */
	.detail-icon {
	    margin-top: 5%;
	    cursor: pointer;
	}
	
	/* 아이콘 클릭 시 커서 모양 변경 */
	.detail-icon i {
	    cursor: pointer;
	}

</style>











