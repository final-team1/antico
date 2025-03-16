<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
    
<jsp:include page=".././header/header.jsp" />    

<div style="width:25%; margin:0 auto 10% auto;">
	
	<div style="width:100%; margin:0 auto; text-align: center;">
		<img class="main_logo" src="${pageContext.request.contextPath}/images/logo/logo_black.svg" width="200"/>
	</div>
	
	<div class="" style="width:500px; margin:4% auto 10% auto; border: solid 1.5px #E6E6E6; border-radius: 3%; padding: 20px 20px">
		<form action="${ctxPath}/member/register" method="post" name="registerForm">
		<div class="textSpan">
			<span class="block">중고나라에 오신 것을</span>
			<span>환영합니다.</span>
		</div>
		
		<div style="padding:8% 2% 1% 2%; width:100%; margin-bottom: 5%;">
			<p>아이디</p>
			<input type="text" name="member_user_id" class="textbox" placeholder="아이디"/>
			<p style="color:red; padding-left:8px; margin-top:10px; display:none; font-size:10pt;" id="idCheck">아이디는 영문, 숫자를 포함해야하며 8~20글자만 가능합니다.</p>
		</div>
		<div style="padding:1% 2% 1% 2%; margin-bottom: 5%;">
			<p>비밀번호</p>
			<input type="password" name="member_passwd" class="textbox" placeholder="비밀번호"/>
			<p style="color:red; padding-left:8px; margin-top:10px; display:none; font-size:10pt;" id="passCheck">아이디는 영문, 숫자, 특수문자 모두 사용하여 8~20글자만 가능합니다</p>
		</div>		
		<div style="padding:1% 2% 0% 2%; margin-bottom: 5%;">
			<p>비밀번호 확인</p>
			<input type="password" name="member_passwd_ck" class="textbox" placeholder="비밀번호 확인"/>
			<p style="color:red; padding-left:8px; margin-top:10px; display:none; font-size:10pt;" id="passCheckResult">비밀번호가 일치하지 않습니다.</p>
		</div>		
		
				
		<div style="padding:1% 2% 1% 2%; margin-bottom: 5%;">
			전회번호
			<input type="text" name="member_tel" class="textbox" placeholder="- 없이 숫자만 입력해주세요"/>
			<p style="color:red; padding-left:8px; margin-top:10px; display:none; font-size:10pt;" id="telCheck">전화번호는 숫자로 11자를 입력해주세요.</p>
		</div>	
		
		<div style="padding:0% 2% 1% 2%; margin-bottom: 5%;">
			이름
			<input type="text" name="member_name" class="textbox" placeholder=""/>
			<p style="color:red; padding-left:8px; margin-top:10px; display:none; font-size:10pt;" id="nameCheck">이름은 한글로 2~5 글자로 입력해주세요.</p>
		</div>	
		
		
		<div style="width:100%; margin: 150px 0 3% 0; text-align: center;">
			
			
		</div>
		<div style="width:100%; text-align: center; padding-bottom: 3%;">
			
		</div>			
		<div style="padding:1% 2% 1% 2%;">
			<button type="button" class="BtnStyle btnSubmit">회원가입하기</button>
			<input type="submit" style="display: none"/>
		</div>
		


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
	
	const user_id_reg = /^[a-zA-Z][a-zA-Z0-9]{7,19}$/;
	const user_passwd_reg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~@#$!%*?&])[a-zA-Z\d~@#$!%*?&]{8,20}$/;
	const user_tel_reg = /^010\d{8}$/;
	const user_name_reg = /^[가-힣]{2,5}$/;

	// 아이디 검사
	$("input:text[name='member_user_id']").on("change", function(e){
		const user_id = $(e.target).val().trim();
		$("#idCheck").toggle(!user_id_reg.test(user_id));
	});

	// 비밀번호 검사
	$("input:password[name='member_passwd']").on("change", function(e){
		const passwd = $(e.target).val().trim();
		$("#passCheck").toggle(!user_passwd_reg.test(passwd));
	});

	// 비밀번호 확인 검사
	$("input:password[name='member_passwd_ck']").on("change", function(e){
		const passwd_ck = $(e.target).val().trim();
		const passwd = $("input:password[name='member_passwd']").val().trim();
		$("#passCheckResult").toggle(passwd_ck == "" || passwd_ck != passwd);
	});

	// 전화번호 검사
	$("input:text[name='member_tel']").on("change", function(e){
		const tel = $(e.target).val().trim();
		$("#telCheck").toggle(!user_tel_reg.test(tel));
	});

	// 이름 검사
	$("input:text[name='member_name']").on("change", function(e){
		const name = $(e.target).val().trim();
		$("#nameCheck").toggle(!user_name_reg.test(name));
	});

	// 제출 버튼 클릭 이벤트
	$(".btnSubmit").on("click", function(){
		const user_id = $("input:text[name='member_user_id']").val().trim();
		const passwd = $("input:password[name='member_passwd']").val().trim();
		const passwd_ck = $("input:password[name='member_passwd_ck']").val().trim();
		const tel = $("input:text[name='member_tel']").val().trim();
		const name = $("input:text[name='member_name']").val().trim();

		// 모든 필드가 채워졌는지 확인
		if (user_id === "" || passwd === "" || passwd_ck === "" || tel === "" || name === "") {
			alert("입력하지 않은 항목이 있습니다. 다시 입력해주세요.");
			return;
		}

		// 유효성 검사 통과 여부 확인
		if (user_id_reg.test(user_id) && user_passwd_reg.test(passwd) 
				&& user_tel_reg.test(tel) && user_name_reg.test(name) && passwd_ck === passwd) {
			$("form[name='registerForm']").submit();
		} else {
			alert("모든 항목을 형식에 맞게 작성해주세요.");
		}
	});
});


</script>


<jsp:include page=".././footer/footer.jsp" />