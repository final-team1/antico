<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%
    String ctx_Path = request.getContextPath();
%>
<title>포인트 충전</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<style>
    body {
        background-color: #f8f9fa;
    }
    .charge-container {
        max-width: 500px;
        margin: 50px auto;
        padding: 30px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .charge-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        text-align: center;
        margin-bottom: 20px;
    }
    .charge-btn {
        background-color: #A4D037;
        border: none;
        color: white;
        font-size: 18px;
        padding: 10px;
        width: 100%;
        border-radius: 5px;
        transition: 0.3s;
    }
    .charge-btn:hover {
        background-color: #8CB92D;
    }
    .amount-box {
        display: flex;
        justify-content: space-between;
        margin-top: 15px;
    }
    .amount-box button {
        width: 30%;
        background: #E0E0E0;
        border: none;
        padding: 10px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }
    .amount-box button:hover {
        background: #BDBDBD;
    }
    .user-info {
        font-size: 16px;
        color: #555;
        text-align: center;
        margin-bottom: 10px;
    }
    .commission-table {
        margin-top: 20px;
        width: 100%;
        border-collapse: collapse;
    }
    .commission-table th, .commission-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    .commission-table th {
        background-color: #f8f9fa;
    }
</style>



</head>
<body>

    <div class="charge-container">
        <div class="charge-title">포인트 충전</div>
        <div class="user-info">회원 ID: <strong><%= ctx_Path %></strong></div>

        <form action="charge_process.jsp" method="post">
            <label for="amount" class="form-label">충전 금액 선택</label>
            <span style="float: right; color: rgba(0, 0, 0, 0.5);">충전단위는 1000원입니다.</span>
            <input type="number" step="1000" id="amount" name="amount" class="form-control" placeholder="금액을 입력하세요" required oninput="updateCommissionAmounts()">

            <div class="amount-box">
                <button type="button" onclick="increaseAmount(10000)">10,000원</button>
                <button type="button" onclick="increaseAmount(50000)">50,000원</button>
                <button type="button" onclick="increaseAmount(100000)">100,000원</button>
            </div>

            <input type="hidden" name="member_user_id" value="<%= ctx_Path %>">

            <button type="submit" class="charge-btn mt-3">충전하기</button>
        </form>

        <div>
            <h5>등급별 수수료</h5>
            <table class="commission-table">
                <thead>
                    <tr>
                        <th>등급</th>
                        <th>수수료 (%)</th>
                        <th>적용 후 금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>골드</td>
                        <td>3%</td>
                        <td><span id="gold-amount">0원</span></td>
                    </tr>
                    <tr>
                        <td>실버</td>
                        <td>4%</td>
                        <td><span id="silver-amount">0원</span></td>
                    </tr>
                    <tr>
                        <td>브론즈</td>
                        <td>5%</td>
                        <td><span id="bronze-amount">0원</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</body>

    <script>
        function increaseAmount(value) {
            var amountInput = document.getElementById('amount');
            var currentAmount = parseInt(amountInput.value) || 0;  // 입력된 값이 없으면 0으로 처리
            var newAmount = currentAmount + value;
            amountInput.value = newAmount;  // 새로운 금액을 입력란에 설정
            updateCommissionAmounts();  // 수수료 계산 후 표시
        }

        function updateCommissionAmounts() {
            var amountInput = document.getElementById('amount');
            var amount = parseInt(amountInput.value) || 0;

            // 각 등급별 수수료를 적용한 금액 계산
            var goldAmount = amount - (amount * 0.03);  // 3% 수수료
            var silverAmount = amount - (amount * 0.04);  // 4% 수수료
            var bronzeAmount = amount - (amount * 0.05);  // 5% 수수료

            // 계산된 금액을 표시
            document.getElementById('gold-amount').textContent = goldAmount + '원';
            document.getElementById('silver-amount').textContent = silverAmount + '원';
            document.getElementById('bronze-amount').textContent = bronzeAmount + '원';
        }
        
        
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelector(".charge-btn").addEventListener("click", function (event) {
                event.preventDefault(); // 기본 폼 제출 방지

                const IMP = window.IMP;
                IMP.init("${requestScope.pointcharge_chargekey}"); // 가맹점 식별코드

                const productName = "포인트 충전";
                const amountInput = document.getElementById("amount");
                const chargeAmount = parseInt(amountInput.value, 10); // 충전 금액
                const memberUserId = document.querySelector('input[name="member_user_id"]').value; // 회원 ID 가져오기

                if (!chargeAmount || chargeAmount < 1000) {
                    alert("충전 금액을 1000원 이상 입력해주세요.");
                    return;
                }

                IMP.request_pay(
                    {
                        pg: "html5_inicis", // PG사 선택
                        pay_method: "card", // 결제 방식 (카드, 계좌이체 등)
                        merchant_uid: "merchant_" + new Date().getTime(), // 주문번호 (고유값)
                        name: productName, // 주문명
                        amount: chargeAmount, // 결제 금액
                        buyer_name: memberUserId, // 구매자 이름 (회원 ID)
                        buyer_tel: "", // 구매자 전화번호 (필요시 추가)
                        buyer_addr: "", // 구매자 주소 (필요시 추가)
                        buyer_postcode: "" // 구매자 우편번호 (필요시 추가)
                    },
                    function (rsp) {
                        if (rsp.success) {
                            // 결제 성공 시 서버로 데이터 전송
                            fetch("<%= ctx_Path %>/mypage/chargeComplete", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                body: JSON.stringify({
                                    memberUserId: memberUserId,
                                    chargeAmount: chargeAmount,
                                    imp_uid: rsp.imp_uid, // 결제 고유번호
                                    merchant_uid: rsp.merchant_uid // 주문번호
                                })
                            })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert("충전이 완료되었습니다.");
                                    window.location.href = "<%= ctx_Path %>/mypage"; // 마이페이지로 이동
                                } else {
                                    alert("충전은 완료되었으나 서버 처리에 실패했습니다. 고객센터로 문의해주세요.");
                                }
                            })
                            .catch(error => {
                                alert("충전 처리 중 오류가 발생했습니다.");
                                console.error("Error:", error);
                            });
                        } else {
                            alert(`결제에 실패하였습니다: ${rsp.error_msg}`);
                        }
                    }
                );
            });
        });

    </script>
