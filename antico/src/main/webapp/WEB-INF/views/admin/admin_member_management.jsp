<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header/header.jsp" />

<div class="main-container">
    <jsp:include page="../admin/admin_sidemenu.jsp" />
    
    <table>
        <thead>
            <tr>
                <th>유저번호</th>
                <th>유저아이디</th>
                <th>유저이름</th>
                <th>유저전화번호</th>
                <th>유저포인트</th>
                <th>유저점수</th>
                <th>유저상태</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${not empty requestScope.member_list}">
                <c:forEach var="MemberVO" items="${requestScope.member_list}">
                    <c:if test="${MemberVO.member_user_id != 'admin'}">
                        <tr>
                            <td>${MemberVO.pk_member_no}</td>
                            <td>${MemberVO.member_user_id}</td>
                            <td>${MemberVO.member_name}</td>
                            <td>${MemberVO.member_tel}</td>
                            <td>${MemberVO.member_point}</td>
                            <td>${MemberVO.member_score}</td>
                            <td class="status" data-member-no="${MemberVO.pk_member_no}">
							    <span class="status-text">
							        <c:choose>
							            <c:when test="${MemberVO.member_status == 0}">
							                비활동
							            </c:when>
							            <c:when test="${MemberVO.member_status == 1}">
							                활동
							            </c:when>
							            <c:when test="${MemberVO.member_status == 2}">
							                정지
							            </c:when>
							        </c:choose>
							    </span>
							    <select class="status-dropdown" style="display:none;">
							        <option value="0">비활동</option>
							        <option value="1">활동</option>
							        <option value="2">정지</option>
							    </select>
							</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </c:if>
            
            <c:if test="${empty requestScope.member_list}">
                <tr>
                    <td colspan="7">유저가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<div style="height: 20px;">
	<jsp:include page="../paging.jsp"></jsp:include>
</div>

<jsp:include page="../footer/footer.jsp" />

<script>
$(document).ready(function() {
	// 유저 상태 변경 이벤트
    $('table tbody tr .status').on('click', function() {
        const member_no = $(this).data('member-no');
        const member_name = $(this).parent("tr").find("td:nth-child(3)").text()
        const status_text = $(this).find('.status-text');
        const status_dropdown = $(this).find('.status-dropdown');
        const current_status = status_text.text().trim();
        
        $('table tbody tr .status-dropdown').not(status_dropdown).hide();
        $('table tbody tr .status-text').not(status_text).show();
        
        if (status_dropdown.is(":hidden")) {
            status_dropdown.show();
            status_text.hide();

            status_dropdown.change(function() {
                const new_status = $(this).val();

                // 서버에 상태 변경 요청
                $.ajax({
                    url: "<%= ctxPath%>/admin/admin_member_status",
                    type: "POST",
                    data: {
                        member_no: member_no,
                        new_status: new_status
                    },
                    dataType: "json",
                    success: function(json) {
                        if (json.success) {
                            status_text.text(status_dropdown.find('option:selected').text());
                            status_dropdown.hide();
                            status_text.show();
                            showAlert("success", member_name + "님이 상태가 변경 되었습니다");
                        } 
                        else {
                            alert('상태 변경 실패');
                        }
                    },
                    error: function() {
                        alert('서버 요청 실패');
                    }
                });
            });
        }
    });
});

//페이징 처리 버튼 이벤트
$(document).on("click", "a.page_button", function() {
   const page = $(this).data("page");

   location.href = "<%= ctxPath%>/admin/admin_member_management?cur_page="+ page;
});
</script>

<style>
	.main-container {
	    display: flex;
	    width: 70%;
	    margin: 0 auto;
	    margin-bottom: 2%;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-left: 3%;
	}
	
	th, td {
	    padding: 10px;
	    text-align: center;
	}
	
	th {
	    background-color: #f4f4f4;
	}
	
	tr:hover {
	    background-color: #e0e0e0;
	    cursor: pointer;
	}

	.status-cell {
	    cursor: pointer;
	}
	
	select {
	    width: 100%;
	    padding: 5px;
	    font-size: 14px;
	}
</style>
