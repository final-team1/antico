<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<div class="container-wish">
    <c:forEach var="product" items="${product_vo}">
        <div class="product-item" onclick="goproductdetail('${product.pk_product_no}')">
            <div class="product-image">
                <img src="${product.prod_img_name}" id="prod_img" class="product-img" alt="${product.product_title}" />
            </div>

            <div class="product-info">
                <h1>제품명: ${product.product_title}</h1>

                <div>
                    <span>상세 설명: ${product.product_contents}</span>
                </div>

                <div>
                    <span>제품 상태: 
                        <c:choose>
                            <c:when test="${product.product_status == 0}">중고</c:when>
                            <c:when test="${product.product_status == 1}">새상품</c:when>
                        </c:choose>
                    </span>
                </div>

                <div class="product-price">
                    가격: <fmt:formatNumber value="${product.product_price}" pattern="#,###" /> 원
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<style>
    .container-wish {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        padding: 20px;
    }

    .product-item {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 10px;
        background-color: #fff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        font-size: 14px;
        cursor: pointer;
    }

    .product-image {
        width: 100%;
        height: 180px;
        overflow: hidden;
        border-radius: 8px;
        margin-bottom: 10px;
    }

    .product-image img {
        width: 100%;
        height: 100%;
    }

    .product-info h1 {
        font-size: 16px;
        margin-bottom: 8px;
    }

    .product-price {
        font-weight: bold;
        font-size: 14px;
        margin-top: 8px;
    }
</style>

<script>
 	// 상품 상세 페이지로 이동
	function goproductdetail(pk_product_no) {
		location.href = `<%= ctxPath%>/product/prod_detail/\${pk_product_no}`;
	}
</script>
