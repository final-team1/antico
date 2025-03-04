<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx_path" value="${pageContext.request.contextPath}" />
    
<jsp:include page=".././header/header.jsp" />    

<div style="width:500px; margin:0 auto 10% auto;">

	
	<div style="width:100%; margin:0 auto 0 auto; text-align: center;">
		<img class="main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
	</div>
	
	<div class="" style="width:100%; margin:4% auto 10% auto; border: solid 1.5px #E6E6E6; border-radius: 3%; padding: 20px 20px">
		
		<div class="textSpan">
			<span class="block">중고나라에 오신 것을</span>
			<span>환영합니다.</span>
		</div>
		<form action="${ctx_path}/auth/login" method="post" id="login_form">
		<div style="padding:8% 2% 1% 2%; width:100%;">
			
			<c:if test="${not empty member_user_id}">
			<input type="text" name="member_user_id" class="textbox" placeholder="아이디" value="${member_user_id}"/>
			</c:if>
			<c:if test="${empty member_user_id}">
			<input type="text" name="member_user_id" class="textbox" placeholder="아이디" "/>
			</c:if>
				
		</div>
		<div style="padding:1% 2% 1% 2%;">
			<c:if test="${not empty member_passwd}">
				<input type="text" name="member_passwd" class="textbox" placeholder="비밀번호" value="${member_passwd}"/>
			</c:if>
			<c:if test="${empty member_passwd}">
				<input type="text" name="member_passwd" class="textbox" placeholder="비밀번호"/>
			</c:if>
		</div>		
		
				
		<div style="padding:1% 2% 1% 2%;">
			<button type="submit" name="loginBtn" class="BtnStyle">로그인</button>
		</div>	
		
			
		
		</form>
		<div style="width:100%; margin: 150px 0 3% 0; text-align: center;">
			<img id="kakaoImg" src="${pageContext.request.contextPath}/images/login/kakao.png" width="95%"/>
			
		</div>
		<div style="width:100%; text-align: center; padding-bottom: 3%;">
			<img id="naverImg" src="${pageContext.request.contextPath}/images/login/naver.png" width="95%"/>
		</div>	
		<div style="width:100%; text-align: center; padding-bottom: 3%;">
<button class="gsi-material-button" id="googleImg">
  <div class="gsi-material-button-state"></div>
  <div class="gsi-material-button-content-wrapper">
    <div class="gsi-material-button-icon">
      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
        <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
        <path fill="none" d="M0 0h48v48H0z"></path>
      </svg>
    </div>
    <span class="gsi-material-button-contents">Sign in with Google</span>
    <span style="display: none;">Sign in with Google</span>
  </div>
</button>
		</div>			
		<div style="padding:1% 2% 1% 2%;">
			<button type="button" class="BtnStyle" onclick="location.href='${pageContext.request.contextPath}/member/register'">회원가입하기</button>
		</div>
	
	


</div>



<style type="text/css">

*{
font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
}
.gsi-material-button {
  -moz-user-select: none;
  -webkit-user-select: none;
  -ms-user-select: none;
  -webkit-appearance: none;
  background-color: WHITE;
  background-image: none;
  border: 0px solid #747775;
  -webkit-border-radius: 4px;
  border-radius: 4px;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  color: #1f1f1f;
  cursor: pointer;
  font-family: 'Roboto', arial, sans-serif;
  font-size: 14px;
  height: 55px;
  letter-spacing: 0.25px;
  outline: none;
  overflow: hidden;
  padding: 0 12px;
  position: relative;
  text-align: center;
  -webkit-transition: background-color .218s, border-color .218s, box-shadow .218s;
  transition: background-color .218s, border-color .218s, box-shadow .218s;
  vertical-align: middle;
  white-space: nowrap;
  width: 435px;
  max-width: 600px;
  min-width: min-content;
}

.gsi-material-button .gsi-material-button-icon {
  height: 20px;
  margin-right: 12px;
  min-width: 20px;
  width: 20px;
}

.gsi-material-button .gsi-material-button-content-wrapper {
  -webkit-align-items: center;
  align-items: center;
  display: flex;
  -webkit-flex-direction: row;
  flex-direction: row;
  -webkit-flex-wrap: nowrap;
  flex-wrap: nowrap;
  height: 100%;
  justify-content: space-between;
  position: relative;
  width: 100%;
}

.gsi-material-button .gsi-material-button-contents {
  -webkit-flex-grow: 1;
  flex-grow: 1;
  font-family: 'Roboto', arial, sans-serif;
  font-weight: 500;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: top;
}

.gsi-material-button .gsi-material-button-state {
  -webkit-transition: opacity .218s;
  transition: opacity .218s;
  bottom: 0;
  left: 0;
  opacity: 0;
  position: absolute;
  right: 0;
  top: 0;
}

.gsi-material-button:disabled {
  cursor: default;
  background-color: #ffffff61;
  border-color: #1f1f1f1f;
}

.gsi-material-button:disabled .gsi-material-button-contents {
  opacity: 38%;
}

.gsi-material-button:disabled .gsi-material-button-icon {
  opacity: 38%;
}

.gsi-material-button:not(:disabled):active .gsi-material-button-state, 
.gsi-material-button:not(:disabled):focus .gsi-material-button-state {
  background-color: #303030;
  opacity: 12%;
}

.gsi-material-button:not(:disabled):hover {
  -webkit-box-shadow: 0 1px 2px 0 rgba(60, 64, 67, .30), 0 1px 3px 1px rgba(60, 64, 67, .15);
  box-shadow: 0 1px 2px 0 rgba(60, 64, 67, .30), 0 1px 3px 1px rgba(60, 64, 67, .15);
}

.gsi-material-button:not(:disabled):hover .gsi-material-button-state {
  background-color: #303030;
  opacity: 8%;
}

.BtnStyle{
	width:100%;
	padding: 10px;
	border-radius: 8px;
	border:0px;
}
.textbox{
	width:100%;
	border: solid 1px #E6E6E6;
	border-radius: 7px;
	font-size: 12pt; 
	padding:10px;
	
}
.block{
	display: block;
}

.textSpan > span{
	font-size: 1.5rem;
	line-height: 2rem;
}
.marginBt{
	
	margin-bottom: 15%; 
}
#kakaoImg{
	border-radius: 6px;
}
</style>

<script type="text/javascript">
Kakao.init('61202bdbe397ec06765ee5a7cb40b414');
</script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("img#kakaoImg").bind("click", function(){
		
		location.href='${pageContext.request.contextPath}/oauth2/authorization/kakao';
		
	});
	
	$("img#naverImg").bind("click", function(){
		
		location.href='${pageContext.request.contextPath}/oauth2/authorization/naver';
		
	});
	
	$("#googleImg").bind("click", function(){
		
		location.href='${pageContext.request.contextPath}/oauth2/authorization/google';
		
	});
	
	$("#loginBtn").bind("click",function(){
		
		submit();
		
	});
	
});

</script>

<jsp:include page=".././footer/footer.jsp" />