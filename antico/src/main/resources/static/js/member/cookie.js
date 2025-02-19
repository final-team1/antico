function getCookie(name) {
    let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? decodeURIComponent(match[2]) : null;
}

$(document).ready(function(){
	
	
	let message = getCookie("message");
    if (message) {
    	showAlert('error', message);
        document.cookie = "message=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;"; // 쿠키 삭제
    }
	
});