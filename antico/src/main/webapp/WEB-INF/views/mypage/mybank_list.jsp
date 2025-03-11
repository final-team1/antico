<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx_Path = request.getContextPath();
%>
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
            <div>예금주 <span>장민규</span></div>
            <div>은행명 <span>토스뱅크</span></div>
            <div>계좌번호 <span>100032806150</span></div>
        </div>
        <button class="mypage_btn mypage_btn_secondary" id="add_account_btn">+ 계좌 신규 등록</button>

        <!-- 신규 계좌 등록 폼 -->
        <div class="mypage_hidden" id="new_account_form">
            <div class="mypage_title" style="margin-top: 20px;">신규 계좌 등록</div>

            <!-- 계좌 등록 폼 시작 -->
            <form id="account_form" action="<%=ctx_Path%>/mypage/register_account" method="POST">
                <!-- 예금주명은 수정 불가 -->
                <input type="text" class="mypage_input_box" id="new_owner" name="owner" value="장민규" readonly placeholder="예금주명 입력">
                <!-- 은행명 변경을 위한 셀렉트 태그 -->
                <select class="mypage_input_box" id="new_bank_name" name="bank_name">
                    <option value="0">토스뱅크</option>
                    <option value="1">카카오뱅크</option>
                    <option value="2">신한은행</option>
                    <option value="3">국민은행</option>
                    <option value="4">농협은행</option>
                    <!-- 추가적인 은행들을 추가 가능 -->
                </select>

                <input type="text" class="mypage_input_box" id="new_account_num" name="account_num" placeholder="계좌번호 입력" pattern="^[^ㄱ-ㅎ가-힣]*$" maxlength="14" required>

                <button type="submit" class="mypage_btn" id="register_account_btn">등록</button>
            </form>
            <!-- 계좌 등록 폼 끝 -->

            <div>
                <button class="check-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24">
                        <path d="M9 16.2l-4.2-4.2 1.4-1.4L9 13.4l9.8-9.8 1.4 1.4z"/>
                    </svg>
                </button>
                <span style="font-size: 10pt;">대표 계좌로 설정</span>
            </div>
            <div style="padding:8px; ">
                <span style="font-size: 8pt; color: gray;">안전한 중고거래를 위해 회원 가입시 본인 인증한<br>
                명의의 계좌만 사용하실 수 있습니다.</span>
            </div>
        </div>
        
    </div>
<div>


</div>
<script>
    // 페이지가 로드될 때 폼 상태를 로컬 스토리지에서 확인하여 폼을 표시할지 말지 결정
    window.onload = function() {
        const isFormVisible = localStorage.getItem('isNewAccountFormVisible') === 'true';
        if (isFormVisible) {
            document.getElementById("new_account_form").classList.remove("mypage_hidden");
        }
    }

    // 신규 계좌 등록 버튼 클릭시 폼 토글
    document.getElementById("add_account_btn").addEventListener("click", function() {
        let newAccountForm = document.getElementById("new_account_form");
        newAccountForm.classList.toggle("mypage_hidden");
        
        // 폼의 현재 상태를 로컬 스토리지에 저장
        localStorage.setItem('isNewAccountFormVisible', !newAccountForm.classList.contains("mypage_hidden"));
    });

    // 계좌 등록 폼을 제출할 때 데이터 유효성 검사
    document.getElementById("account_form").addEventListener("submit", function(event) {
        let accountNum = document.getElementById("new_account_num").value.trim();
        
        // 숫자를 제외한 문자가 있는지 확인
        const nonNumericRegex = /[^0-9]/;
        if (nonNumericRegex.test(accountNum)) {
            alert("계좌번호에는 숫자만 입력할 수 있습니다.");
            event.preventDefault(); // 폼 제출을 중지
        }
    });

    // 편집 클릭시 AJAX 호출
    function edit_bank() {
        var tabTitle = "변경";
        
        $.ajax({
            url: "<%=ctx_Path%>/mypage/edit_bank",
            success: function(html) {
                openSideTab(html, tabTitle);
            },
            error: function(e) {
                console.log(e);
                alert("불러오기 실패");
                closeSideTab();
            }
        });
    }
    
    const checkBtn = document.querySelector(".check-btn");

    checkBtn.addEventListener("click", function() {
        checkBtn.classList.toggle("checked"); /* 체크 상태 변경 */
    });
</script>

</body>
</html>
