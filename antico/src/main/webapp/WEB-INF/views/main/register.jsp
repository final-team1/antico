<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
    
<jsp:include page=".././header/header.jsp" />    

<div style="width:25%; margin:0 auto 10% auto;">
	
	<div style="width:100%; margin:0 auto 0 auto; text-align: center;">
		<img class="main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
	</div>
	
	<div class="" style="width:100%; margin:4% auto 10% auto; border: solid 1.5px #E6E6E6; border-radius: 3%; padding: 20px 20px">
		<form action="${ctxPath}/member/register" method="post">
		<div class="textSpan">
			<span class="block">중고나라에 오신 것을</span>
			<span>환영합니다.</span>
		</div>
		
		<div style="padding:8% 2% 1% 2%; width:100%; margin-bottom: 5%;">
			<p>아이디</p>
			<input type="text" name="member_user_id" class="textbox" placeholder="아이디"/>
				
		</div>
		<div style="padding:1% 2% 1% 2%; margin-bottom: 5%;">
			<p>비밀번호</p>
			<input type="text" name="member_passwd" class="textbox" placeholder="비밀번호"/>
		</div>		
		
				
		<div style="padding:1% 2% 1% 2%; margin-bottom: 5%;">
			전회번호
			<input type="text" name="a" class="textbox" placeholder="- 없이 숫자만 입력해주세요"/>
		</div>	
		
			
		
		
		<div style="width:100%; margin: 150px 0 3% 0; text-align: center;">
			
			
		</div>
		<div style="width:100%; text-align: center; padding-bottom: 3%;">
			
		</div>			
		<div style="padding:1% 2% 1% 2%;"">
			<button type="submit" class="BtnStyle" onclick="location.href='${ctxPath}/member/register'">회원가입하기</button>
		</div>
		

	
<%-- 	<form action="${ctxPath}/auth/login" method="post">
		
		<input type="text" name="mem_user_id"/>
		
		<input type="text" name="mem_passwd"/>
		
		<input type="submit"/>
		
	</form> --%>

</form>
</div>



<style type="text/css">

*{
font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
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
		
		Kakao.Auth.authorize({
			redirectUri: 'http://localhost/antico/member/login',
			
		});
		
		console.log(getAccessToken());
		
	});
	
	
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