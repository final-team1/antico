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

    $("input[name='reason']").change(function() {
        checkCheckboxes();
        toggleOtherReason(); // 체크박스 상태 변경 시 '기타' 입력란 토글
    });

    checkCheckboxes(); // 페이지 로드 시 체크 상태 확인

    // 기타 눌렀을 때 입력란 토글
    function toggleOtherReason() {
        var other_input = document.getElementById("other_reason");
        var other_checkbox = document.getElementById("reason_5");
        var char_count = document.getElementById("char_count");

        if (other_checkbox.checked) {
            other_input.style.display = "block";
            char_count.style.display = "inline";
        } else {
            other_input.style.display = "none";
            other_input.value = "";
            char_count.style.display = "none";
        }
    }



    // 탈퇴 버튼 클릭 시 모달 열기
    document.getElementById("withdraw_button").addEventListener("click", function() {
        var modal = document.getElementById("confirmationModal");
        modal.style.display = "block";
    });

    // 모달 취소 버튼 클릭 시 모달 닫기
    document.getElementById("cancelButton").addEventListener("click", function() {
        var modal = document.getElementById("confirmationModal");
        modal.style.display = "none";
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener("click", function(event) {
        var modal = document.getElementById("confirmationModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

    // 페이지 로드 시 '기타' 체크박스 상태에 맞춰 입력란 토글
    toggleOtherReason();
    
////////////////////////////////////////////////////////
   let selected_reasons = [];

   $("#withdraw_button").click(function () {
       selected_reasons = []; // 초기화
       
       $("input[name='reason']:checked").each(function () {
           if ($(this).val() === "기타") {
               let other_reason = $("#other_reason").val().trim();
               if (other_reason) {
                   selected_reasons.push("기타: " + other_reason);
               }
           } else {
               selected_reasons.push($(this).val());
           }
       });

       console.log("선택된 탈퇴 사유:", selected_reasons);
   });

   $("#confirmButton").click(function () {
	    const pk_member_no = $("input[name='pk_member_no']").val(); // hidden input에서 값 가져오기

	    let formData = {
	        fk_member_no: pk_member_no, // VO의 변수명과 맞춰야 함
	        leave_reason: selected_reasons.join(", ") // VO의 leave_reason 필드에 매핑
	    };

	    $.ajax({
	        url: "<%= ctx_path %>/mypage/delete_submit",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify(formData),
	        dataType: "json",
	        success: function (json) {
	            console.log("응답 데이터:", JSON.stringify(json));
	            if (json.n == 1) {
	                alert("탈퇴 신청이 완료되었습니다.");
	                location.href = "<%= ctx_path %>/logout";
	            } else {
	                alert("탈퇴 실패!!");
	            }
	        },
	        error: function (request, status, error) {
	            alert("오류 발생: " + request.responseText);
	        }
	    });
	});

   
    
}); // end of $(document).ready(function() {})

// 기타 입력 시 글자 수 업데이트
function updateCharCount() {
    var textarea = document.getElementById("other_reason");
    var char_count = document.getElementById("char_count");
    var current_length = textarea.value.length;
    char_count.textContent = current_length + "/200";
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

    /* 모달 스타일 */
    .modal {
        display: none; /* 기본적으로 모달을 숨김 */
        position: fixed;
        z-index: 1; /* 모달이 화면 위에 표시되도록 설정 */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4); /* 배경을 어둡게 처리 */
        overflow: auto;
    }

    .modal_content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 25%; /* 모달 크기 설정 */
        border-radius: 10px;
        text-align: center;
    }

    .modal_footer {
        text-align: center;
        display: flex;
    }

    button.modal_close {
        background-color: #f44336;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button.modal_close:hover {
        background-color: #d32f2f;
    }

    button.btn1 {
        width: 50%;
    }

    button#cancelButton {
        background-color: white;
        color: black;
        padding: 10px auto;
        border: solid 1px black;
        border-radius: 5px;
        cursor: pointer;
    }

    button#confirmButton {
        background-color: black;
        color: white;
        padding: 10px 20px;
        border: solid 1px black;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 20px;
    }

    button#cancelButton:hover
    , button#confirmButton:hover {
        box-shadow: 0 0 10px 2px rgba(40, 167, 69, 0.7);
    }
</style>
<form name="delete_frm">
<input type="hidden" name="pk_member_no" value="${requestScope.pk_member_no}"/>
    <div id="container">
        <h5 style="font-weight: bold; margin-top: 45px; letter-spacing: -0.5px;">탈퇴 사유를 알려주시면</h5>
        <h5 style="font-weight: bold; letter-spacing: -0.5px;">개선을 위해 노력하겠습니다</h5>
		
        <div style="margin-top: 30px;">
            <span style="color: gray; font-size: 10pt; letter-spacing: -0.5px;">다중 선택이 가능해요.</span>
	
            <div class="checkbox_group" style="margin-top: 10px;">
                <input type="checkbox" id="reason_1" name="reason" value="사용 빈도 낮음, 개인정보 및 보안 우려">
                <label for="reason_1">사용 빈도가 낮고 개인정보 및 보안 우려</label>

                <input type="checkbox" id="reason_2" name="reason" value="비매너 사용자들로 인한 불편">
                <label for="reason_2">비매너 사용자들로 인한 불편 (사기 등)</label>

                <input type="checkbox" id="reason_3" name="reason" value="서비스 기능 불편">
                <label for="reason_3">서비스 기능 불편 (상품등록/거래 등)</label>

                <input type="checkbox" id="reason_4" name="reason" value="이벤트 등의 목적으로 한시 사용">
                <label for="reason_4">이벤트 등의 목적으로 한시 사용</label>

                <input type="checkbox" id="reason_5" name="reason" value="기타">
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
        </ul>
        </div>
        
        <div style="margin-top: 30px; font-size: 12px;">
            <button type="button" type="button" id="withdraw_button" class="btn" disabled>회원탈퇴 신청</button>
        </div>
    </div>

    <!-- 모달 확인 창 -->
    <div id="confirmationModal" class="modal">
        <div class="modal_content">
            <h5 style="font-weight: bold; letter-spacing: -0.5px;">탈퇴 신청</h5>
            <p style="font-size: 11pt;">유의 사항을 확인하였으며,<br><br><br>
		    <span style="color: #28a745; font-weight: bold;">72시간 이내</span> 재접속이 없을 시 탈퇴 처리됩니다.</p>
            
            <div class="modal_footer">
                <button id="cancelButton" type="button" class="btn1">취소</button>
                <button id="confirmButton" type="button" class="btn1">신청</button>
            </div>
        </div>
    </div>
</form>
