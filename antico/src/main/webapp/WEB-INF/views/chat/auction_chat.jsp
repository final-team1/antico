<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>

<%-- 상품 정보 --%>
<c:set var="product_map" value="${requestScope.product_map}"/>

<%-- 채팅방 정보 --%>
<c:set var="chat_room" value="${requestScope.chat_room}"/>

<%-- 경매 최고 입찰가 --%>
<c:set var="highestBid" value="${requestScope.highestBid}"/>

<%-- 참여자 정보 --%>
<c:set var="participants" value="${chat_room.participants}"/>

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="login_member_no" value="${requestScope.login_member_vo.pk_member_no}"/>

<%-- 현재 로그인 사용자명 --%>
<c:set var="login_member_name" value="${requestScope.login_member_vo.member_name}"/>

<%-- 현재 로그인 사용자 포인트 --%>
<c:set var="login_member_point" value="${requestScope.login_member_vo.member_point}"/>

<%-- 경매 내역 --%>
<c:set var="auctionVO" value="${requestScope.auctionVO}"/>


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
        position: relative;
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

    button#participants_button {
        margin: auto 0 auto auto;
        background-color: transparent;
        border: none;
    }

    div#participants {
        display: none;
        position: absolute;
        right: -100px;
        transform: translateX(-50%);
        top: 90%;
        width: 200px;
        background: white;
        border: 1px solid #ddd;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        padding: 10px;
        z-index: 1000;
    }


    div#participants ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    button#close_auction_button{
        margin : auto;
        background: transparent;
    }
</style>

<div id="chat_container">
    <div id="chat_header">
        <img src="${product_map.prod_img_name}" height=70/>
        <div id="product_detail">
            <span id="chat_product_title">
                ${product_map.product_title}
            </span>
            <span id="initial_price">
				초기 입찰가 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${product_map.product_price}"/>원
			</span>
            <span id="product_price">
                최고 입찰가 : <span id="bid_price" data-price="${highestBid.bid}">0</span>원
            </span>
            <span id="highest_bidder_name">
                ${highestBid.bidderName}
            </span>
            <div id="auction_timer_${chat_room.roomId}"></div>
        </div>

        <span>내 포인트 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${login_member_point}"/></span>

        <c:if test="${login_member_no eq product_map.fk_member_no}">
            <button id="close_auction_button" onclick="closeAuctionBySeller()">경매 종료하기</button>
        </c:if>

        <button id="participants_button">참여자</button>
        <div id="participants">
            <ul>
                <c:forEach items="${chat_room.participants}" var="participant">
                    <li data-member-no=${participant.memberNo}>${participant.memberName}</li>
                </c:forEach>
            </ul>
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

        // 참여자 확인 토글
        $("button#participants_button").click(function () {
            $("div#participants").slideToggle(300);
        });
        if ("${product_map.product_sale_status}" == 4) {

            // 엔터키 입력시 채팅 전송 처리
            $("input#message")
                .on("keydown", function (e) {
                    if (e.keyCode == 13) {
                        if ($.trim($("#message").val()) !== "") {
                            sendMessage();
                        }
                    }
                })// 입찰가 작성 시 input 색상 변경
                .on("input", function (e) {
                    const priceRegExp = /^@\d+$/; // @로 시작하는 값은 입찰가 제시

                    if (priceRegExp.test($(this).val())) {
                        $(this).css("color", "#0DCC5A");
                    } else {
                        $(this).css("color", "black");
                    }
                });

            // 보내기 버튼 클릭시 채팅 전송 처리
            $("button#go").click(function () {
                if ($.trim($("#message").val()) !== "") {
                    sendMessage();
                }
            });

            // 실시간 최고 입찰가 변동 애니메이션
            let currentBid = parseInt($("#bid_price").data("price"));

            $("#bid_price").text(currentBid.toLocaleString("ko-KR"));

            // 경매 남은 시간 타이머
            $.ajax({
                url: "${ctx_path}/auction/timer",
                dataType: "json",
                success: function (data) {
                   startTimer("${chat_room.roomId}","${auctionVO.auction_enddate}", data)
                },
                error: function () {
                    showAlert("error", "다시 경매방을 들어와주세요");
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
                    url: "${ctx_path}/auction/load_chat_history/" + roomId,
                    success: function (json) {
                        console.log(json);
                        loadChat(json);
                    },
                    error: function (error) {
                        showAlert("error", "채팅방 입장을 실패하였습니다");
                        WebSocketManager.disconnect();
                        closeSideTab();
                    }
                });

                // 채팅방에 구독 처리 후 메시지 수신 시 채팅 내역에 보여주기
                WebSocketManager.subscribeMessage("/room/" + roomId + "/auction", function (message) {
                    showChat(message);
                });

                // 채팅 읽음 카운트 구독 처리, 갱신된 읽음 개수 전파
                WebSocketManager.subscribeReadStatus("/room/" + roomId + "/auction/read", function (chatList) {
                    updateReadStatus(chatList);
                });

                // 채팅방 변경내역 구독
                WebSocketManager.subscribeReadStatus("/room/" + roomId + "/auction/participant", function (participants) {
                    updateParticipant(participants);
                });

                // 채팅방 변경내역 구독
                WebSocketManager.subscribeReadStatus("/room/" + roomId + "/auction/bid", function (bid) {
                    updateBidPrice(bid);
                });
            });

        }
        else {
            let currentBid = parseInt($("#bid_price").data("price"));
            $("#bid_price").text(currentBid.toLocaleString("ko-KR"));
            $("span#initial_price").empty();
            $("button#close_auction_button").hide();

            // 경매 남은 시간 타이머
            $("div.input-container").hide();
            $("#auction_timer_${chat_room.roomId}").text("경매 종료");

            // 이전 채팅 내역 불러오기
            $.ajax({
                url: "${ctx_path}/auction/load_chat_history/" + "${chat_room.roomId}",
                success: function (json) {
                    loadChat(json);
                },
                error: function (xhr, status, error) {
                    errorHandler(xhr, status, error);
                }
            });
        }
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
        const priceRegExp = /^@\d+$/; // @로 시작하는 값은 입찰가 제시
        const message = $("#message").val();

        // 채팅방 및 사용자 식별자가 존재하지 않을 경우
        if (roomId == "" || loginMemberNo == "") {
            showAlert("error", "채팅 전송을 실패했습니다.");
            return;
        }

        // 입찰가 유효성 검사
        if (priceRegExp.test(message)) {
            if ("${login_member_no}" == "${product_map.fk_member_no}") {
                showAlert("warning", "판매자는 입찰을 할 수 없습니다.");
                return;
            }

            if (Number("${login_member_point}") < Number(message.substring(1))) {
                showAlert("warning", "보유하고 있는 포인트보다 많은 입찰가입니다");
                return;
            }

            let currentBid = parseInt($("#bid_price").text().replace(/,/g, "")) || 0;

            if (Number(message.substring(1)) < currentBid) {
                showAlert("warning", "입찰가가 최고 입찰가보다 적습니다");
                return;
            }
        }

        // 채팅 내용 유효성 검사 후 송신
        if (message != "") {
            WebSocketManager.send("/send/auction/" + roomId,
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

        if (chatId === undefined || chatId == null) {
            return;
        }

        WebSocketManager.sendReadStatus("/send/auction/read/" + roomId,
            {
                'memberNo': loginMemberNo,
                'chatId': chatId
            });

    }

    // 경매 참여자 변경내역
    function updateParticipant(participant) {
        let html = ``;
        $.each(participant, function (index, item) {
            html += `<li data-member-no=\${item.memberNo}>\${item.memberName}</li>`;
        });

        $("div#participants ul").html(html);
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
                handleNotificationMessage(chat.message);
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
                        handleNotificationMessage(chat.message);
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
        chatList.forEach(function (item, index) {
            $chat_div = $("div.chatting_own[data-chat_id = '" + item.id + "']").find("span.read_status").text(item.unReadCount == 0 ? "" : item.unReadCount);
        });
    }

    // 판매상태변경 메시지
    function handleNotificationMessage(message) {
        if(message == "경매가 종료되었습니다.") {
            closeAuction("{chat_room.roomId}");
        }
        $("#chatting").append($("<span class='chat_date'>").text(message));
    }

    function updateBidPrice(newBid) {
        let currentBid = parseInt($("#bid_price").text().replace(/,/g, "")) || 0;

        gsap.fromTo("#bid_price", {innerHTML: currentBid}, {
            duration: 1,  // 애니메이션 지속 시간 (초)
            innerHTML: newBid.bid,
            snap: {innerHTML: 1},
            onUpdate: function () {
                $("#bid_price").text(Math.floor(this.targets()[0].innerHTML).toLocaleString("ko-KR"));
            }
        });

        $("span#highest_bidder_name").text(newBid.bidderName);
    }


    if (!window.auctionTimers) {
        window.auctionTimers = {};
    }


    function startTimer(roomId, auctionEndTime, serverTime) {
        const endTime = new Date(auctionEndTime);
        let now = new Date(serverTime);

        // 기존 타이머가 있으면 삭제
        clearExistingTimer(roomId);

        function updateCountTimer() {
            now = new Date(now.getTime() + 1000);

            const remainingTime = Math.max(0, Math.floor((endTime - now) / 1000)); // 남은 초 계산
            const hours = Math.floor(remainingTime / 3600);
            const minutes = Math.floor((remainingTime % 3600) / 60);
            const seconds = remainingTime % 60;

            $(`#auction_timer_${chat_room.roomId}`).text(`\${hours}시 \${minutes}분 \${seconds}초 남음`);

            if (remainingTime <= 0) {
                closeAuction(roomId);
            }
        }

        updateCountTimer();

        // 새로운 타이머 실행 후 객체에 저장
        window.auctionTimers[roomId] = setInterval(updateCountTimer, 1000);
    }

    function clearExistingTimer(roomId) {
        if (window.auctionTimers[roomId]) {
            clearInterval(window.auctionTimers[roomId]);
            delete window.auctionTimers[roomId];
        }
    }

    // 모든 타이머 제거 (뒤로 가기, 페이지 나갈 때 호출)
    function clearAllTimers() {
        Object.keys(window.auctionTimers).forEach((roomId) => {
            clearExistingTimer(roomId);
        });
    }

    // 브라우저를 닫거나 페이지를 떠나기 전 소켓 연결 해제 및 모든 타이머 제거
    window.onbeforeunload = function () {
        clearAllTimers();
        if (WebSocketManager.isConnected()) {
            WebSocketManager.disconnect();
        }
    };

    // 경매 종료 시 타이머 삭제
    function closeAuction(roomId) {
        $(`#auction_timer_${chat_room.roomId}`).text("경매 종료");
        $(`div.input-container`).hide();
        $("span#initial_price").empty();
        $("button#close_auction_button").hide();
        clearExistingTimer(roomId);
        WebSocketManager.disconnect();
        showAlert("info", "경매가 종료되었습니다.");
    }

    function closeAuctionBySeller() {
        $.ajax({
            url : "${ctx_path}/auction/close",
            data : {
                "pk_product_no" : "${product_map.pk_product_no}"
            },
            success : function (json) {
                closeAuction("${chat_room.roomId}");
            },
            error : function (xhr, status, error) {
                errorHandlerWithNoClose(xhr, status, error);
            }
        });
    }

</script>
