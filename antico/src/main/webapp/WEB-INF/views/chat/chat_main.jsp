<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- context path --%>
<c:set var="ctx_path" value="${pageContext.request.contextPath}"/>

<%-- 현재 로그인 사용자 일련번호 --%>
<c:set var="login_member_no" value="${requestScope.login_member_vo.pk_member_no}"/>

<%-- 현재 로그인 사용자명 --%>
<c:set var="login_member_name" value="${requestScope.login_member_vo.member_name}"/>

<%-- 채팅방 정보 목록 --%>
<c:set var="chatRoomRespDTOList" value="${requestScope.chatRoomRespDTOList}"/>

<style>
    div.chatroom_item, div.auction_chatroom_item {
        margin: 20px 0;
        padding: 15px;
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: solid 1px #eee;
        border-left: 5px solid #0DCC5A;
        border-radius: 10px;
        box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.08);
        transition: box-shadow 0.3s ease;
        cursor: pointer;
    }

    div.chatroom_item:hover, div.auction_chatroom_item:hover {
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.12);
    }

    div.chatroom_detail {
        margin-left: 20px;
        margin-right: auto;
    }

    div.sender_detail {
        font-size: 10pt;
        margin-bottom: 10px;
        font-weight: bold;
    }

    div.product_image {
        padding-right: 10px;
        width: 100px;
        height: 100%;
        text-align: right;
    }

    div.product_image img {
        object-fit: contain;
    }

    div#chat_main_header {
        width: 100%;
    }

    .toggle-container {
        display: flex;
        border-radius: 8px;
        padding: 5px;
        width: 250px;
        margin: 0 auto 0 0;
    }

    .toggle_button {
        flex: 1;
        border: none;
        padding: 10px;
        font-size: 14px;
        cursor: pointer;
        border-radius: 5px;
        background: transparent;
        transition: background 0.3s ease-in-out;
    }

    .toggle_button.active {
        background: #0dcc5a;
        color: white;
        font-weight: bold;
    }


</style>

<div id="chat_main_container">
    <div id="chat_main_header">
        <div class="toggle-container">
            <button class="toggle_button active" id="general_chat_button" onclick="toggleChat('general')">일반 채팅</button>
            <button class="toggle_button" id="auction_chat_button" onclick="toggleChat('auction')">경매 채팅</button>
        </div>
    </div>
    <div id="chatroom_container"></div>
</div>

<script type="text/javascript">

    $(document).ready(function () {
        loadChatRoom();
        // 채팅 입장 이벤트 전체 해제 후 등록
        $("div#sidetab_content")
            .off("click", "div.chatroom_item")
            .on("click", "div.chatroom_item", function (e) {
                const roomid = $(this).data("room-id");
                goChatRoom(roomid, "채팅");
            })
            .off("click", "div.auction_chatroom_item")
            .on("click", "div.auction_chatroom_item", function (e) {
                const roomid = $(this).data("room-id");
                goAuctionChatRoom(roomid, "경매");
            });

    });

    // 기존에 참여하던 채팅방 입장
    function goChatRoom(room_id, sender_name) {
        $.ajax({
            url: "${ctx_path}/chat/join",
            type: "post",
            data: {
                "room_id": room_id
            },
            success: function (html) {
                openSideTab(html, sender_name);
            },
            error: function (xhr, status, error) {
                errorHandler(xhr, status, error);
            }
        });
    }
    // 기존에 참여하던 채팅방 입장
    function goAuctionChatRoom(room_id, sender_name) {
        $.ajax({
            url: "${ctx_path}/auction/join",
            type: "post",
            data: {
                "room_id": room_id
            },
            success: function (html) {
                openSideTab(html, sender_name);
            },
            error: function (xhr, status, error) {
                errorHandler(xhr, status, error);
            }
        });
    }


    // 일반/경매 채팅 토글 함수
    function toggleChat(type) {
        $("button.toggle_button").removeClass("active");

        if (type === "general") {
            $("button#general_chat_button").addClass("active");
            loadChatRoom();
        } else {
            $("button#auction_chat_button").addClass("active");
            loadAuctionChatRoom();
        }
    }

    function loadChatRoom() {
        $.ajax({
            url: "${ctx_path}/chat/loadChatRoom",
            type: "post",
            success: function (list) {
                let html = '';
                $.each(list, function (index, item) {

                    html += `
					<div class="chatroom_item" data-room-id="\${item.chatRoom.roomId}">
						<img src="${ctx_path}/images/icon/user_circle.svg" width="50" />

						<div class="chatroom_detail">
							<%-- 현재 로그인 사용자가 채팅 참여자중 누구인지 판별 --%>
							<div class="sender_detail">`;

                    <%-- 채팅방에 아무도 매시지를 보내지 않은 경우 로그인 사용자 이름 표시 --%>
                    if (item.latestChat) {
                        html += item.latestChat.senderName;
                        html += item.latestChat.sendDate.substring(0, 10);
                    } else {
                        html += "${login_member_name}";
                        html += `${item.chatRoom.regDate.substring(0, 10)}`;
                    }

                    html += `	</div>`;

                    const msg = sanitizeMessage(item.latestChat.message);

                    if (msg.length > 27) {
                        html += msg.substring(0, 27) + "...";
                    } else {
                        html += msg;
                    }

                    html += `	</div>

						<div class="product_image">
							<img src="\${item.productChatDTO.prod_img_name}" height=70 />
						</div>
					</div>
				`
                });
                $("div#chatroom_container").html(html);
            },
            error: function (xhr, status, error) {
                errorHandler(xhr, status, error);
            }
        });
    }

    function loadAuctionChatRoom(memberNo) {
        $.ajax({
            url: "${ctx_path}/auction/loadAuctionChatRoom",
            type: "post",
            success: function (list) {
                let html = '';
                $.each(list, function (index, item) {
                    html += `
					<div class="auction_chatroom_item" data-room-id="\${item.auctionChatRoom.roomId}">
						<img src="${ctx_path}/images/icon/user_circle.svg" width="50" />

						<div class="chatroom_detail">
							<%-- 현재 로그인 사용자가 채팅 참여자중 누구인지 판별 --%>
							<div class="sender_detail">`;

                    <%-- 채팅방에 아무도 매시지를 보내지 않은 경우 로그인 사용자 이름 표시 --%>
                    if (item.latestChat) {
                        const senderName = item.latestChat.senderName == null ? "" : item.latestChat.senderName;
                        html += item.latestChat.chatType === 1 ? "사용자 알림 " : senderName
                        html += item.latestChat.sendDate.substring(0, 10);
                    } else {
                        html += `${item.auctionChatRoom.regDate.substring(0, 10)}`;
                    }

                    html += `	</div>`;

                    const msg = sanitizeMessage(item.latestChat.message);

                    if (msg.length > 27) {
                        html += msg.substring(0, 27) + "...";
                    } else {
                        html += msg;
                    }

                    html += `</div>

						<div class="product_image">
							<img src="\${item.productChatDTO.prod_img_name}" height=70 />
						</div>
					</div>
				`
                });
                $("div#chatroom_container").html(html);
            },
            error: function (xhr, status, error) {
                errorHandler(xhr, status, error);
            }
        });
    }

    function sanitizeMessage(message) {
        return message.replace(/<\/?[^>]+(>|$)/g, ""); // HTML 태그 제거
    }

</script>