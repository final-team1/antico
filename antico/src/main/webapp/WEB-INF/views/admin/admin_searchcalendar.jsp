<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
%>
    
<jsp:include page=".././header/header.jsp" />

<div id="container">
    <jsp:include page=".././admin/admin_sidemenu.jsp" />
    
    <div id="content">
	    <div style="display: flex;">
	        <h3>일정 관리</h3>
	        
	        <div id="searchPart">
	             <form name="searchScheduleFrm">
	                 <div style="width: 100%; margin-left: 1%;">
	                     <input type="text" id="fromDate" name="calendar_startdate" readonly="readonly" style="width: 20%;">
	                     - 
	                     <input type="text" id="toDate" name="calendar_enddate" readonly="readonly" style="width: 20%;">
	                     
	                     <select id="searchType" name="searchType">
	                         <option value="">검색대상선택</option>
	                         <option value="calendar_title">제목</option>
	                         <option value="calendar_content">내용</option>
	                     </select>
	                     
	                     <input type="text" id="searchWord" name="searchWord">
	                     
	                     <button type="button" class="btn_normal" onclick="goSearch()">검색</button>
	                 </div>
	             </form>
	        </div>
	        
		 </div>
		 
		<table id="schedule" class="table table-hover">
		    <thead>
		        <tr>
		            <th style="text-align: center;">일자</th>
		            <th style="text-align: center;">제목</th>
		            <th style="text-align: center;">내용</th>
		            <th style="text-align: center;">장소</th>
		            <th style="text-align: center;">상세보기</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:if test="${empty requestScope.calendar_list}">
		            <tr>
		                <td colspan="5" style="text-align: center; padding: 20px;">검색 결과가 없습니다.</td>
		            </tr>
		        </c:if>
		        <c:if test="${not empty requestScope.calendar_list}">
		            <c:forEach var="map" items="${requestScope.calendar_list}">
		                <tr class="infoSchedule">
		                	<td style="display: none;" class="pk_calendar_no">${map.pk_calendar_no}</td>
		                    <td class="calendar-date">${map.calendar_startdate} - ${map.calendar_enddate}</td>
		                    <td class="calendar-title">${map.calendar_title}</td>
		                    <td class="calendar-content">${map.calendar_content}</td>
		                    <td class="calendar-place">${map.calendar_place}</td>
		                    <td style="text-align: center;">
		                        <button class="btn-detail" onclick="go_detail('${map.pk_calendar_no}')">상세보기</button>
		                    </td>
		                </tr>
		            </c:forEach>
		        </c:if>
		    </tbody>
		</table>

	</div>
</div>

<form name="goDetailFrm"> 
   <input type="hidden" name="pk_calendar_no"/>
   <input type="hidden" name="listgobackURL_schedule" value="${requestScope.listgobackURL_schedule}"/>
</form> 

<jsp:include page=".././footer/footer.jsp" />

<script type="text/javascript">
	$(document).ready(function(){
	
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true        // 콤보박스에서 년 선택 가능
	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
	    });
		
		// input 을 datepicker로 선언
	    $("input#fromDate").datepicker();                    
	    $("input#toDate").datepicker(); 
		    
	 	// From의 초기값을 한달전 날짜로 설정
	    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		
	    // To의 초기값을 한달후 날짜로 설정
	    $('input#toDate').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		    
		    
		$("tr.infoSchedule").click(function(){
			var pk_calendar_no = $(this).children(".pk_calendar_no").text();
			go_detail(pk_calendar_no);
		});
		
		// 검색 할 때 엔터를 친 경우
	    $("input#searchWord").keyup(function(event){
		   if(event.keyCode == 13){ 
			  goSearch();
		   }
	    });
	      
	    if(${not empty requestScope.paraMap}){
	    	  $("input[name=calendar_startdate]").val("${requestScope.paraMap.calendar_startdate}");
	    	  $("input[name=calendar_enddate]").val("${requestScope.paraMap.calendar_enddate}");
			  $("select#searchType").val("${requestScope.paraMap.searchType}");
			  $("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		 
	});

	function go_detail(pk_calendar_no){
		var frm = document.goDetailFrm;
		frm.pk_calendar_no.value = pk_calendar_no;		
		frm.method="get";
		frm.action="<%= ctxPath%>/admin/admin_detailcalendar";
		frm.submit();
	} // end of function goDetail(scheduleno){}-------------------------- 
	
	//=== 검색 기능 === //
	function goSearch(){
	
		if( $("#fromDate").val() > $("#toDate").val() ) {
			showAlert("click", "검색 시작날짜가 검색 종료날짜 보다 크므로 검색할 수 없습니다.");
			return;
		}
	    
		if( $("select#searchType").val()=="" && $("input#searchWord").val()!="" ) {
			showAlert("click", "검색대상 선택을 해주세요!!");
			return;
		}
		
		if( $("select#searchType").val()!="" && $("input#searchWord").val()=="" ) {
			showAlert("click", "검색어를 입력하세요!!");
			return;
		}
		
	   	var frm = document.searchScheduleFrm;
	    frm.method="get";
	    frm.action="<%= ctxPath%>/admin/admin_searchcalendar";
	    frm.submit();
		
	};
</script>

<style>
    #container {
        display: flex;
        width: 70%;
        margin: 0 auto;
    }
    #content {
    	margin-left: 3%;
    }
    h3 {
        color: #2c3e50;
        font-size: 20pt;
        font-weight: bold;
        width: 30%;
    }
    #searchPart {
        display: flex;
        border-radius: 8px;
        width: 100%;
    }
    #searchPart input, #searchPart select, #searchPart button {
        height: 30px;
        padding: 0 20px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    #searchPart button {
        padding: 4px 8px;
        background-color: #0DCC5A;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    #searchPart button:hover {
        background-color: #0056b3;
    }

	#schedule {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	}
	
	#schedule th, #schedule td {
	    padding: 12px 15px;
	    text-align: center;
	    border: 1px solid #ddd;
	    font-size: 14px;
	}
	
	#schedule th {
	    background-color: #f4f4f4;
	    color: #333;
	    font-weight: bold;
	}
	
	#schedule tr:nth-child(even) {
	    background-color: #f9f9f9;
	}
	
	#schedule tr:hover {
	    background-color: #e1f5fe;
	}
	

	.btn-detail {
	    background-color: #0DCC5A;
	    color: white;
	    padding: 6px 12px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	}
	
	.btn-detail:hover {
	    background-color: #0056b3;
	}

	#schedule td[colspan="5"] {
	    font-size: 16px;
	    color: #888;
	    padding: 30px;
	}
    
</style>