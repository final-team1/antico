<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String ctx_Path = request.getContextPath();
%>
<c:set var="member_vo" value="${requestScope.member_vo}" />
<c:set var="show_payment_map" value="${requestScope.show_payment_map}" />

<style>
    .purchase_container {
        padding: 1rem;
        background-color: white;
        border-radius: 0.5rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .purchase_content {
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    .product_image {
        width: 10rem;
        height: 10rem;
        object-fit: cover;
        border-radius: 0.5rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }
    .product_info {
        font-size: 1rem;
    }
    .product_title {
        font-weight: 600;
        margin-top: 15%;
    }
    .product_host {
		padding-top: 35%;
		color: green;
    }
    .product_price {
        font-size: 1.3rem;
        font-weight: bold;
        margin-top: 0.25rem;
    }
    .purchase_point {
        margin-top: 1rem;
        font-size: 1rem;
        color: #4b5563;
    }
    .purchase_button {
        width: 100%;
        margin-top: 0.75rem;
        background-color: #eee;
        border: none;
        color: white;
        padding: 0.5rem;
        border-radius: 0.5rem;
        transition: background-color 0.2s;
    }
    .purchase_button:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    .purchase_button:not(:disabled):hover {
        background-color: #34D399; /* 초록색 */
        cursor: pointer;
    }
    .less_point {
    	color: red;
    }
    .after {
    	color: #28a745;
    	font-weight: bold;
    }
</style>

<script type="text/javascript">

	
	$("span.not_enough").html(" "+(${show_payment_map.product_price}-${member_vo.member_point}).toLocaleString()+" P");
	$("span.after").html(" "+(${member_vo.member_point}-${show_payment_map.product_price}).toLocaleString()+" P");
	
	
	
</script>

<div class="purchase_container">
    
    <div class="purchase_content">
        <img src="${show_payment_map.prod_img_name}" alt="상품 이미지" class="product_image">
        <div class="product_info">
            <h3 class="product_title">${show_payment_map.product_title}</h3>
            <p class="product_host">판매자: ${show_payment_map.member_name}</p>
            <p class="product_price">
                가격: <fmt:formatNumber value="${show_payment_map.product_price}" type="number" pattern="#,###"/>원
            </p>
        </div>
    </div>
    <input type="hidden" value="${show_payment_map.product_sale_status}"/>
    
    <div class="purchase_point"> 보유 포인트: <span class="font_semibold">
            <fmt:formatNumber value="${member_vo.member_point}" type="number" pattern="#,###"/> P
        </span>
        
         <fmt:parseNumber var="parsed_product_price" value="${show_payment_map.product_price}" integerOnly="true"/>
    	<fmt:parseNumber var="parsed_member_point" value="${member_vo.member_point}" integerOnly="true"/>
    	
        <c:choose>
	        <c:when test="${parsed_member_point lt parsed_product_price}">
		        <div class="less_point">
		        	부족한 포인트 : <span class="not_enough"></span>
		        </div>
	        </c:when>
	        <c:otherwise>
	        	<div class="after_point">
		        	거래 후 남은 포인트 :<span class="after"></span>
		        </div>
	        </c:otherwise>
        </c:choose>
        
        
    </div>
    
   
    
    <c:choose>
        <c:when test="${parsed_member_point lt parsed_product_price}">
            <button class="purchase_button" disabled>잔액 부족</button>
        </c:when>
        <c:otherwise>
            <button class="purchase_button">구매하기</button>
        </c:otherwise>
    </c:choose>

</div>
