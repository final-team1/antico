<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>
<script src="https://kit.fontawesome.com/0c69fdf2c0.js" crossorigin="anonymous"></script>
<jsp:include page=".././header/header.jsp" />

<div class="container" style="padding: 30px;">
	<h2 style="text-align: center;">고객센터</h2>
	
	<hr style="border: 1.5px solid black; width: 90%;">	
	
	<h3 style="width: 90%; margin: 0 auto 1% auto;">공지사항</h3>
	
	<div style="border: solid 1px black; padding: 0.5%; border-radius: 10px; width: 90%; margin: 0 auto 3% auto;">
		<form name="searchFrm" style="margin: 0; padding: 0;">
			<label style="margin: 0; padding: 0; width: 100%; display: flex;">
				<span style="padding: 1%;">
					<i class="fa-solid fa-magnifying-glass"></i>
				</span>
				&nbsp;&nbsp;
				<input type="text" name="searchWord" autocomplete="off" style="border: none; width: 100%; outline: none;" /> 
				<input type="text" style="display: none;"/>
			</label>
		</form>
	</div>
		
	<c:if test="${not empty requestScope.notice_list}">
		<c:forEach var="NoticeVO" items="${requestScope.notice_list}" varStatus="status">
			<ul style="padding: 0; margin: 0 auto 3% auto; width: 90%;">
				<li style="list-style: none; width: 100%;">
					<button class="noticelist" onclick="noticeReply();" style="background-color: transparent; text-transform: none; border-width: 1px 0 1px; width: 100%; padding: 3% 0;">
						<span style="float: left; margin-left: 1%;">${NoticeVO.notice_title}</span><i class="fa-solid fa-chevron-down" style="float: right; margin-right: 1%;"></i>
					</button>
					<div id="replylist" style="background-color: #eee; width: 100%; padding: 3% 0; display: none;">
						<span style="margin-left: 1%;">${NoticeVO.notice_content}</span>
					</div>
				</li>
			</ul>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.notice_list}">
		<ul style="padding: 0; margin: 0 auto 3% auto; width: 90%;">
			<li style="list-style: none; width: 100%;">
				<button style="background-color: transparent; text-transform: none; border-width: 1px 0 1px; width: 100%; padding: 3% 0;">
					<span style="float: left;">공지사항이 없습니다.</span>
				</button>
			</li>
		</ul>
	</c:if>
	
	<div style="text-align: center; margin: 0 auto; width: 90%; padding: 2%;">
	    <!-- 1:1 문의 버튼 -->
	    <button class="inquire-add-btn" type="button" style="padding: 8px 0; width: 43%; background-color: #fff; border-width: 0.5px; border-radius: 5px; margin: 0 5px;">1:1 문의</button>
	    
	    <!-- 문의 내역 버튼 -->
	    <button class="inquire-list-btn" type="button" style="padding: 8px 0; width: 43%; background-color: #fff; border-width: 0.5px; border-radius: 5px; margin: 0 5px;">문의내역</button>
	</div>

</div>

<jsp:include page=".././footer/footer.jsp" />

<jsp:include page="../tab/tab.jsp"></jsp:include>

<script>
    function noticeReply() {
        var replySection = document.getElementById("replylist");
        // 답장이 보이면 숨기고, 숨겨져 있으면 보이게 설정
        if (replySection.style.display === "none" || replySection.style.display === "") {
            replySection.style.display = "block";
        } 
        else {
            replySection.style.display = "none";
        }
    }
    
 	// 버튼 클릭 시 각각 호출하도록 하기
    $(document).ready(function() {
        // 1:1 문의 버튼 클릭
        $(".inquire-add-btn").on("click", function() {
            showinquireaddTab();
        });

        // 문의내역 버튼 클릭
        $(".inquire-list-btn").on("click", function() {
            showinquirelistTab();
        });
    });

	// 문의내역 확인 함수
	function showinquirelistTab() {
		var tabTitle = "문의내역";
		
		$.ajax({
			url : "<%=ctxPath%>/inquire/inquire_list",
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
	
	// 1:1문의 작성하는 함수
	function showinquireaddTab() {
		var tabTitle = "1:1 문의";
		
		$.ajax({
			url : "<%=ctxPath%>/inquire/inquire_add",
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