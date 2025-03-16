<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String tabTitle = request.getParameter("tabTitle");
%>

<style>
	div#sidetab_container {
		position : fixed;
		top : 0;
		right : 0;
		width: 0px;
		height : 100vh;
		max-height : 100vh;
		overflow: hidden;
		padding : 10px 20px 10px 20px;
		background-color : white;
		z-index : 999;
		display : none;
	}
	
	div#sidetab_header {
		width : 100%;
		margin-bottom : 10px;
		display : flex;
		justify-content : center;
		align-items: center;
	}
	
	div#overlay {
		position : fixed;
		top : 0;
		right : 0;
		width: 100vw;
		height: 100vh;
		z-index : 998;
		background: rgba(0, 0, 0, 0.5);
		display: none;
	}
	
	div#goBack {
		position : absolute;
		top : -3px;
		left : 5px;
	}
	
	button#close {
		border : none;
		background-color : transparent;
		font-size : 24pt;
	}
	
	span#sidetab_title {
		font-size : 17pt;
	}
	
	div#sidetab_content {
		height: calc(100vh - 50px);
		overflow-y : auto;
		padding-bottom: 20px;
	}
	
	@media (max-width : 1024px) {
	    div#sidetab_container {
	        max-width: 100vw;
	        width: 100%;
	    }
	}

	@media (min-width : 1024px) {
	    div#sidetab_container {
	        max-width: 700px;
	        width: 700px;
	    }
	}
</style>

<div id="sidetab_container">
	<div id="sidetab_header">
		<div id="goBack">
			<button type="button" id="close" onclick="closeSideTab()">&lt;</button>
		</div>
		<span id="sidetab_title"><%=tabTitle%></span>
	</div>
	<div id="sidetab_content">
	</div>
</div>

<div id="overlay"></div>

<script type="text/javascript">
	let historyStack = [];
	
	$(document).ready(function(){
		// 초기 사이드 네비게이션 숨기기
		$("div#sidetab_container").css("width", "0px");
	});
	
	// 사이드 네비게이션 열기
	function openSideTab(html, tabTitle) {	
		
		const lastHistory = historyStack[historyStack.length - 1];
		
	 	if (lastHistory && lastHistory.html === html) {
	        return;
	 	}
		
		// historyStack에 페이지 저장
		historyStack.push({html, tabTitle});
	
		$("div#sidetab_content").empty().find("*").off();
		$("div#sidetab_content").html("").find("script").remove(); // 스크립트 제거 추가
		
		// 사이드 탭에 HTML 요소 삽입
		$("div#sidetab_content").html(html);
		
		// 탭 제목 동적으로 설정
		$("span#sidetab_title").html(tabTitle);
		
		// 반응형 사이드 네비게이션 처리
		// 브라우저 너비가 1024px (FHD 화면 기준)보다 이하인 경우 반응형 처리
		const width = document.body.clientWidth > 1024 ? "700px" : "100vw";
	
		$("div#sidetab_container")
		.css("display", "block")
		.animate({
			"width" : width
		}, 300);
		
		$("div#overlay").css("display", "block");
		$("body").css("overflow" , "hidden");
	
	}
	
	// 사이드 네비게이션 닫기
	function closeSideTab() {
		// 후기 페이지의 변수 제거
		delete cur_page;

		if(window.auctionTimers){
			Object.keys(window.auctionTimers).forEach((roomId) => {
				clearInterval(window.auctionTimers[roomId]);
				delete window.auctionTimers[roomId];
			});
		}

		$("div#sidetab_content").empty().find("*").off();
		$("div#sidetab_content").html("").find("script").remove(); // 스크립트 제거 추가
		
		if(WebSocketManager.isConnected) {
			WebSocketManager.disconnect();
		}
		
		if(historyStack.length > 1) {
			historyStack.pop();
			
			let previousPage = historyStack[historyStack.length - 1];
						
			$("span#sidetab_title").text(previousPage.tabTitle);
			$("div#sidetab_content").html(previousPage.html);
		}
		
		else {
			historyStack = [];
			
			$("div#sidetab_content").html("");
			
			$("div#sidetab_container")
	        	.css("overflow", "hidden")
	        	.animate({ width: "0px" }, 300, function () {
	            	$(this).css("display", "none");
	        	});

		    $("div#overlay").fadeOut(300);
		    
		    $("body").css("overflow", "");
		}
	}
	
</script>
