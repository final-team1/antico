<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- context path --%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />

<%-- 상품 정보 --%>
<c:set var="product_map" value="${requestScope.product_map}" />

<%-- 채팅방 정보 --%>
<c:set var="chat_room" value="${requestScope.chat_room}" />

<%-- 참여자 정보 --%>
<c:set var="participants" value="${chat_room.participants}" />

<%-- 현재 로그인 사용자 --%>
<c:set var="login_member_no" value="${requestScope.login_member_no}" />

<%-- 상대방 채팅 참여자 --%>
<c:if test="${login_member_no ne participants[0].memberNo}">
	<c:set var="other_participant" value="${participants[0]}" />
</c:if>

<c:if test="${login_member_no ne participants[1].memberNo}">
	<c:set var="other_participant" value="${participants[1]}" />
</c:if>

<style>
div#chat_container {
	width: 100%;
	height: 100%;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	overflow: hidden;
}

div.message-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    width: 100%;
}

div#chat_header {
	margin-bottom : 10px;
	display: flex;
}

div#product_detail {
	margin-left: 10px;
	display: flex;
	flex-direction: column;
}

span#product_price {
	font-weight : bold;
}

div#chatting {
	flex: 1;
	padding: 20px;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	background-color: #E9EDEF;
}

span.chat_date {
	text-align: center;
}

div.chatting, .chatting_own {
	margin-bottom: 15px;
	display: flex;
	flex-direction: column;
}

div.chatting p, div.chatting_own p {
	padding: 12px;
	border-radius: 15px;
	max-width: calc(100% - 50px); 
	word-wrap: break-word;
	font-size: 14px;
	line-height: 1.5;
    width: auto;               
    max-width: 85%;
    margin: 0;    
}

div.chatting {
	margin-right : auto;
}

div.chatting_own {
	margin-left : auto
}

div.chatting p {
	background-color: #ffffff;
	color: black;
}

div.chatting_own p {
	background-color: #363c45;
	color: white;
}

div.chatting_own span.send_date, div.chatting span.send_date {
    font-size: 7pt;
    margin: 0 10px;
    white-space: nowrap;
}

span.read_status {
	font-size: 7pt;
}

#message {
	width: calc(100% - 80px);
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	outline: none;
	font-size: 14px;
}

#go {
	margin-left : 20px;
	width: 70px;
	padding: 15px;
	border: none;
	background-color:#0DCC5A;
	color: white;
	font-size : 9pt;
	font-weight: bold;
	border-radius: 5px;
	cursor: pointer;
}

#go:hover {
	background-color: #45a049;
}

div.input-container {
	display: flex;
	padding: 10px;
	border-top: 1px solid #ddd;
}
</style>

<div id="chat_container">
	<div id="chat_header">
		<img src="${product_map.prod_img_name}" height=70 />
		<div id="product_detail">
			<span id="product_price"> 
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${product_map.product_price}"/>원
			</span> 
			<span id="product_title"> 
				${product_map.product_title} 
			</span>
		</div>
	</div>
	
	<div id="chatting"></div>
	
	<div class="input-container">
		<input type="text" id="message" placeholder="메시지를 입력하세요..." />
		<button id="go">보내기</button>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		// 엔터키 입력시 채팅 전송 처리
		$("input#message").keydown(function(e) {
			if (e.keyCode == 13){
				if ($.trim($("#message").val()) !== "") {
				    sendMessage();
				}
			}
		});
		
		// 보내기 버튼 클릭시 채팅 전송 처리
		$("button#go").click(function() {
			if ($.trim($("#message").val()) !== "") {
			    sendMessage();
			}
		});
		
		// 웹소켓 연결 모듈을 통하여 연결 및 구독 
		WebSocketManager.connect("${ctxPath}/ws-stomp", function() {
			console.log("websocket connected");
			
			const roomId = "${chat_room.roomId}";
			
			if(roomId == "") {
				showAlert("error", "채팅방 입장을 실패하였습니다 다시 시도해주세요");
				closeSideTab();
				return;
			}
			
			// 이전 채팅 내역 불러오기
			$.ajax({
	        	url: "${ctxPath}/chat/load_chat_history/" + roomId,
	        	success: function(json) {
	        		loadChat(json);
	        	},
	        	error: function(error) {
	        		showAlert("error", "채팅방 입장을 실패하였습니다 다시 시도해주세요");
	        		WebSocketManager.disconnect();
	        		closeSideTab();
	        	}
		    });
			
			// 채팅방에 구독 처리 후 메시지 수신 시 채팅 내역에 보여주기
			WebSocketManager.subscribeMessage("/room/" + roomId, function(message) {
				showChat(message);
			});
			
			WebSocketManager.subscribeReadStatus("/room/" + roomId + "/read/", function(participants) {
				updateReadStatus(participants);
			});
		});
	});
	
	// 브라우저를 닫거나 페이지를 떠나기 전 소켓 연결 해제 처리
	window.onbeforeunload = function (e) {
	    if (WebSocketManager.isConnected()) {
	        WebSocketManager.disconnect();
	    }
	};
	
	// 채팅 송신
	function sendMessage() {
	    const roomId = "${chat_room.roomId}";
	    const loginMemberNo = "${login_member_no}";

	    // 채팅방 및 사용자 식별자가 존재하지 않을 경우
	    if (roomId == "" || loginMemberNo == "") {
	    	showAlert("error", "채팅 전송을 실패했습니다.");
	        return;
	    }

	    // 채팅 내용 유효성 검사 후 송신
	    if ($("#message").val() != "") {
	    	WebSocketManager.send("/send/" + roomId,
	            {
	                'message': $("#message").val(),
	                'senderId': loginMemberNo
	            });
	        $("#message").val('');
	    }
	}
	
	// 채팅 송신
	function sendReadStatus() {
	    const roomId = "${chat_room.roomId}";
	    const loginMemberNo = "${login_member_no}";
	   
	    // 채팅방 및 사용자 식별자가 존재하지 않을 경우
	    if (roomId == "" || loginMemberNo == "") {
	    	console.log("error", "읽음 상태 전송을 실패했습니다.");
	        return;
	    }

    	WebSocketManager.sendReadStatus("/send/read/" + roomId,
            {
                'lastReadChatId': $("div#chatting > div").last().data("chat_id"),
                'memberNo' : loginMemberNo
            });
	       
	}
	
	// 채팅 내역 보여주기
	function showChat(chat) {
	    if (chat && chat.message) {
	    	const loginMemberNo = "${login_member_no}";
		    
	        if (loginMemberNo == "") {
	        	showAlert("error", "채팅 내역을 불러오는데 실패했습니다.");
		        return;
		    }
	   
	        // 년/월/일 형태 문자열 추출
        	const sendDate = chat.sendDate.substring(11, 16);
        	
        	const chatDiv = $(`<div data-chat_id = \${chat.id}>`)

        	// 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
            .addClass(chat.senderId == loginMemberNo ? 'chatting_own' : 'chatting')
            .append(
                $("<div>").addClass("message-wrapper")
                .append(chat.senderId == loginMemberNo ? $("<span class='send_date'>").text(sendDate) : $("<p>").text(chat.message))
                .append(chat.senderId == loginMemberNo ? $("<p>").text(chat.message) : $("<span class='send_date'>").text(sendDate))
            );
        	
        	$("#chatting").append(chatDiv);
        	
        	// 스크롤을 하단으로 내리기
        	scrollToBottom();

            sendReadStatus();

	    } else {
	    	showAlert("error", "채팅 내역을 불러오는데 실패했습니다.");
	    }
	}

	// 전체 채팅 내역 불러오기
	function loadChat(chatList) {
	    const loginMemberNo = "${login_member_no}";
	    
	    if (loginMemberNo == "") {
	    	showAlert("error", "채팅 내역을 불러오는데 실패했습니다.");
	        return;
	    }

	    if (chatList != null) {
	    	
	    	// 각 채팅의 송신날짜 년/월/일을 채팅 상단에 띄우기 위한 임시 저장값
	    	let current_date = "";
			const lastReadChatId = "${other_participant.lastReadChatId}";
	    	
	        for (let chat of chatList) {
	            if (chat && chat.message) {
	        		
	            	// 송신날짜를 시/분으로 저장 
	            	const sendDate = chat.sendDate.substring(11, 16);
	            	
	            	// 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시 
	            	if(chat.sendDate.substring(0, 10) != current_date) {
	            		const chatDate = chat.sendDate
	            	    .substring(0, 10)
	            	    .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');
	            		
	            		$("#chatting").append($("<span class='chat_date'>").text(chatDate));
	            		current_date = chat.sendDate.substring(0, 10);
	            	}
	            	
	            	const chatDiv = $(`<div data-chat_id = \${chat.id}>`)
	            		// 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
		                .addClass(chat.senderId == loginMemberNo ? 'chatting_own' : 'chatting')
		                .append(
		                    $("<div>").addClass("message-wrapper")
		                    .append((lastReadChatId != "" && chat.senderId == loginMemberNo && lastReadChatId >= chat.id) ? $("<span class='read_status'>").text("읽음") : null)
		                    .append(chat.senderId == loginMemberNo ? $("<span class='send_date'>").text(sendDate) : $("<p>").text(chat.message))
		                    .append(chat.senderId == loginMemberNo ? $("<p>").text(chat.message) : $("<span class='send_date'>").text(sendDate))
	                	);	            
	            	
	            	$("#chatting").append(chatDiv);
	            	
	            	// 스크롤을 하단으로 내리기
	            	scrollToBottom();
	            } else {
	            	showAlert("error", "채팅 내역을 불러오는데 실패했습니다.");
	            }
	        }
	        
	        sendReadStatus();
	    }
	}
	
	// 채팅 내역 갱신 시 스크를을 하단으로 내려 포커싱을 하기 위한 함수
	function scrollToBottom() {
	    const chatContainer = $("div#chatting");
	    chatContainer.scrollTop(chatContainer.prop("scrollHeight"));
	}
	
	// 사용자 읽음 상태수정
	function updateReadStatus(participants) {
		
		const loginMemberNo = "${login_member_no}";
		if(participants.memberNo != loginMemberNo) {
	 		$("div.chatting_own").each(function(index, item){
	 			
				// 최근 읽은 채팅 메시지 식별자 포함 이전 식별자를 가진 메시지에는 읽음 상태 추가
				if($(item).data("chat_id") <= participants.lastReadChatId) {	
					
					// 이미 읽음 처리가 안된 요소라면
					if(!$(item).find("span").hasClass("read_status")) {
						$(item).find("div.message-wrapper").prepend($("<span class='read_status'>").text("읽음"));
					}
				}
	 			
			});
		}
	}

</script>

</html>
