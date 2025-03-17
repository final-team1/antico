<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>

<%-- 상품 정보 --%>
<c:set var="product_map" value="${requestScope.product_map}"/>

<%-- 채팅방 정보 --%>
<c:set var="chat_room" value="${requestScope.chat_room}"/>

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="login_member_no" value="${requestScope.login_member_vo.pk_member_no}"/>

<%-- 현재 로그인 사용자명 --%>
<c:set var="login_member_name" value="${requestScope.login_member_vo.member_name}"/>

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
        margin-bottom: 10px;
        display: flex;
    }

    div#product_detail {
        margin-left: 10px;
        display: flex;
        flex-direction: column;
    }

    span#product_price {
        font-weight: bold;
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
        margin-right: auto;
    }

    div.chatting_own {
        margin-left: auto
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

    span.sender_name {
        font-size: 10pt;
        font-weight: bold;
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
        margin-left: 20px;
        width: 70px;
        padding: 15px;
        border: none;
        background-color: #0DCC5A;
        color: white;
        font-size: 9pt;
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

    div.product_sale_status_chat {
        width: 400px;
        /*height: 400px;*/
        padding-bottom: 5px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        text-align: center;
        background-color: white;
        border-radius: 15px;
        box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
    }

    h4.chat_h4 {
        color: #0DCC5A;
        margin: 20px 0 10px 0;
        text-align: center;
    }

    div.product_info {
        width: 95%;
        margin: 20px auto;
        display: flex;
    }

    img.chat_product_image {
        height: 100px;
    }

    button.order_complete_button,
    button.order_cancel_button,
    button.review_button {
        width: 95%;
        height: 50px;
        margin: 5px auto;
        border: solid 1px #0DCC5A;
        border-radius: 15px;
        background: transparent;
    }

    button.order_complete_button:hover,
    button.order_cancel_button:hover,
    button.review_button:hover {
        border: solid 2px #0DCC5A;
    }

    div#product_detail {
        text-align: start;
    }

    span#chat_product_title {
        display: inline-block;
    }

    p.status_chat_p {
        font-weight: bold;
        align-items: flex-start;
        text-align: start;
    }
</style>

<div id="chat_container">
    <div id="chat_header">
        <img src="${product_map.prod_img_name}" height=70/>
        <div id="product_detail">
			<span id="product_price"> 
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${product_map.product_price}"/>원
			</span>
            <span id="chat_product_title">
                ${product_map.product_title}
            </span>
        </div>
    </div>

    <div id="chatting"></div>

    <div class="input-container">
        <input type="text" id="message" placeholder="메시지를 입력하세요..."/>
        <button id="go">보내기</button>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
   // TODO 블랙리스트 막기


        // 엔터키 입력시 채팅 전송 처리
        $("input#message").keydown(function (e) {
            if (e.keyCode == 13) {
                if ($.trim($("#message").val()) !== "") {
                    sendMessage();
                }
            }
        });

        // 보내기 버튼 클릭시 채팅 전송 처리
        $("button#go").click(function () {
            if ($.trim($("#message").val()) !== "") {
                sendMessage();
            }
        });

        // 웹소켓 연결 모듈을 통하여 연결 및 구독
        WebSocketManager.connect("${ctx_path}/ws-stomp", function () {
            const roomId = "${chat_room.roomId}";

            if (roomId == "") {
                showAlert("error", "채팅방 입장을 실패하였습니다");
                closeSideTab();
                return;
            }

            // 이전 채팅 내역 불러오기
            $.ajax({
                url: "${ctx_path}/chat/load_chat_history/" + roomId,
                success: function (json) {
                    loadChat(json);
                },
                error: function (error) {
                    showAlert("error", "채팅방 입장을 실패하였습니다");
                    WebSocketManager.disconnect();
                    closeSideTab();
                }
            });

            // 채팅방에 구독 처리 후 메시지 수신 시 채팅 내역에 보여주기
            WebSocketManager.subscribeMessage("/room/" + roomId, function (message) {
                showChat(message);
            });

            // 채팅 읽음 카운트 구독 처리, 갱신된 읽음 개수 전파
            WebSocketManager.subscribeReadStatus("/room/" + roomId + "/read", function (chatList) {
                updateReadStatus(chatList);
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
        const loginMemberName = "${login_member_name}";

        // 채팅방 및 사용자 식별자가 존재하지 않을 경우
        if (roomId == "" || loginMemberNo == "") {
            showAlert("error", "채팅 전송을 실패했습니다.");
            return;
        }

        // 채팅 내용 유효성 검사 후 송신
        if ($("#message").val() != "") {
            WebSocketManager.send("/send/" + roomId,
                {
                    'senderId': loginMemberNo,
                    'senderName': loginMemberName,
                    'message': $("#message").val(),
                    'chatType': 0
                });
            $("#message").val('');
        }
    }

    // 채팅 읽음 상태 송신
    function sendReadStatus() {
        const roomId = "${chat_room.roomId}";
        const loginMemberNo = "${login_member_no}";
        const loginMemberName = "${login_member_name}";
        const chatId = $("div#chatting > div").last().data("chat_id");

        // 채팅방 및 사용자 식별자가 존재하지 않을 경우
        if (roomId == "" || loginMemberNo == "") {
            console.log("error", "읽음 상태 전송을 실패했습니다.");
            return;
        }

        if (chatId == undefined || chatId == null) {
            return;
        }

        WebSocketManager.sendReadStatus("/send/read/" + roomId,
            {
                'memberNo': loginMemberNo,
                'chatId': chatId
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

            // 판매 상태 서버 알림 메시지
            if (chat.chatType == "1") {
                handleProductNoticeForm(chat);
            } else {
                // 년/월/일 형태 문자열 추출
                const sendDate = chat.sendDate.substring(11, 16);

                const chatDiv = $(`<div data-chat_id = \${chat.id}>`)
                    // 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
                    .addClass(chat.senderId == loginMemberNo ? 'chatting_own' : 'chatting')
                    .append(chat.senderId == loginMemberNo ? null : $("<span class='sender_name'>").text(chat.senderName))
                    .append(
                        $("<div>").addClass("message-wrapper")
                            .append(chat.senderId == loginMemberNo ? $("<span class='read_status'>").text(chat.unReadCount == 0 ? "" : chat.unReadCount) : null)
                            .append(chat.senderId == loginMemberNo ? $("<span class='send_date'>").text(sendDate) : $("<p>").text(chat.message))
                            .append(chat.senderId == loginMemberNo ? $("<p>").text(chat.message) : $("<span class='send_date'>").text(sendDate))
                    );

                $("#chatting").append(chatDiv);
            }

            // 스크롤을 하단으로 내리기
            scrollToBottom();

            // 읽음 처리
            sendReadStatus();
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

            for (let chat of chatList) {
                if (chat && chat.message) {
                    // 송신날짜를 시/분으로 저장
                    const sendDate = chat.sendDate.substring(11, 16);

                    // 각 채팅을 표시하기 전에 날짜가 바뀌면 상단에 날짜를 표시
                    if (chat.sendDate.substring(0, 10) != current_date) {
                        const chatDate = chat.sendDate
                            .substring(0, 10)
                            .replace(/^(\d{4})-(\d{2})-(\d{2})$/, '$1년 $2월 $3일');

                        $("#chatting").append($("<span class='chat_date'>").text(chatDate));
                        current_date = chat.sendDate.substring(0, 10);
                    }

                    if (chat.chatType == "1") {
                        handleProductNoticeForm(chat);
                    } else {

                        const chatDiv = $(`<div data-chat_id = \${chat.id}>`)
                            // 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
                            .addClass(chat.senderId == loginMemberNo ? 'chatting_own' : 'chatting')
                            .append(chat.senderId == loginMemberNo ? null : $("<span class='sender_name'>").text(chat.senderName))
                            .append(
                                $("<div>").addClass("message-wrapper")
                                    .append(chat.senderId == loginMemberNo ? $("<span class='read_status'>").text(chat.unReadCount == 0 ? "" : chat.unReadCount) : null)
                                    .append(chat.senderId == loginMemberNo ? $("<span class='send_date'>").text(sendDate) : $("<p>").text(chat.message))
                                    .append(chat.senderId == loginMemberNo ? $("<p>").text(chat.message) : $("<span class='send_date'>").text(sendDate))
                            );

                        $("#chatting").append(chatDiv);
                    }

                    // 스크롤을 하단으로 내리기
                    scrollToBottom();
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
    function updateReadStatus(chatList) {
        const loginMemberNo = "${login_member_no}";

        chatList.forEach(function (item, index) {
            $chat_div = $("div.chatting_own[data-chat_id = '" + item.id + "']").find("span.read_status").text(item.unReadCount == 0 ? "" : item.unReadCount);
        });
    }

    // 판매상태변경 내역 폼 생성 함수
    function handleProductNoticeForm(chat) {
        const loginMemberNo = "${login_member_no}";
        const sendDate = chat.sendDate.substring(11, 16);

        const chatDiv = $(`<div data-chat_id = \${chat.id}>`)
            // 자신이 보낸 메시지인지 상대가 보낸 메시지인지 확인
            .addClass('chatting')
            .append($("<div>").addClass("message-wrapper")
                .append($("<div>").addClass("product_sale_status_chat")
                    .append($("<div>")
                        .append($("<h4>").addClass("chat_h4").text(chat.message))
                        .append($("<div>").addClass("product_info")
                            .append($("<img class='chat_product_image' src='${product_map.prod_img_name}'>"))
                            .append($("<div id='product_detail'>")
                                .append($("<span id='product_price'>").text(Number("${product_map.product_price}").toLocaleString("ko-KR") + "원"))
                                .append($("<span id='chat_product_title'>").text("${product_map.product_title}"))
                            )
                        )
                    )
                )
                .append($("<span class='send_date'>").text(sendDate))
            );

        // 판매 상태에 따른 버튼 추가
        const additionalButton = handleProductSaleStatusUpdateMessage(chat.message);
        console.log(additionalButton);

        chatDiv.find("div.product_sale_status_chat").append(additionalButton);

        $("#chatting").append(chatDiv);
    }

    // 판매상태변경 메시지
    function handleProductSaleStatusUpdateMessage(message) {
        // 구매자만 버튼이 보이게 처리
        if ("${product_map.fk_member_no}" !== "${login_member_no}") {
            let v_html = ``;
            switch (message) {
                case "결제완료" : {
                    v_html += `<div><p class="status_chat_p">결제가 완료되었습니다. <br> 상품 수령 시 구매 확정을 눌러주세요</p><button type="button" class="order_complete_button" onclick="completeOrder()">구매 확정하기</button>`;
                    if(${product_map.product_sale_type eq 0}){
                        v_html += `<button type="button" class="order_cancel_button" onclick="tradeCancel()">구매 취소하기</button></div>`;
                    }
                    v_html += `</div>`;
                    break;
                }
                case "구매확정" : {
                    v_html += `<button type="button" class="review_button" onclick="showReviewRegisterTab()">후기 작성하기</button>`;
                    break;
                }
                default: {
                    break;
                }
            }
            return v_html;
        }
    }

    // 구매 확정 요청
    function completeOrder() {
        $.ajax({
            url: "${ctx_path}/trade/order_completed",
            type: "post",
            data: {
                pk_product_no: "${product_map.pk_product_no}",
                fk_member_no: "${product_map.fk_member_no}",
                product_price: "${product_map.product_price}",
            },
            dataType: "json",
            success: function (n) {
                if (n == 1) {
                    showAlert('success', '구매가 확정되었습니다.');
                } else {
                    showAlert('error', '구매확정이 실패하였습니다.');
                }
            },
            error: function (request, status, error) {
                errorHandlerWithNoClose(request, status, error);
            }
        });
    }

    //후기 등록 함수
    function showReviewRegisterTab() {
        $.ajax({
            url: "${ctx_path}/review/register",
            data: {
                "pk_product_no": "${product_map.pk_product_no}"
            },
            success: function (html) {
                openSideTab(html);
            },
            error: function (request, status, error) {
                errorHandlerWithNoClose(request, status, error);
            }
        });
    }
    
    
    // 구매취소를 눌렀을 경우
    function tradeCancel() {
    	$.ajax({
    		url: "${ctx_path}/trade/Cancel",
    		type: "post",
    		data: {"product_price":"${product_map.product_price}",
    			   "pk_product_no": "${product_map.pk_product_no}"
    		},
    		 dataType: "json",
             success: function (n) {
                 if (n == 1) {
                     showAlert('success', '구매취소가 완료되었습니다.');
                 } else {
                     showAlert('error', '구매취소가 실패되었습니다.');
                 }
             },
             error: function (request, status, error) {
                 errorHandler(request, status, error);
             }
    	});
    }
</script>
