<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>

<c:if test="${not empty requestScope.inquire_list}">
    <c:forEach var="InquireVO" items="${requestScope.inquire_list}" varStatus="status">
        <c:set var="member_name" value="${requestScope.member_name}" />
        
        <div class="container inquire-container ${InquireVO.inquire_secret == 1 && InquireVO.member_name != member_name ? 'blurred' : ''}">
            <div class="inquire-header">
                <div>
                    <span class="inquire-status">
                        <c:choose>
                            <c:when test="${InquireVO.inquire_status == 0}">
                                미답변
                            </c:when>
                            <c:when test="${InquireVO.inquire_status == 1}">
                                답변완료
                            </c:when>
                        </c:choose>
                    </span>

                    <p class="inquire-title">${InquireVO.inquire_title}</p>
                    <span class="inquire-details">
                        <span>${InquireVO.member_name}</span>
                        &nbsp;|&nbsp;
                        <span>${InquireVO.inquire_regdate}</span>
                        &nbsp;|&nbsp;
                        <span>
                            <c:choose>
                                <c:when test="${InquireVO.inquire_secret == 0}">
                                    공개
                                </c:when>
                                <c:when test="${InquireVO.inquire_secret == 1}">
                                    <c:choose>
                                        <c:when test="${InquireVO.member_name == member_name}">
                                            비공개
                                        </c:when>
                                        <c:otherwise>
                                            <div class="blurred-background">
                                            	<span class="blurred-text">비공개 글입니다</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </span>
                    </span>        
                </div>
                <div class="detail-icon">
                    <i class="fa-solid fa-chevron-right" onclick="showinquiredetailTab('${InquireVO.pk_inquire_no}', ${InquireVO.inquire_secret == 1 && InquireVO.member_name != member_name})"></i>                
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>

<script>
	// 1:1 문의 상세보기 함수
	function showinquiredetailTab(pk_inquire_no, isSecret) {
		var tabTitle = "문의내역 상세";
		
		$.ajax({
			url : "<%= ctxPath%>/inquire/inquire_detail",
			data : {"pk_inquire_no": pk_inquire_no},
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
</script>



<style>
	/* 문의 항목 컨테이너 */
	.inquire-container {
	    padding: 15px;
	    border-bottom: 2px solid #000;
	}
	
	/* 문의 항목 헤더 */
	.inquire-header {
	    display: flex;
	    width: 100%;
	    justify-content: space-between;
	}
	
	/* 문의 상태 스타일 */
	.inquire-status {
	    display: inline-block;
	    font-size: 10pt;
	    background-color: black;
	    color: white;
	    padding: 1% 1%;
	    border: 1px solid;
	    text-align: center;
	    border-radius: 4px;
	    margin-bottom: 8%;
	}
	
	/* 문의 제목 스타일 */
	.inquire-title {
	    font-size: 12pt;
	    margin-bottom: 5%;
	}
	
	/* 문의 세부 사항 (회원 번호, 등록 날짜, 공개 여부) */
	.inquire-details {
	    display: flex;
	    font-size: 8pt;
	}
	
	/* 세부 아이콘 (상세보기 버튼) */
	.detail-icon {
	    margin-top: 5%;
	    cursor: pointer;
	}
	
	/* 아이콘 클릭 시 커서 모양 변경 */
	.detail-icon i {
	    cursor: pointer;
	}

	.blurred {
	    filter: blur(3px);
	    pointer-events: none;
	    position: relative;
	    overflow: hidden;
	}

	.blurred-background {
	    position: absolute;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background: rgba(255, 255, 255, 0.5);
	    filter: blur(3px);
	    z-index: 0; /* 이 값을 낮춰서 배경 요소가 텍스트보다 뒤에 오게 함 */
	}
	
	.blurred-text {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    color: gray;
	    font-weight: bold;
	    font-size: 16px;
	    z-index: 9999; /* 이 값을 높여서 텍스트가 가장 위에 오게 설정 */
	    background-color: rgba(255, 255, 255, 0.8);
	    padding: 10px;
	    border-radius: 5px;
	}



</style>











