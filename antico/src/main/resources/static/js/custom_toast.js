const Toast = Swal.mixin({
	  toast: true,
	  position: "top-end",
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
// icon 종류 : success, error, waring, info, question
function showAlert(type, msg) {
	Toast.fire({
		icon: type,
		title: msg.trim() == "" ? "오류가 발생했습니다. 다시 시도하여 주십시오" : msg 
	});
}

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
