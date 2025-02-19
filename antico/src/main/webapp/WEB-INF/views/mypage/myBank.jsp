<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.info_box {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 30px;
}

.info_box1 {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 10px;
}

.change {
	float: right;
	border: solid 1px #ccc;
	color: #ccc;
	background-color: white;
	border-radius: 4px;
	font-size: 14px;
}

.bank_list {
	list-style: none;
	padding: 0;
	color: gray;
	font-size: 11pt;
}


</style>
<body>

    <div class="container" style="background-color: #eee;">
        <!-- 안전거래 정산/환불 계좌 및 정산내역 -->
        <div class="info_box" style="display: flex; margin-top: 20px;">
        	<span style="padding-top: 10px; font-weight: bold; font-size: 11pt;">안전거래 정산/환불 계좌 및 <br>
				정산내역을 확인하실 수 있습니다.</span>
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqC-EmTsFrLhtq9S5pSybIe7Z57Lx0JU7K4A&s" style="width:20%; margin-left: 190px;">
        </div>
		<div class="info_box1">
			<div>
				<span style="font-weight: bold; font-size: 13pt;">대표 계좌</span>
				<button class="change">변경</button>
				<hr style="width: 100%; margin-top: 8px;">

				<ul class="bank_list">
					<li style="margin-top: 10px; font-weight: 550;">예금주<span style="float: right; color: #555;">장민규</span></li>
					<li style="margin-top: 10px; font-weight: 550;">은행명<span style="float: right; color: #555;">토스뱅크</span></li>
					<li style="margin-top: 10px; font-weight: 550;">계좌번호<span style="float: right; color: #555;">100032806150</span></li>
				</ul>
			</div>
		</div>
    </div>
    
    <div style="margin: 15px;">
    	<span style="font-weight: bold; font-size: 13pt;">정산내역</span>
    	<hr style="width: 100%; margin-top: 16px;">
    	<div style="letter-spacing: -0.5px;">
    		망고 사진 팔아요 <span style="float:right; font-weight: 500; font-size: 16pt;">1,000원</span><br>
    		<p style="font-size: 10pt; color: #aaa; padding-top: 10px;">2025.02.18</p>
    		<hr style="width: 100%; margin-top: 16px;">
    	</div>
    	 <span style="color: #aaa; font-size: 10pt; letter-spacing: -0.5px;">· 최근 1년 이내의 정산내역만 노출됩니다</span>
    </div>

</body>
