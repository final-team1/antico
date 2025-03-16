<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="ctx_Path" value="${pageContext.request.contextPath}" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Pretendard Variable", sans-serif;
    }

    .side-tab-container {
        width: 100%;
        height: 100%;
        background-color: #f4f4f4;
        padding: 30px 20px;
        overflow-y: auto;
    }
    .trade-wrap {
        background: #fff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    .trade-timeline {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        padding-bottom: 10px;
        border-bottom: 2px solid #e1e1e1;
    }

    .trade-item {
        display: flex;
        width: 100%;
        max-width: 600px;
        background: #fff;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        margin: 10px 0;
    }
    
    .trade-item:hover {
    	cursor: pointer;
    }

    .trade-item img {
        width: 100px;
        height: 90px;
        border-radius: 8px;
        object-fit: cover;
        margin-right: 15px;
    }

    .trade-item-content {
        flex-grow: 1;
        margin: 15px;
    }

    .trade-item-title {
        font-size: 20px;
        color: #333;
        font-weight: bold;
    }

    .trade-item-price {
        font-size: 18px;
        color: #e74c3c;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .trade-item-details {
        font-size: 14px;
        color: #7f8c8d;
    }

    .status-badge {
        background-color: #27ae60;
        color: white;
        padding: 6px 12px;
        border-radius: 12px;
        font-size: 14px;
        font-weight: bold;
        margin-left: 15px;
        align-self: center;
    }

    .seller-info {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .seller-info h3 {
        font-size: 18px;
        color: #333;
        margin-bottom: 10px;
    }

    .seller-info p {
        font-size: 14px;
        color: #7f8c8d;
        margin-bottom: 5px;
    }

    .review-btn {
        background-color: white;
        color: rgb(13, 204, 90);
        padding: 8px 16px;
        border-radius: 5px;
        border: solid 1px rgb(13, 204, 90);
        font-size: 14px;
        cursor: pointer;
        margin-top: 20px;
    }

    .review-btn:hover {
        background-color: rgb(13, 204, 90);
        color: white;
    }
    
	/* 구매자 정보 */
    .consumer-info {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    	margin-top: 30px;
    }

    .consumer-info h3 {
        font-size: 18px;
        color: #333;
        margin-bottom: 10px;
    }

    .consumer-info p {
        font-size: 14px;
        color: #7f8c8d;
        margin-bottom: 5px;
    }
    
    .consumer-info:hover {
    	cursor: pointer;
    }
</style>

<div class="side-tab-container">
    <div class="trade-wrap">
	<h5>거래번호: ${requestScope.Info_buy.pk_trade_no}</h5> 
        <div class="trade-timeline">
            <div class="trade-item" onclick="window.location.href='<%= ctx_Path %>/product/prod_detail/${requestScope.Info_buy.pk_product_no}'">
                <img src="${requestScope.Info_buy.prod_img_name}" alt="상품 이미지" />
                <div class="trade-item-content">
                    <p class="trade-item-title">${requestScope.Info_buy.product_title}</p>
                    <p class="trade-item-price">
                        <fmt:formatNumber value="${requestScope.Info_buy.product_price}" pattern="#,###" /> 원
                    </p>
                    
                    <p class="trade-item-details">결제일시: ${requestScope.Info_buy.trade_confirm_date}</p>
                </div>
                <span class="status-badge">구매 완료</span>
            </div>
        </div>

        <button class="review-btn">받은 후기</button>
    </div>

    <div class="seller-info">
        <h3>판매자 정보</h3>
        <p>판매자 성명: ${requestScope.Info_buy.seller_name}</p>
    </div>
   
    <div class="consumer-info" onclick="window.location.href='<%= ctx_Path %>/mypage/mypagemain/${requestScope.Info_buy.fk_consumer_no}'">
    	<h3>구매자 정보</h3>
        <p>구매자 성명: ${requestScope.Info_buy.consumer_name}</p>
    </div>
</div>
