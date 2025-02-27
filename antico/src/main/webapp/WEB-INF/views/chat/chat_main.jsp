<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>
<%-- 로그인 사용자 정보 --%>
<c:set var="login_member_no" value="${requestScope.login_member_no}"/>
<%-- 채팅방 정보 목록 --%>
<c:set var="chatroom_map_list" value="${requestScope.chatroom_map_list}"/>

<style>
	div.chatroom_item {
		margin : 20px 0;
		padding : 15px;
		width : 100%;
		display : flex;
		justify-content : space-between;
		align-items : center;
		border : solid 1px #eee;
		border-left: 5px solid #0DCC5A;
		border-radius : 10px;
		box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.08);
		transition: box-shadow 0.3s ease;
		cursor : pointer;
	}
	
	div.chatroom_item:hover {
    	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.12);
	}
	
	div.chatroom_detail {
		margin-left : 20px;
		margin-right : auto;
	}
	
	div.sender_detail {
		font-size : 10pt;
		margin-bottom : 10px;
		font-weight : bold;
	}
	
	div.product_image {
		width : 100px;
		height : 100%;
		text-align : right;
	}
	
	div.product_image img {
		object-fit : cover;
	}
	
</style>

<div>
	<c:forEach items="${chatroom_map_list}" var="chatroom_map">
		<div class="chatroom_item" data-room_id="${chatroom_map.room_id}">
			<img src="${ctx_path}/images/icon/user_circle.svg" width="50" />
		
			<div class="chatroom_detail">
				<%-- 현재 로그인 사용자가 채팅 참여자중 누구인지 판별 --%>
				<div class="sender_detail">
					<c:if test="${chatroom_map.participant1_no ne login_member_no}">
						<span>${chatroom_map.participant1_name}</span>
					</c:if>
					<c:if test="${chatroom_map.participant2_no ne login_member_no}">
						<span>${chatroom_map.participant2_name}</span>
					</c:if>
					
					<c:if test="${empty chatroom_map.latest_chat_send_date}">
						${chatroom_map.regdate}
					</c:if>
					<c:if test="${not empty chatroom_map.latest_chat_send_date}">
						${chatroom_map.latest_chat_send_date}
					</c:if>
				</div>
				
				<%-- 최근 채팅 메시지가 길면 줄임말 처리 --%>
				<c:if test="${fn:length(chatroom_map.latest_chat_message) > 27}">
					${fn:substring(chatroom_map.latest_chat_message, 0, 27)}...
				</c:if>
				<c:if test="${fn:length(chatroom_map.latest_chat_message) <= 27}">
					${chatroom_map.latest_chat_message}
				</c:if>
			</div>
		
			<div class="product_image">
				<img src="${chatroom_map.prod_img_name}" height=70 />
			</div>
		</div>
	</c:forEach>
</div>

<script type="text/javascript">

$(document).ready(function(){
	// 채팅 입장 이벤트 전체 해제 후 등록
	$("div#sidetab_content")
    .off("click", "div.chatroom_item")
	.on("click", "div.chatroom_item", function(e){	
		const sender_name = $(this).find("div.sender_detail span").text();		
		const roomid = $(this).data("room_id");
		
		goChatRoom(roomid, sender_name);
		
	});
});

// 기존에 참여하던 채팅방 입장
function goChatRoom(room_id, sender_name) {
	$.ajax({
		url : "${ctx_path}/chat/join",
		type : "post",
		data : {
			"room_id" : room_id
		},
		success : function(html) {
			// 서버로부터 받은 html 파일을 tab.jsp에 넣고 tab 열기	
			openSideTab(html, sender_name);
		},
		error: function(request, status, error){
			errorHandler(request, status, error);
		}
	});
}
	
</script>

</html>