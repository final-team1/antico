<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	div#sidenav_container {
		position : absolute;
		top : 0;
		right : 0;
		width: 0px;
		height : 100vh;
		padding : 20px;
		background-color : white;
		z-index : 999;
		display : none;
	}
	
	div#overlay {
		position : absolute;
		top : 0;
		right : 0;
		width: 100vw;
		height: 100%;
		width : 100%;
		z-index : 998;
		background: rgba(0, 0, 0, 0.5);
		display: none;
	}
	
	button#close {
		border : none;;
		background-color : transparent;
		font-size : 26pt;
	}
</style>

<div id="sidenav_container">
	<div id="sidenav_header">
		<button type="button" id="close" onclick="closeSideNav()">&lt;</button>
	</div>
</div>

<div id="overlay"></div>

<script type="text/javascript">
	
	$(document).ready(function(){
		// 초기 사이드 네비게이션 숨기기
		$("div#sidenav_container").css("width", "0px");
	});
	
	// 사이드 네비게이션 열기
	function openSideNav() {
		// 반응형 사이드 네비게이션 처리
		// 브라우저 너비가 1024px (FHD 화면 기준)보다 이하인 경우 반응형 처리
		const width = document.body.clientWidth > 1024 ? "600px" : "100vw";
		
		$("div#sidenav_container")
			.css("display", "block")
			.animate({
				"width" : width
			}, 300);
			
		$("div#overlay").css("display", "block");
		$("body").css("overflow" , "hidden");
	}
	
	// 사이드 네비게이션 닫기
	function closeSideNav() {
		$("div#sidenav_container")
			.animate({width:"0"}, 300, function(){
				$(this).css("display", "none");
			});
			
		$("div#overlay").css("display", "none");
		$("body").css("overflow" , "");
	}
</script>
