const Toast = Swal.mixin({
	  toast: true,
	  position: "top-start",
	  showConfirmButton: false,
	  color: "white",
	  background : "black",
	  timer: 3000,
	  timerProgressBar: true,
	  showCloseButton : true,
	  didOpen: (toast) => {
	    toast.onmouseenter = Swal.stopTimer;
	    toast.onmouseleave = Swal.resumeTimer;
	  },
	  customClass : {
		popup : 'custom-toast',
		timerProgressBar: 'custom-progress-bar',
	  }
});

// 토스트 알림 함수
// icon 종류 : success, error, warning, info, question
function showAlert(type, msg) {
	Toast.fire({
		icon: type,
		title: msg.trim() == "" ? "오류가 발생했습니다. 다시 시도하여 주십시오" : msg 
	});
}

function showAlertModal(type, msg) {
	if(msg.trim() == "") {
		return;
	}
	Swal.fire({
		text: msg,
		confirmButtonText: "확인",
		icon: type
	});
}

// 확인 모달
function showConfirmModal() {
	Swal.fire({
	  title: "후드티님이 차단됩니다.",
	  text: "채팅 불가, 사용자 차단, 단골/찜 해제, 알림 미수신",
	  confirmButtonText: "확인",
	  showDenyButton: true,
	  denyButtonText:"취소",
	  icon: "warning"
	});
}

// 후기 모달
function showReviewModal(json, icon_url) {
	const review = json.review_map; // 후기 상세 정보
	const survey_list = json.survey_list; // 후기 작성자가 선택한 설문 문항 정보 

	v_html = `
			<div class="review_detail_box">
				<img src="${icon_url}" width=100 height=100/>
				
				<span class="review_detail_title">
					${review.seller_name}님이 ${review.consumer_name}님과의 거래 후기
				</span>
				
				<div class="review_detail_product_title_box">
					<span>${review.product_title}</span>
				</div>`;
				
	if(review.review_img_file_name) {
		v_html += `<img src="${review.review_img_file_name}" width=300 />`;
	}		
				
	v_html += `	<div class="review_detail_cotent_box">
					${review.review_regdate}
					<span>구매자 : ${review.consumer_name}</span>
					<span>판매자 : ${review.seller_name}</span>
					<p class="review_detail_content">${review.review_content}</p>
					<hr/>			
				`;
			
	$.each(survey_list, function(index, item){
		v_html += `<li class="review_detail_survey">${item.survey_content}</li>`;
	});

	v_html += `</div></div>`;
	
	Swal.fire({
		html: v_html,
		width : 800,
		showCloseButton : true,
		showConfirmButton : false
	});
}

// ajax 공통 에러 핸들러 함수 및 토스트 처리
function errorHandler(request, status, error) {
	console.log(request.responseText);

	// 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
	let response = request.responseText;
	let message = response.substring(0, 4) === "msg/" ? response.substring(4) : "";

	showAlert("error", message);

	// 사이드 탭 닫기
	closeSideTab();
}

// ajax 공통 에러 핸들러 함수 및 토스트 처리
function errorAlert(message) {
	let msg = message.substring(0, 4) === "msg/" ? message.substr(4) : "";

	showAlert("error", msg);

	// 사이드 탭 닫기
	closeSideTab();
}

// ajax 공통 에러 핸들러 함수 및 토스트 처리
function errorHandlerWithNoClose(request, status, error) {
	console.log(request.responseText);

	// 서버에서 예외 응답 메시지에서 "msg/"가 포함되어 있다면 사용자 알림을 위한 커스텀 메시지로 토스트 알림 처리
	let response = request.responseText;
	let message = response.substring(0, 4) === "msg/" ? response.substr(4) : "";

	showAlert("error", message);
}
