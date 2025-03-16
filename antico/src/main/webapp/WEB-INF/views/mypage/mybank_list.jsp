<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="bank_map" value="${requestScope.bank_map}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대표 계좌 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .mypage_container {
            width: 90%;
            max-width: 500px;
            background: white;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .mypage_title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .mypage_account_info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 15px;
        }
        .mypage_account_info div {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-weight: 500;
        }
        .mypage_account_info span {
            color: #555;
        }
        .mypage_btn {
            width: 100%;
            padding: 10px;
            background: green;
            color: white;
            text-align: center;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.3s;
            border: none;
        }
        .mypage_btn:hover {
            background: #00C853;
        }
        .mypage_btn_secondary {
            background: #6c757d;
            margin-top: 10px;
        }
        .mypage_btn_secondary:hover {
            background: #545b62;
        }
        .mypage_hidden {
            display: none;
        }
        .mypage_input_box {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .edit:hover {
            transform: scale(1.1); /* 크기 확대 */
            opacity: 0.8; /* 투명도 조절 */
            cursor: pointer; /* 마우스 커서 변경 */
        }

        /* 예금주명 수정 불가 스타일 */
        .mypage_input_box[readonly] {
            background-color: #f0f0f0; /* 배경색 변경 */
            pointer-events: none; /* 마우스 클릭 차단 */
            cursor: not-allowed; /* 마우스 커서를 수정 불가로 변경 */
        }
        
    .check-btn {
        border: none; /* 테두리는 연한 회색 */
        background-color: #eee;
        color: white; /* 기본 체크마크 색 */
        padding: 6px;
        margin-top: 8px;
        cursor: pointer;
        text-align: center;
        border-radius: 50%; /* 둥글게 */
        display: inline-flex;
        justify-content: center;
        align-items: center;
        transition: 0.3s;
    }

    .check-btn.checked {
        background-color: #28a745; /* 체크된 상태 배경 초록색 */
        color: white; /* 체크마크는 흰색 */
    }

    .check-btn svg {
        fill: currentColor; /* 부모의 색상에 맞게 SVG 색상 적용 */
        transition: 0.3s;
    }
    </style>
</head>
<body>

    <div class="mypage_container">
        <!-- 대표 계좌 정보 -->
        <div class="mypage_title">대표 계좌 
            <img class="edit" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAqhaRDRUFQF_rEAT9NoCV-yEtFHvMM_3z8g&s" onclick="edit_bank()" style="height:4%; width: 6%; float: right;"/>
        </div>
        <div class="mypage_account_info">
			<div>예금주 <span>${requestScope.member_name}</span></div>
			<div>은행명 <span>${bank_map.account_bank}</span></div>
			<div>계좌번호 <span>${bank_map.account_no}</span></div>
        </div>
        <button class="mypage_btn mypage_btn_secondary" id="add_account_btn">+ 계좌 신규 등록</button>

        <!-- 신규 계좌 등록 폼 -->
        <div class="mypage_hidden" id="new_account_form">
            <div class="mypage_title" style="margin-top: 20px;">신규 계좌 등록</div>

            <!-- 계좌 등록을 위한 입력 필드 -->
            <input type="text" class="mypage_input_box" id="new_owner" name="owner" value="장민규" readonly placeholder="예금주명 입력">
            <select class="mypage_input_box" id="new_bank_name" name="bank_name">
                <option value="0">토스뱅크</option>
                <option value="1">카카오뱅크</option>
                <option value="2">신한은행</option>
                <option value="3">국민은행</option>
                <option value="4">농협은행</option>
            </select>

            <input type="text" class="mypage_input_box" id="new_account_num" name="account_num" placeholder="계좌번호 입력" pattern="^[^ㄱ-ㅎ가-힣]*$" maxlength="14" required>

            <button type="button" class="mypage_btn" id="register_account_btn">등록</button>

            <div>
                <button class="check-btn checked" id="representative_account_btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24">
                        <path d="M9 16.2l-4.2-4.2 1.4-1.4L9 13.4l9.8-9.8 1.4 1.4z"/>
                    </svg>
                </button>
                <span style="font-size: 10pt;">대표 계좌로 설정</span>
            </div>
            <div style="padding:8px;">
                <span style="font-size: 8pt; color: gray;">안전한 중고거래를 위해 회원 가입시 본인 인증한<br>
                명의의 계좌만 사용하실 수 있습니다.</span>
            </div>
        </div>
        
    </div>
<script>
$(document).ready(function() {
    // 페이지 로드 시 폼 상태 로컬 스토리지에서 확인하여 표시 여부 결정
    const isFormVisible = localStorage.getItem('isNewAccountFormVisible') === 'true';
    const $newAccountForm = $("#new_account_form");

    if (isFormVisible) {
        $newAccountForm.removeClass("mypage_hidden");
    } else {
        $newAccountForm.addClass("mypage_hidden");
    }

    // 신규 계좌 등록 버튼 클릭 시 폼 토글
    $("#add_account_btn").on("click", function() {
        $newAccountForm.toggleClass("mypage_hidden");
        
        // 폼 상태를 로컬 스토리지에 저장
        localStorage.setItem('isNewAccountFormVisible', !$newAccountForm.hasClass("mypage_hidden"));
    });

    // 계좌 등록 버튼 클릭 시 AJAX 처리
    $("#register_account_btn").on("click", function() {
    	

        const bankName = $("#new_bank_name option:selected").text();
        const accountNum = $("#new_account_num").val().trim();
        const isChecked = $("#representative_account_btn").hasClass("checked") ? 1 : 0; // 체크 상태 값
        // 계좌번호가 비어있으면 오류 메시지
        if (!accountNum) {
            showAlert("error", "계좌번호를 올바르게 입력하세요.");
            return;
        }

        // 계좌번호에 숫자만 있는지 확인
        const nonNumericRegex = /[^0-9]/;
        if (nonNumericRegex.test(accountNum)) {
            showAlert("error", "계좌번호에는 숫자만 입력할 수 있습니다.");
            return;
        }
        
        $.ajax({
            url: "<%=ctx_Path%>/mypage/register_account",
            type: "post",
            data: {
                "bank_name": bankName,
                "account_num": accountNum,
                "account_type": isChecked // 체크 상태 전송
            },
            dataType: "json",
            success: function(response) {
                if (response  == 1) {
                    showAlert("success", "계좌가 등록되었습니다.");
                    $newAccountForm.addClass("mypage_hidden");
                    localStorage.setItem('isNewAccountFormVisible', false); // 폼 상태 저장
                } else {
                	showAlert('error', '계좌등록을 실패하였습니다.');
                }
            },
            error: function (request, status, error) {
                errorHandler(request, status, error);
            }
        });


    });

    // 체크 버튼 클릭 시 체크 상태 토글
    $(".check-btn").on("click", function() {
        $(this).toggleClass("checked"); // 체크 상태 변경
    });
});


function edit_bank() {
	
	var tabTitle = "계좌 편집";
    
    $.ajax({
       url : "<%=ctx_Path%>/mypage/edit_bank",
       success : function(html) {
          openSideTab(html, tabTitle);
       },
       error : function(e) {
          console.log(e);
          closeSideTab();
       }
    });
	
}
</script>
</body>
</html>
