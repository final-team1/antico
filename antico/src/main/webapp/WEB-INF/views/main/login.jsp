<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
    
<jsp:include page=".././header/header.jsp" />    

<div style="width:25%; margin:0 auto 10% auto;">

	
	<div style="width:100%; margin:0 auto 0 auto; text-align: center;">
		<img class="main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
	</div>
	
	<div class="" style="width:100%; margin:4% auto 10% auto; border: solid 1px gray; border-radius: 3%; padding: 20px 20px">
		
		<div class="textSpan">
			<span class="block">중고나라에 오신 것을</span>
			<span>환영합니다.</span>
		</div>
		
		<div style="width:100%; margin-top: 150px; text-align: center;">
			<img id="kakaoImg" src="${pageContext.request.contextPath}/images/login/kakao_login_medium_wide.png" width="95%"/>
			
		</div>
		<div style="width:100%; text-align: center; padding-bottom:">
			<img id="naverImg" class="mt-1" src="${pageContext.request.contextPath}/images/login/btnG_완성형.png" width="95%" height="auto"/>
		</div>
		
	<p id="token-result"></p>
	<button class="api-btn" onclick="requestUserInfo()" style="visibility:hide">사용자 정보 가져오기</button>
	</div>
	
	
<%-- 	<form action="${ctxPath}/auth/login" method="post">
		
		<input type="text" name="mem_user_id"/>
		
		<input type="text" name="mem_passwd"/>
		
		<input type="submit"/>
		
	</form> --%>


</div>



<style type="text/css">
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
.naverImg{
	height:60px;
}
</style>

<script type="text/javascript">
Kakao.init('61202bdbe397ec06765ee5a7cb40b414');
</script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("img#kakaoImg").bind("click", function(){
		
		Kakao.Auth.authorize({
			redirectUri: 'http://localhost/antico/member/login',
			
		});
		
		console.log(getAccessToken());
		
	});
	
	console.log(getAccessToken());
	
});

function requestUserInfo() {
    Kakao.API.request({
      url: '/v2/user/me',
    })
      .then(function(res) {
        alert(JSON.stringify(res));
      })
      .catch(function(err) {
        alert(
          'failed to request user information: ' + JSON.stringify(err)
        );
      });
  }
</script>

<jsp:include page=".././footer/footer.jsp" />