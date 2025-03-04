<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header/header.jsp" />

<div class="main-container">
    <jsp:include page="../admin/admin_sidemenu.jsp" />
    
    <div id="product_list" class="row" style="margin-left: 3%;">
        <c:if test="${not empty requestScope.admin_product_list}">
            <c:forEach var="prod_list" items="${requestScope.admin_product_list}" varStatus="status">
                <div id="card_wrap" class="col-md-6 col-lg-3 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="img_div">
                            <img src="${prod_list.prod_img_name}" id="prod_img" class="card-img-top" onclick="goProductDetail('${prod_list.pk_product_no}')" alt="${prod_list.product_title}" />
                            
                            <c:if test="${prod_list.product_sale_status == 2}">
                                <div class="sold_out_overlay" onclick="goProductDetail('${prod_list.pk_product_no}')">
                                    <span class="sold_out_text">판매완료</span>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="card-body text-center" onclick="goProductDetail('${prod_list.pk_product_no}')">
                            <div class="product_title">
                                <span class="product_title">${prod_list.product_title}</span>
                            </div>
                            <div class="product_price">
                                <span class="product_price">
                                    <fmt:formatNumber value="${prod_list.product_price}" pattern="#,###" />원
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty requestScope.admin_product_list}">
            <div id="is_no_product" class="text-center w-100">
                <span class="text-muted">상품 검색 결과가 없습니다.</span>
            </div>
        </c:if>
    </div>
</div>

<div style="height: 20px;">
	<jsp:include page="../paging.jsp"></jsp:include>
</div>

<jsp:include page="../footer/footer.jsp" />

<script type="text/javascript">
	
	// 상품상세보기
	function goProductDetail(pk_product_no) {
		var tabTitle = "상품 상세";
		
		$.ajax({
			url : "<%= ctxPath%>/admin/admin_product_detail",
			data : {"pk_product_no": pk_product_no},
			success : function(html) {
				openSideTab(html, tabTitle);
			},
			error : function(e) {
				console.log(e);
				alert("불러오기 실패");
				closeSideTab();
			}
		});		
	}
	
	//페이징 처리 버튼 이벤트
	$(document).on("click", "a.page_button", function() {
	   const page = $(this).data("page");

	   location.href = "<%= ctxPath%>/admin/admin_product_list?cur_page="+ page;
	});
	
</script>

<style>
    .main-container {
        display: flex;
        width: 70%;
        margin: 0 auto;
    }

    .card {
        border-radius: 10px;
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .img_div {
        position: relative;
        height: 200px;
        overflow: hidden;
    }

    .img_div img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .img_div:hover img {
        transform: scale(1.05);
    }

    .sold_out_overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 18px;
        font-weight: bold;
        border-radius: 10px;
        cursor: pointer;
    }

    .product_title {
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 10px;
        color: #333;
    }

    .product_price {
        font-size: 14px;
        color: #888;
    }

    .card-body {
        padding: 15px;
    }

    #is_no_product {
        padding: 50px;
        font-size: 18px;
    }

    .text-muted {
        color: #777;
    }
</style>
