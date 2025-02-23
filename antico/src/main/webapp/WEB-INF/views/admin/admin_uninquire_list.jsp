<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page=".././header/header.jsp" />

<!-- 메인 콘텐츠 영역 -->
<div class="main-container">
	<jsp:include page=".././admin/admin_sidemenu.jsp" />
	
	<div class="content-container">
		<c:if test="${not empty requestScope.uninquire_list}">
			<div class="inquire-list">
				<c:forEach var="InquireVO" items="${requestScope.uninquire_list}" varStatus="status">
					<c:if test="${InquireVO.inquire_status == 0}">
						<div class="inquire-card">
							<div class="inquire-header">
								<p class="inquire-title">제목 : ${InquireVO.inquire_title}</p>
								<span class="inquire-info">
									<span class="member-name">${InquireVO.member_name}</span>
									<span class="inquire-date">${InquireVO.inquire_regdate}</span>
									<span class="inquire-status">
										<c:choose>
										    <c:when test="${InquireVO.inquire_secret == 0}">공개</c:when>
										    <c:when test="${InquireVO.inquire_secret == 1}">비공개</c:when>
										</c:choose>
									</span>
								</span>
							</div>
							<div class="detail-icon">
								<i class="fa-solid fa-chevron-right" onclick="showinquiredetailTab('${InquireVO.pk_inquire_no}')"></i>                
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>	
		</c:if>
   </div>
</div>

<jsp:include page=".././footer/footer.jsp" />
<jsp:include page="../tab/tab.jsp"></jsp:include>

<script type="text/javascript">
	//1:1 문의 상세보기 함수
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
				alert("불러오기 실패");
				closeSideTab();
			}
		});
	}
</script>

<!-- 스타일 -->
<style>
	/* 전체 컨테이너 */
	.main-container {
		display: flex;
		width: 70%;
		margin: 0 auto;
	}

	/* 사이드 메뉴 */
	.content-container {
		width: 80%;
		margin-left: 5%;
	}

	/* 문의 목록 */
	.inquire-list {
		display: flex;
		flex-direction: column;
		gap: 20px;
	}

	/* 각 문의 항목 카드 */
	.inquire-card {
		display: flex;
		justify-content: space-between;
		background: #ffffff;
		border-radius: 10px;
		box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		padding: 20px;
		cursor: pointer;
	}

	.inquire-card:hover {
		transform: translateY(-5px);
		box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	}

	/* 제목 */
	.inquire-title {
		font-size: 1.2rem;
		font-weight: bold;
		color: #333;
	}

	/* 세부 정보 영역 */
	.inquire-info {
		display: flex;
		flex-direction: row;
		gap: 10px;
		color: #777;
		font-size: 11pt;
	}

	.inquire-status {
		font-weight: 600;
		color: #0DCC5A;
	}

	.detail-icon i {
		font-size: 1.5rem;
		color: #333;
		transition: color 0.3s;
	}

	.detail-icon i:hover {
		color: #0DCC5A;
	}
</style>
