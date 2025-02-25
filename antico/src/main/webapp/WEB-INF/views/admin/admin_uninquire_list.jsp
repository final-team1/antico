<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page=".././header/header.jsp" />

<!-- 메인 콘텐츠 영역 -->
<div class="main">
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

	<div class="paging">
		<jsp:include page="../paging.jsp"></jsp:include>
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
	
	// 페이징 처리 버튼 이벤트
    $(document).on("click", "a.page_button", function() {
       const page = $(this).data("page");

       location.href = "<%= ctxPath%>/admin/admin_uninquire_list?cur_page="+ page;
    });
</script>

<style>
	.main {
		margin: 0 auto;
		width: 70%;
	}

	.main-container {
		display: flex;		
	}

	.content-container {
		flex: 1;
		margin-left: 4%;
	}

	.inquire-list {
		display: flex;
		flex-direction: column;
		margin-top: 20px;
	}

	.inquire-card {
		display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: transparent;
        border: 1px solid #ddd;
        padding: 15px;
        width: 100%;
        text-align: left;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-bottom: 0.8%;
	}

	.inquire-header {
		flex: 1;
	}

	.inquire-title {
		font-size: 13pt;
		font-weight: bold;
	}

	.inquire-info {
		display: flex;
		gap: 10px;
		font-size: 0.9rem;
		color: #555;
	}

	.member-name {
		font-weight: bold;
	}

	.inquire-status {
		color: #0DCC5A;
	}

	.detail-icon i {
		font-size: 1.5rem;
		color: #0DCC5A;
		cursor: pointer;
		transition: color 0.2s;
	}

	.detail-icon i:hover {
		color: #0056b3;
	}

	.paging {
		margin-left: 15%;
		margin-top: 30px;
	}

</style>
