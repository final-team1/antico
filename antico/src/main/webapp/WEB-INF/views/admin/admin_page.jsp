<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
%>

<script src='<%=ctxPath%>/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath%>/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<link href='<%=ctxPath %>/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />

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
        <div id="wrapper">
            <div id="calendar"></div>
        </div>			
    </div>
</div>

<form name="dateFrm">
	<input type="hidden" name="choose_date" />	
</form>	

<jsp:include page=".././footer/footer.jsp" />

<script type="text/javascript">
    $(document).ready(function() {
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd',
            showOtherMonths: true,
            showMonthAfterYear:true,
            changeYear: true,
            changeMonth: true,
            monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
        });
        
        $("input#fromDate").datepicker();                    
        $("input#toDate").datepicker();
        $('input#fromDate').datepicker('setDate', '-1M');
        $('input#toDate').datepicker('setDate', '+1M');
        
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            googleCalendarApiKey : "AIzaSyASM5hq3PTF2dNRmliR_rXpjqNqC-6aPbQ",
            eventSources :[ 
                {
                    googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com',
                    color: 'white',
                    textColor: 'red'
                } 
            ],
            initialView: 'dayGridMonth',
            locale: 'ko',
            selectable: true,
            editable: false,
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth dayGridWeek dayGridDay'
            },
            dayMaxEventRows: true,
            views: {
                timeGrid: {
                    dayMaxEventRows: 3
                }
            },
            events:function(info, successCallback, failureCallback) {
            	
   	    	 $.ajax({
                    url: '<%= ctxPath%>/admin/admin_selectcalendar',
                    dataType: "json",
                    success:function(json) {

                   	 var events = [];
                        if(json.length > 0){
                            
                        	$.each(json, function(index, item) {
                        	    var calendar_startdate = moment(item.calendar_startdate).format('YYYY-MM-DD HH:mm:ss');
                        	    var calendar_enddate = moment(item.calendar_enddate).format('YYYY-MM-DD HH:mm:ss');
                        	    var calendar_title = item.calendar_title;

                        	    events.push({
                        	        id: item.pk_calendar_no,
                        	        title: calendar_title,
                        	        start: calendar_startdate,
                        	        end: calendar_enddate,
                        	        url: "<%= ctxPath%>/admin/admin_detailcalendar?pk_calendar_no=" + item.pk_calendar_no
                        	    });
                        	});

                        }                                                  
                        successCallback(events);                               
                     },
   				  error: function(request, status, error){
   			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   			      }	
                                               
             }); // end of $.ajax()--------------------------------
           
           },
            // 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
            dateClick: function(info) {
       	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
       	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
       	    $("form > input[name=choose_date]").val(info.dateStr);
       	    
       	    var frm = document.dateFrm;
       	    frm.method="POST";
       	    frm.action="<%= ctxPath%>/admin/admin_insertcalendar";
       	    frm.submit();
       	  },
        });
        
        calendar.render();
        
     	// 검색 할 때 엔터를 친 경우
        $("input#searchWord").keyup(function(event){
      	 if(event.keyCode == 13){ 
      		 goSearch();
      	 }
        });
    });
    
 	// === 검색 기능 === //
    function goSearch(){

    	if( $("#fromDate").val() > $("#toDate").val() ) {
    		alert("검색 시작날짜가 검색 종료날짜 보다 크므로 검색할 수 없습니다.");
    		return;
    	}
        
    	if( $("select#searchType").val()=="" && $("input#searchWord").val()!="" ) {
    		alert("검색대상 선택을 해주세요!!");
    		return;
    	}
    	
    	if( $("select#searchType").val()!="" && $("input#searchWord").val()=="" ) {
    		alert("검색어를 입력하세요!!");
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
    
    #calendar {
        width: 100%;
        height: 450px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        border-radius: 10px;
        overflow: hidden;
    }
</style>
