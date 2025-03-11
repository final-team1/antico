<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<div class="container">
    <div class="product-image">
        <img src="${requestScope.product_vo.prod_img_name}" id="prod_img" class="product-img" alt="${requestScope.product_vo.product_title}" />
    </div>

    <div class="product-info">
        <h1>제품명:&nbsp;${requestScope.product_vo.product_title}</h1>

        <div>
            <span>판매자:&nbsp;${requestScope.product_vo.member_name}</span>
        </div>

        <div>
            <span>상세 설명:&nbsp;${requestScope.product_vo.product_contents}</span>
        </div>

        <div>
            <span>제품 상태:&nbsp;
                <c:if test="${requestScope.product_vo.product_status == 0}">
                    중고
                </c:if>
                <c:if test="${requestScope.product_vo.product_status == 1}">
                    새상품
                </c:if>
            </span>
        </div>

        <div class="product-price">
            가격:&nbsp;<fmt:formatNumber value="${requestScope.product_vo.product_price}" pattern="#,###" /> 원
        </div>

        <button class="delete-button">삭제하기</button>
    </div>
</div>

<style>
    .container {
        display: flex;
        justify-content: space-between;
        padding: 40px;
        margin: 0 auto;
        max-width: 1200px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .product-image {
        flex: 1;
        max-width: 50%;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        background-color: #f1f1f1;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .product-img {
        max-width: 100%;
        border-radius: 10px;
    }

    .product-info {
        flex: 1;
        max-width: 50%;
        padding: 20px;
    }

    .product-info h1 {
        font-size: 28px;
        font-weight: 600;
        color: #333;
        margin-bottom: 20px;
    }

    .product-info div {
        margin-bottom: 20px;
        font-size: 16px;
    }

    .product-info span {
        display: block;
        margin: 8px 0;
        font-size: 18px;
    }

    .product-status {
        font-weight: 500;
        font-size: 18px;
        margin-top: 10px;
        display: inline-block;
    }

    .product-status .used {
        color: #f44336;
        font-weight: bold;
    }

    .product-status .new {
        color: #4caf50;
        font-weight: bold;
    }

    .product-price {
        font-size: 24px;
        font-weight: 700;
        margin-top: 30px;
    }

    .delete-button {
        display: inline-block;
        background-color: #0DCC5A;
        color: #fff;
        padding: 10px 20px;
        font-size: 18px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 20px;
    }

    .delete-button:hover {
        background-color: #01579b;
    }
</style>
