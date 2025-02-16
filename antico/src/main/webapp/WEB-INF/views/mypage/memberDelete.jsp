<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctx_path = request.getContextPath();
%>    

<script>
$(document).ready(function() {
    // 체크박스 상태에 따라 탈퇴 버튼 활성화/비활성화
    function checkCheckboxes() {
        var checkboxes = document.querySelectorAll('input[name="reason"]:checked');
        var submitButton = document.getElementById("withdraw_button");
        submitButton.disabled = checkboxes.length === 0; // 하나라도 체크되지 않으면 버튼 비활성화
    }

    // 체크박스를 클릭할 때마다 checkCheckboxes 함수 호출
    $("input[name='reason']").change(function() {
        checkCheckboxes();
    });

    // 페이지 로딩 시 체크박스 상태 확인
    checkCheckboxes();
});

   // 기타 눌렀을 때 토글
   function toggleOtherReason() {
       var other_input = document.getElementById("other_reason");
       var other_checkbox = document.getElementById("reason_5");
       var char_count = document.getElementById("char_count");

       // "기타" 체크박스를 눌렀을 때
       if (other_checkbox.checked) {
           other_input.style.display = "block";
           char_count.style.display = "inline"; // char_count 표시
       } else {
           other_input.style.display = "none";
           other_input.value = "";
           char_count.style.display = "none"; // char_count 숨기기
       }
   }
   
   // 기타에서 입력시 글자수 업데이트
   function updateCharCount() {
       var textarea = document.getElementById("other_reason");
       var char_count = document.getElementById("char_count");
       var current_length = textarea.value.length;
       char_count.textContent = current_length + "/200"; // 현재 글자 수 업데이트
   }
</script>

<style>
    /* 체크박스 숨기기 */
    .checkbox_group input[type="checkbox"] { display: none; }

    /* 라벨 스타일 */
    .checkbox_group label {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px;
        font-size: 14px;
        border-radius: 20px;
        border: 2px solid #ddd;
        cursor: pointer;
        transition: all 0.3s;
    }

    /* 동그란 체크 아이콘 */
    .checkbox_group label:before {
        content: "○"; /* 기본 상태 */
        font-size: 18px;
        color: #aaa;
        transition: color 0.3s;
    }

    /* 체크되었을 때 ✔ 표시 및 초록색 테두리 */
    .checkbox_group input[type="checkbox"]:checked + label {
        border-color: #28a745;
        background-color: #e8f5e9;
        font-weight: bold;
    }
    .checkbox_group input[type="checkbox"]:checked + label:before {
        content: "✔"; /* 체크되었을 때 */
        color: #28a745;
        font-weight: bold;
    }
    
    .Note li {
    	margin-top: 20px;
    }
    
    .Note li span:first-child {
    	font-size: 16pt;
    }
    
    .Note li span:last-child {
    	padding-top: 5px;
    }
    
    body {
        overflow: hidden;  /* 전체 스크롤을 없앰 */
        height: 100%;      /* 화면 전체를 사용하도록 설정 */
    }
    
    .container {
	    overflow: hidden; /* 스크롤을 숨깁니다 */
	}
	
	.info li {
		padding-left: 15px;
		margin-top: 10px;
		font-size: 10pt;
	}
	
    /* 회원탈퇴 버튼 스타일 */
	#withdraw_button {
	    background-color: #28a745;
	    color: white;
	    font-size: 14px;
	    padding: 10px 20px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    width:100%;
	    height:9%;
	    transition: background-color 0.3s;
	}
	
	#withdraw_button:disabled {
	    background-color: #ddd;
	    cursor: not-allowed;
	}
</style>

<body>
	<div id="container">
   		<h5 style="font-weight: bold; margin-top: 45px; letter-spacing: -0.5px;">탈퇴 사유를 알려주시면</h5>
	    <h5 style="font-weight: bold; letter-spacing: -0.5px;">개선을 위해 노력하겠습니다</h5>
	
	    <div style="margin-top: 30px;">
	        <span style="color: gray; font-size: 10pt; letter-spacing: -0.5px;">다중 선택이 가능해요.</span>
	
	        <div class="checkbox_group" style="margin-top: 10px;">
	            <input type="checkbox" id="reason_1" name="reason" value="사용 빈도 낮음, 개인정보 및 보안 우려" onclick="toggleOtherReason()">
	            <label for="reason_1">사용 빈도가 낮고 개인정보 및 보안 우려</label>
	
	            <input type="checkbox" id="reason_2" name="reason" value="비매너 사용자들로 인한 불편" onclick="toggleOtherReason()">
	            <label for="reason_2">비매너 사용자들로 인한 불편 (사기 등)</label>
	
	            <input type="checkbox" id="reason_3" name="reason" value="서비스 기능 불편" onclick="toggleOtherReason()">
	            <label for="reason_3">서비스 기능 불편 (상품등록/거래 등)</label>
	
	            <input type="checkbox" id="reason_4" name="reason" value="이벤트 등의 목적으로 한시 사용" onclick="toggleOtherReason()">
	            <label for="reason_4">이벤트 등의 목적으로 한시 사용</label>
	
	            <input type="checkbox" id="reason_5" name="reason" value="기타" onclick="toggleOtherReason()">
	            <label for="reason_5">기타</label>
	        </div>
	
	        <textarea id="other_reason" name="other_reason" maxlength="200" 
	            style="display: none; margin-top: 10px; width: 100%; height: 80px; resize: none; letter-spacing: -0.5px;" 
	            placeholder="상세 사유 작성(예 : 타 서비스 이용)" oninput="updateCharCount()">
	        </textarea>
	        <span id="char_count" style="font-size: 10pt; color: gray; margin-top: 5px; display: none;">0/200</span>
	    </div>
	    <hr style="width: 100%; margin-top: 30px; border: solid 2px #eee;">
	    
	    <div style="margin-top: 30px; word-wrap: break-word; overflow-wrap: break-word;">
	    <h5 style="font-weight: bold;">유의 사항을 확인해주세요!</h5>
	
	    <ul class="Note" style="font-size: 14px; color: #555; list-style-type: none; padding-left: 0; margin-left: 0;">
	        <li style="display: flex; margin-bottom: 15px;">
	            <strong><span style="color: #28a745; margin-right: 10px;">01</span></strong>
	            <span>탈퇴 신청일로부터 30일 이내에 동일한 아이디와 휴대폰 번호로 가입 불가하며 재가입 시, 신규 가입 혜택은 적용되지 않습니다.</span>
	        </li>
	        <li style="display: flex; margin-bottom: 15px;">
	            <strong><span style="color: #28a745; margin-right: 10px;">02</span></strong>
	            <span>회원 탈퇴 시 본인 계정에 등록된 게시물 또는 회원이 작성한 게시물 일체는 삭제됩니다. 다만, 다른 회원에 의해 스크랩되어 게시되거나 공용 게시판에 등록된 게시물은 삭제되지 않으니 삭제를 원하신다면 미리 삭제 후 탈퇴를 진행해주세요.</span>
	        </li>
	        <li style="display: flex; margin-bottom: 15px;">
	            <strong><span style="color: #28a745; margin-right: 10px;">03</span></strong>
	            <span>전자 상거래 등에서의 소비자 보호에 관한 법률 규정에 따라 아래와 같이 기록을 보관하며, 법률 의한 경우 외 다른 목적으로 이용되지 않습니다.</span>
	        </li>
	        <hr style="width: 100%; margin-top: 15px; border: solid 1px #666666;">
	        <ul class="info" style="font-size: 12px; color: #666; padding-left: 0; margin-left: 0; margin-top: 10px;">
	            <li>표시 광고에 대한 기록 <span style="float: right; font-size: 12pt; font-weight: bold;  padding-right: 15px;">6개월</span></li>
	            <hr style="width: 100%; margin-top: 15px; border: solid 1px #eee;">
	            <li>계약 또는 청약철회, 대금결제 및 재화 등의 공급에 관한 기록  <span style="float: right; font-size: 12pt; font-weight: bold;  padding-right: 15px;">5년</span></li>
	            <hr style="width: 100%; margin-top: 15px; border: solid 1px #eee;">
	            <li>소비자의 불만 또는 분쟁처리에 관한 기록  <span style="float: right; font-size: 12pt; font-weight: bold;  padding-right: 15px;">3년</span></li>
	            <hr style="width: 100%; margin-top: 15px; border: solid 1px #eee;">
	            <li>로그인 기록  <span style="float: right; font-size: 12pt; font-weight: bold;  padding-right: 15px;">3개월</span></li>
	            <hr style="width: 100%; margin-top: 15px; border: solid 1px #eee;">
	            <li>전자금융거래기록  <span style="float: right; font-size: 12pt; font-weight: bold; padding-right: 15px;">5년</span></li>
	            <hr style="width: 100%; margin-top: 15px; border: solid 1px #eee;">
	        </ul>
	        <li style="display: flex; margin-bottom: 15px;">
	            <strong><span style="color: #28a745; margin-right: 10px;">04</span></strong>
	            <span>탈퇴 신청 후 72시간(3일) 이내 동일한 계정으로 로그인시 탈퇴 신청이 자동으로 철회됩니다.</span>
	        </li>
	    </ul>
	</div>
    <button id="withdraw_button" disabled>회원 탈퇴</button>
</div>


</body>
