<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="bank_map" value="${requestScope.bank_map}"/>
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

<script>
$(document).ready(function() {
	
	
	
}); // end of $(document).ready(function ()}

//변경 클릭시
function mybank_list() {
	var tabTitle = "변경";
      
      $.ajax({
         url : "<%=ctx_Path%>/mypage/mybank_list",
         success : function(html) {
            openSideTab(html, tabTitle);
         },
         error : function(e) {
            closeSideTab();
         }
      });
}

</script>

<body>

    <div class="container" style="background-color: #eee;">
        <!-- 안전거래 정산/환불 계좌 및 정산내역 -->
        <div class="info_box" style="display: flex; margin-top: 20px;">
        	<span style="padding-top: 10px; font-weight: bold; font-size: 11pt;">안전거래 정산/환불 계좌 및 <br>
				정산내역을 확인하실 수 있습니다.</span>
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqC-EmTsFrLhtq9S5pSybIe7Z57Lx0JU7K4A&s" style="width:20%; margin-left: 225px;">
        </div>
		<div class="info_box1">
			<div>
				<span style="font-weight: bold; font-size: 13pt;">대표 계좌</span>
				<button class="change" onclick="mybank_list()">변경</button>
				<hr style="width: 100%; margin-top: 8px;">

				<ul class="bank_list">
					<li style="margin-top: 10px; font-weight: 550;">예금주<span style="float: right; color: #555;">${requestScope.member_name}</span></li>
					<li style="margin-top: 10px; font-weight: 550;">은행명<span style="float: right; color: #555;">${bank_map.account_bank}</span></li>
					<li style="margin-top: 10px; font-weight: 550;">계좌번호<span style="float: right; color: #555;">${bank_map.account_no}</span></li>
				</ul>
			</div>
		</div>
    </div>
    
    <div style="margin: 15px;">
    	<span style="font-weight: bold; font-size: 13pt;">정산내역</span>
    	<hr style="width: 100%; margin-top: 16px;">
    	<c:if test="${not empty requestScope.point_history_list}">
    		<c:forEach var="point_history_list" items="${requestScope.point_history_list}">
	    	<div style="letter-spacing: -0.5px;">
	    	
	    		<div style="display: flex; justify-content: space-between;">
		    		<div>${point_history_list.point_history_reason}</div> 
		    		<span style="font-weight: 500; font-size: 14pt;"><c:if test= "${point_history_list.point_history_reason eq '상품구매'}">- </c:if><fmt:formatNumber type="number" maxFractionDigits="3" value="${point_history_list.point_history_point}"/>원</span>
	    		</div>
	    		
	    		<div style="display: flex; justify-content: space-between;">
		    		<p style=" display: block; width:max-content;  font-size: 10pt; color: #aaa; padding-top: 10px;">${point_history_list.point_history_regdate}</p>
		    		<span style="font-weight: 500; font-size: 10pt; color: #0DCC5A">거래 후 잔액 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${point_history_list.point_history_point_after}"/>원</span>
	    		</div>
	    		
	    		
	    		<hr style="width: 100%; margin-top: 16px;">
	    	</div>
	    	</c:forEach>
    	 <span style="color: #aaa; font-size: 10pt; letter-spacing: -0.5px;">· 최근 1년 이내의 정산내역만 노출됩니다</span>
	    </c:if>
	    <c:if test="${empty requestScope.point_history_list}">
	    	<span style="color: #aaa; font-size: 10pt; letter-spacing: -0.5px;">포인트 내역이 없습니다.</span>
	    </c:if>
    </div>

</body>
