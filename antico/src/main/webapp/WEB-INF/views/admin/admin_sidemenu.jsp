<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	String ctxPath = request.getContextPath();
%>

<div style="width:15%;">
	<h2 class="side">Admin</h2>
	
	<h4 class="side">User</h4>
	
	<ul>
		<li>
			<a href="<%= ctxPath %>/admin/admin_member_management">사용자 관리</a>
		</li>
		<li>상품 관리</li>
	</ul>
	
	<h4 class="side">Management</h4>
	
	<ul>
		<li class="noticeWrite">
			<a href="javascript:void(0);" onclick="toggleNoticeMenu()">공지사항</a>
			<ul class="noticeMenu" style="display: none; margin-left: 20px;">
				<li><a href="<%= ctxPath %>/admin/admin_notice_write">공지사항 작성</a></li>
				<li><a href="<%= ctxPath %>/admin/admin_notice_delete">공지사항 삭제</a></li>
			</ul>
		</li>
		<li class="inquireReply"><a href="<%= ctxPath %>/admin/admin_uninquire_list">1:1 문의</a></li>
	</ul>
	
	<h4 class="side">Statistics</h4>
</div>

<script>
	
	function toggleNoticeMenu() {
		var noticeSubMenu = document.querySelector('.noticeMenu');
		if (noticeSubMenu.style.display === "none") {
			noticeSubMenu.style.display = "block";
		} else {
			noticeSubMenu.style.display = "none";
		}
	}
</script>

<style>
	li {
	    list-style: none;
	    margin-bottom: 6%;
	    cursor: pointer;
	}
	ul {
		margin-bottom: 15%;
		padding: 0;
		border-bottom: 2px solid #ddd;
	}
	.side {
		margin-bottom: 10%;
	}
	/* 숨겨져 있는 서브 메뉴 */
	.noticeSubMenu {
		display: none;
	}
</style>
