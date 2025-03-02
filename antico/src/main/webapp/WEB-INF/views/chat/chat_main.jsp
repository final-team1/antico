<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="login_member_no" value="${requestScope.login_member_vo.pk_member_no}" />

<%-- 현재 로그인 사용자명 --%>
<c:set var="login_member_name" value="${requestScope.login_member_vo.member_name}" />

<%-- 채팅방 정보 목록 --%>
<c:set var="chatRoomRespDTOList" value="${requestScope.chatRoomRespDTOList}"/>

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
	<c:forEach items="${chatRoomRespDTOList}" var="chatRoomRespDTO">
		<div class="chatroom_item" data-room-id="${chatRoomRespDTO.chatRoom.roomId}">
			<img src="${ctx_path}/images/icon/user_circle.svg" width="50" />
		
			<div class="chatroom_detail">
				<%-- 현재 로그인 사용자가 채팅 참여자중 누구인지 판별 --%>
				<div class="sender_detail">
					<%-- 채팅방에 아무도 매시지를 보내지 않은 경우 로그인 사용자 이름 표시 --%>
					<c:if test="${empty chatRoomRespDTO.latestChat}">
						${login_member_name}
						${fn:substring(chatRoomRespDTO.chatRoom.regdate, 0, 10)}
					</c:if>
					<c:if test="${not empty chatRoomRespDTO.latestChat}">
						${chatRoomRespDTO.latestChat.senderName}
						${fn:substring(chatRoomRespDTO.latestChat.sendDate, 0, 10)}
					</c:if>
					
				</div>
				
				<%-- 최근 채팅 메시지가 길면 줄임말 처리 --%>
				<c:if test="${fn:length(chatRoomRespDTO.latestChat.message) > 27}">
					${fn:substring(chatRoomRespDTO.latestChat.message, 0, 27)}...
				</c:if>
				<c:if test="${fn:length(chatRoomRespDTO.latestChat.message) <= 27}">
					${chatRoomRespDTO.latestChat.message}
				</c:if>
			</div>
		
			<div class="product_image">
				<img src="${chatRoomRespDTO.productChatDTO.prod_img_name}" height=70 />
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
		const roomid = $(this).data("room-id");
		
		goChatRoom(roomid, "채팅");
		
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
			openSideTab(html, sender_name);
		},
		error: function(xhr, status, error){
			errorHandler(xhr, status, error);
		}
	});
}
	
</script>

</html>