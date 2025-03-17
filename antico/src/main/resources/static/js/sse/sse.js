// Stomp 프로토콜 웹소켓 모듈
window.SSEManager = (() => {
    let eventSource = null;

    return {
        // SSE 연결 함수 (사용자 일련번호)
        connect: function (url) {
            // 생성된 SSE가 존재하는지 확인
            if (this.isConnected()) {
                console.log("SSE already connected");
                return;
            }

            // SSE 객체 생성
            eventSource = new EventSource(url);

            console.log("SSE connected");

            // SSE 연결 오류 시 자동 재연결
            eventSource.onerror = () => {
                console.log("SSE connect error, reconnect after 5 seconds...");
                eventSource.close();
                setTimeout(() => {
                    eventSource = new EventSource(url);
                }, 5000);
            };
        },

        // 기능별 알림 이벤트 추가
        addEvent : function (eventName, alertType) {
            eventSource.addEventListener(eventName, (event) => {
                showAlert(alertType, event.data);
            });
        },

        addModalEvent : function (eventName, alertType) {
            eventSource.addEventListener(eventName, (event) => {
                showAlertModal(alertType, event.data);
            });
        },

        // SSE 연결 해제 함수
        disconnect: function () {
            if (eventSource != null) {
                eventSource.close();
                eventSource = null;
            }
        },

        // 웹소켓으로 이미 연결되었는지 확인하는 함수
        isConnected: function () {
            // eventSource 가 존재하지 않는 경우 false 반환
            if(!eventSource) {
                return false;
            }

            const status = eventSource.readyState;

            switch (status) {
                case 0 : {
                    console.log("SSE connecting"); // SSE 연결 중
                    return false;
                }
                case 1 : {
                    console.log("SSE connected"); // SSE 연결됨
                    return true;
                }
                case 2 : {
                    console.log("SSE disconnected"); // SSE 연결 해제됨
                    return false;
                }
            }
        }
    };
// 정의 즉시 실행
})();