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
		title: msg == null ? "오류가 발생했습니다. 다시 시도하여 주십시오" : msg 
	});
}
