<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%
    String ctx_Path = request.getContextPath();
%>
<title>포인트 충전</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
    </script>

</body>
