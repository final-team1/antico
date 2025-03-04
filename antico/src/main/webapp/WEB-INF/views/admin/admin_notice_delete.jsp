<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header/header.jsp" />

<div class="main-container">
    <jsp:include page="../admin/admin_sidemenu.jsp" />

    <section class="notice-section">
        <h3>공지사항</h3>

        <!-- 공지사항 목록 -->
        <c:if test="${not empty requestScope.notice_list}">
            <ul class="notice-list">
                <c:forEach var="NoticeVO" items="${requestScope.notice_list}">
                    <li class="notice-item">
                        <button class="notice-item-button">
                            <span class="notice-title">${NoticeVO.notice_title}</span>

                            <span class="delete-btn" onclick="delete_Notice('${NoticeVO.pk_notice_no}')">
                                삭제
                            </span>
                        </button>
                    </li>
                </c:forEach>
            </ul>
        </c:if>

        <c:if test="${empty requestScope.notice_list}">
            <ul class="notice-list">
                <li class="notice-item">
                    <button class="notice-item-button no-notice">공지사항이 없습니다.</button>
                </li>
            </ul>
        </c:if>

        <div class="paging" style="height: 20px;">
			<jsp:include page="../paging.jsp"></jsp:include>
		</div>
    </section>
</div>

<jsp:include page="../footer/footer.jsp" />

<script type="text/javascript">

    // 페이징 처리 버튼 이벤트
    $(document).on("click", "a.page_button", function() {
        const page = $(this).data("page");
        location.href = "<%= ctxPath %>/admin/admin_notice_delete?cur_page=" + page;
    });
    
    function delete_Notice(pk_notice_no) {

		$.ajax({
			url : "<%= ctxPath%>/admin/admin_notice_delete",
			type:"post",
			data : {"pk_notice_no": pk_notice_no},
			dataType:"json",
			success : function(json) {
				if(json.n == 1) {
					alert("성공");
					location.href = "<%= ctxPath %>/admin/admin_notice_delete";
				}
			},
			error : function(e) {
				alert("실패");
			}
		});
	}
    
</script>

<style>

    .main-container {
        display: flex;
        width: 70%;
        margin: 0 auto;
    }

    .notice-section {
        width: 70%;
        margin-left: 5%;
    }

    .notice-section h3 {
        font-size: 24px;
        text-align: center;
        margin-bottom: 20px;
    }

    .notice-list {
        padding: 0;
        margin: 0;
        width: 100%;
    }

    .notice-item {
        list-style: none;
        margin-bottom: 10px;
    }

    .notice-item-button {
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
    }

    .notice-title {
        font-weight: bold;
    }

    /* 삭제 버튼 스타일 */
    .delete-btn {
        background-color: transparent;
        border: none;
        color: #0DCC5A;
        font-size: 16px;
        cursor: pointer;
        padding: 0;
        transition: color 0.3s ease;
    }

    .delete-btn:hover {
        color: darkred;
    }

    .no-notice {
        color: gray;
        font-size: 14px;
        text-align: center;
        padding: 15px;
    }

    .content-container {
        width: 80%;
        margin-left: 5%;
    }
    .paging {
		margin-top: 3%;
	}
</style>
